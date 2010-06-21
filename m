Return-Path: <paulus@ozlabs.org>
Date: Mon, 21 Jun 2010 15:03:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Rework VDSO gettimeofday to prevent time going
	backwards
Message-ID: <20100621050308.GA12055@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently it is possible for userspace to see the result of
gettimeofday() going backwards by 1 microsecond, assuming that
userspace is using the gettimeofday() in the VDSO.  The VDSO
gettimeofday() algorithm computes the time in "xsecs", which are
units of 2^-20 seconds, or approximately 0.954 microseconds,
using the algorithm

	now = (timebase - tb_orig_stamp) * tb_to_xs + stamp_xsec

and then converts the time in xsecs to seconds and microseconds.

The kernel updates the tb_orig_stamp and stamp_xsec values every
tick in update_vsyscall().  If the length of the tick is not an
integer number of xsecs, then some precision is lost in converting
the current time to xsecs.  For example, with CONFIG_HZ=1000, the
tick is 1ms long, which is 1048.576 xsecs.  That means that
stamp_xsec will advance by either 1048 or 1049 on each tick.
With the right conditions, it is possible for userspace to get
(timebase - tb_orig_stamp) * tb_to_xs being 1049 if the kernel is
slightly late in updating the vdso_datapage, and then for stamp_xsec
to advance by 1048 when the kernel does update it, and for userspace
to then see (timebase - tb_orig_stamp) * tb_to_xs being zero due to
integer truncation.  The result is that time appears to go backwards
by 1 microsecond.

To fix this we change the VDSO gettimeofday to use a new field in the
VDSO datapage which stores the nanoseconds part of the time as a
fractional number of seconds in a 0.32 binary fraction format.
(Or put another way, as a 32-bit number in units of 0.23283 ns.)
This is convenient because we can use the mulhwu instruction to
convert it to either microseconds or nanoseconds.

Since it turns out that computing the time of day using this new field
is simpler than either using stamp_xsec (as gettimeofday does) or
stamp_xtime.tv_nsec (as clock_gettime does), this converts both
gettimeofday and clock_gettime to use the new field.  The existing
__do_get_tspec function is converted to use the new field and take
a parameter in r7 that indicates the desired resolution, 1,000,000
for microseconds or 1,000,000,000 for nanoseconds.  The __do_get_xsec
function is then unused and is deleted.

The new algorithm is

	now = ((timebase - tb_orig_stamp) << 12) * tb_to_xs
		+ (stamp_xtime_seconds << 32) + stamp_sec_fraction

with 'now' in units of 2^-32 seconds.  That is then converted to
seconds and either microseconds or nanoseconds with

	seconds = now >> 32
	partseconds = ((now & 0xffffffff) * resolution) >> 32

The 32-bit VDSO code also makes a further simplification: it ignores
the bottom 32 bits of the tb_to_xs value, which is a 0.64 format binary
fraction.  Doing so gets rid of 4 multiply instructions.  Assuming
a timebase frequency of 1GHz or less and an update interval of no
more than 10ms, the upper 32 bits of tb_to_xs will be at least
4503599, so the error from ignoring the low 32 bits will be at most
2.2ns, which is more than an order of magnitude less than the time
taken to do gettimeofday or clock_gettime on our fastest processors,
so there is no possibility of seeing inconsistent values due to this.

This also moves update_gtod() down next to its only caller, and makes
update_vsyscall use the time passed in via the wall_time argument rather
than accessing xtime directly.  At present, wall_time always points to
xtime, but that could change in future.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/vdso_datapage.h  |    2 +
 arch/powerpc/kernel/asm-offsets.c         |    1 +
 arch/powerpc/kernel/time.c                |   61 ++++++----
 arch/powerpc/kernel/vdso32/gettimeofday.S |  184 +++++++----------------------
 arch/powerpc/kernel/vdso64/gettimeofday.S |   88 +++-----------
 5 files changed, 99 insertions(+), 237 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 13c2c28..08679c5 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -85,6 +85,7 @@ struct vdso_data {
 	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
 	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
+	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 };
@@ -105,6 +106,7 @@ struct vdso_data {
 	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
 	struct timespec stamp_xtime;	/* xtime as at tb_orig_stamp */
+	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
 	__u32 dcache_block_size;	/* L1 d-cache block size     */
 	__u32 icache_block_size;	/* L1 i-cache block size     */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 496cc5b..acbbac6 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -342,6 +342,7 @@ int main(void)
 	DEFINE(WTOM_CLOCK_SEC, offsetof(struct vdso_data, wtom_clock_sec));
 	DEFINE(WTOM_CLOCK_NSEC, offsetof(struct vdso_data, wtom_clock_nsec));
 	DEFINE(STAMP_XTIME, offsetof(struct vdso_data, stamp_xtime));
+	DEFINE(STAMP_SEC_FRAC, offsetof(struct vdso_data, stamp_sec_fraction));
 	DEFINE(CFG_ICACHE_BLOCKSZ, offsetof(struct vdso_data, icache_block_size));
 	DEFINE(CFG_DCACHE_BLOCKSZ, offsetof(struct vdso_data, dcache_block_size));
 	DEFINE(CFG_ICACHE_LOGBLOCKSZ, offsetof(struct vdso_data, icache_log_block_size));
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0441bbd..5adebaf 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -423,30 +423,6 @@ void udelay(unsigned long usecs)
 }
 EXPORT_SYMBOL(udelay);
 
-static inline void update_gtod(u64 new_tb_stamp, u64 new_stamp_xsec,
-			       u64 new_tb_to_xs)
-{
-	/*
-	 * tb_update_count is used to allow the userspace gettimeofday code
-	 * to assure itself that it sees a consistent view of the tb_to_xs and
-	 * stamp_xsec variables.  It reads the tb_update_count, then reads
-	 * tb_to_xs and stamp_xsec and then reads tb_update_count again.  If
-	 * the two values of tb_update_count match and are even then the
-	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
-	 * loops back and reads them again until this criteria is met.
-	 * We expect the caller to have done the first increment of
-	 * vdso_data->tb_update_count already.
-	 */
-	vdso_data->tb_orig_stamp = new_tb_stamp;
-	vdso_data->stamp_xsec = new_stamp_xsec;
-	vdso_data->tb_to_xs = new_tb_to_xs;
-	vdso_data->wtom_clock_sec = wall_to_monotonic.tv_sec;
-	vdso_data->wtom_clock_nsec = wall_to_monotonic.tv_nsec;
-	vdso_data->stamp_xtime = xtime;
-	smp_wmb();
-	++(vdso_data->tb_update_count);
-}
-
 #ifdef CONFIG_SMP
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -873,10 +849,37 @@ static cycle_t timebase_read(struct clocksource *cs)
 	return (cycle_t)get_tb();
 }
 
+static inline void update_gtod(u64 new_tb_stamp, u64 new_stamp_xsec,
+			       u64 new_tb_to_xs, struct timespec *now,
+			       u32 frac_sec)
+{
+	/*
+	 * tb_update_count is used to allow the userspace gettimeofday code
+	 * to assure itself that it sees a consistent view of the tb_to_xs and
+	 * stamp_xsec variables.  It reads the tb_update_count, then reads
+	 * tb_to_xs and stamp_xsec and then reads tb_update_count again.  If
+	 * the two values of tb_update_count match and are even then the
+	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
+	 * loops back and reads them again until this criteria is met.
+	 * We expect the caller to have done the first increment of
+	 * vdso_data->tb_update_count already.
+	 */
+	vdso_data->tb_orig_stamp = new_tb_stamp;
+	vdso_data->stamp_xsec = new_stamp_xsec;
+	vdso_data->tb_to_xs = new_tb_to_xs;
+	vdso_data->wtom_clock_sec = wall_to_monotonic.tv_sec;
+	vdso_data->wtom_clock_nsec = wall_to_monotonic.tv_nsec;
+	vdso_data->stamp_xtime = *now;
+	vdso_data->stamp_sec_fraction = frac_sec;
+	smp_wmb();
+	++(vdso_data->tb_update_count);
+}
+
 void update_vsyscall(struct timespec *wall_time, struct clocksource *clock,
 		     u32 mult)
 {
 	u64 t2x, stamp_xsec;
+	u32 frac_sec;
 
 	if (clock != &clocksource_timebase)
 		return;
@@ -888,10 +891,14 @@ void update_vsyscall(struct timespec *wall_time, struct clocksource *clock,
 	/* XXX this assumes clock->shift == 22 */
 	/* 4611686018 ~= 2^(20+64-22) / 1e9 */
 	t2x = (u64) mult * 4611686018ULL;
-	stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
+	stamp_xsec = (u64) wall_time->tv_nsec * XSEC_PER_SEC;
 	do_div(stamp_xsec, 1000000000);
-	stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
-	update_gtod(clock->cycle_last, stamp_xsec, t2x);
+	stamp_xsec += (u64) wall_time->tv_sec * XSEC_PER_SEC;
+
+	BUG_ON(wall_time->tv_nsec >= NSEC_PER_SEC);
+	/* this is tv_nsec / 1e9 as a 0.32 fraction */
+	frac_sec = ((u64) wall_time->tv_nsec * 18446744073ULL) >> 32;
+	update_gtod(clock->cycle_last, stamp_xsec, t2x, wall_time, frac_sec);
 }
 
 void update_vsyscall_tz(void)
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index ee038d4..4ee09ee 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -19,8 +19,10 @@
 /* Offset for the low 32-bit part of a field of long type */
 #ifdef CONFIG_PPC64
 #define LOPART	4
+#define TSPEC_TV_SEC	TSPC64_TV_SEC+LOPART
 #else
 #define LOPART	0
+#define TSPEC_TV_SEC	TSPC32_TV_SEC
 #endif
 
 	.text
@@ -41,23 +43,11 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mr	r9, r3			/* datapage ptr in r9 */
 	cmplwi	r10,0			/* check if tv is NULL */
 	beq	3f
-	bl	__do_get_xsec@local	/* get xsec from tb & kernel */
-	bne-	2f			/* out of line -> do syscall */
-
-	/* seconds are xsec >> 20 */
-	rlwinm	r5,r4,12,20,31
-	rlwimi	r5,r3,12,0,19
-	stw	r5,TVAL32_TV_SEC(r10)
-
-	/* get remaining xsec and convert to usec. we scale
-	 * up remaining xsec by 12 bits and get the top 32 bits
-	 * of the multiplication
-	 */
-	rlwinm	r5,r4,12,0,19
-	lis	r6,1000000@h
-	ori	r6,r6,1000000@l
-	mulhwu	r5,r5,r6
-	stw	r5,TVAL32_TV_USEC(r10)
+	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
+	addi	r7,r7,1000000@l		/* so we get microseconds in r4 */
+	bl	__do_get_tspec@local	/* get sec/usec from tb & kernel */
+	stw	r3,TVAL32_TV_SEC(r10)
+	stw	r4,TVAL32_TV_USEC(r10)
 
 3:	cmplwi	r11,0			/* check if tz is NULL */
 	beq	1f
@@ -70,14 +60,6 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	crclr	cr0*4+so
 	li	r3,0
 	blr
-
-2:
-	mtlr	r12
-	mr	r3,r10
-	mr	r4,r11
-	li	r0,__NR_gettimeofday
-	sc
-	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_gettimeofday)
 
@@ -100,7 +82,8 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	mr	r11,r4			/* r11 saves tp */
 	bl	__get_datapage@local	/* get data page */
 	mr	r9,r3			/* datapage ptr in r9 */
-
+	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
+	ori	r7,r7,NSEC_PER_SEC@l
 50:	bl	__do_get_tspec@local	/* get sec/nsec from tb & kernel */
 	bne	cr1,80f			/* not monotonic -> all done */
 
@@ -198,83 +181,12 @@ V_FUNCTION_END(__kernel_clock_getres)
 
 
 /*
- * This is the core of gettimeofday() & friends, it returns the xsec
- * value in r3 & r4 and expects the datapage ptr (non clobbered)
- * in r9. clobbers r0,r4,r5,r6,r7,r8.
- * When returning, r8 contains the counter value that can be reused
- * by the monotonic clock implementation
- */
-__do_get_xsec:
-  .cfi_startproc
-	/* Check for update count & load values. We use the low
-	 * order 32 bits of the update count
-	 */
-1:	lwz	r8,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
-	andi.	r0,r8,1			/* pending update ? loop */
-	bne-	1b
-	xor	r0,r8,r8		/* create dependency */
-	add	r9,r9,r0
-
-	/* Load orig stamp (offset to TB) */
-	lwz	r5,CFG_TB_ORIG_STAMP(r9)
-	lwz	r6,(CFG_TB_ORIG_STAMP+4)(r9)
-
-	/* Get a stable TB value */
-2:	mftbu	r3
-	mftbl	r4
-	mftbu	r0
-	cmpl	cr0,r3,r0
-	bne-	2b
-
-	/* Substract tb orig stamp. If the high part is non-zero, we jump to
-	 * the slow path which call the syscall.
-	 * If it's ok, then we have our 32 bits tb_ticks value in r7
-	 */
-	subfc	r7,r6,r4
-	subfe.	r0,r5,r3
-	bne-	3f
-
-	/* Load scale factor & do multiplication */
-	lwz	r5,CFG_TB_TO_XS(r9)	/* load values */
-	lwz	r6,(CFG_TB_TO_XS+4)(r9)
-	mulhwu	r4,r7,r5
-	mulhwu	r6,r7,r6
-	mullw	r0,r7,r5
-	addc	r6,r6,r0
-
-	/* At this point, we have the scaled xsec value in r4 + XER:CA
-	 * we load & add the stamp since epoch
-	 */
-	lwz	r5,CFG_STAMP_XSEC(r9)
-	lwz	r6,(CFG_STAMP_XSEC+4)(r9)
-	adde	r4,r4,r6
-	addze	r3,r5
-
-	/* We now have our result in r3,r4. We create a fake dependency
-	 * on that result and re-check the counter
-	 */
-	or	r6,r4,r3
-	xor	r0,r6,r6
-	add	r9,r9,r0
-	lwz	r0,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
-        cmpl    cr0,r8,r0		/* check if updated */
-	bne-	1b
-
-	/* Warning ! The caller expects CR:EQ to be set to indicate a
-	 * successful calculation (so it won't fallback to the syscall
-	 * method). We have overriden that CR bit in the counter check,
-	 * but fortunately, the loop exit condition _is_ CR:EQ set, so
-	 * we can exit safely here. If you change this code, be careful
-	 * of that side effect.
-	 */
-3:	blr
-  .cfi_endproc
-
-/*
- * This is the core of clock_gettime(), it returns the current
- * time in seconds and nanoseconds in r3 and r4.
+ * This is the core of clock_gettime() and gettimeofday(),
+ * it returns the current time in r3 (seconds) and r4.
+ * On entry, r7 gives the resolution of r4, either USEC_PER_SEC
+ * or NSEC_PER_SEC, giving r4 in microseconds or nanoseconds.
  * It expects the datapage ptr in r9 and doesn't clobber it.
- * It clobbers r0, r5, r6, r10 and returns NSEC_PER_SEC in r7.
+ * It clobbers r0, r5 and r6.
  * On return, r8 contains the counter value that can be reused.
  * This clobbers cr0 but not any other cr field.
  */
@@ -297,70 +209,58 @@ __do_get_tspec:
 2:	mftbu	r3
 	mftbl	r4
 	mftbu	r0
-	cmpl	cr0,r3,r0
+	cmplw	cr0,r3,r0
 	bne-	2b
 
 	/* Subtract tb orig stamp and shift left 12 bits.
 	 */
-	subfc	r7,r6,r4
+	subfc	r4,r6,r4
 	subfe	r0,r5,r3
 	slwi	r0,r0,12
-	rlwimi.	r0,r7,12,20,31
-	slwi	r7,r7,12
+	rlwimi.	r0,r4,12,20,31
+	slwi	r4,r4,12
 
-	/* Load scale factor & do multiplication */
+	/*
+	 * Load scale factor & do multiplication.
+	 * We only use the high 32 bits of the tb_to_xs value.
+	 * Even with a 1GHz timebase clock, the high 32 bits of
+	 * tb_to_xs will be at least 4 million, so the error from
+	 * ignoring the low 32 bits will be no more than 0.25ppm.
+	 * The error will just make the clock run very very slightly
+	 * slow until the next time the kernel updates the VDSO data,
+	 * at which point the clock will catch up to the kernel's value,
+	 * so there is no long-term error accumulation.
+	 */
 	lwz	r5,CFG_TB_TO_XS(r9)	/* load values */
-	lwz	r6,(CFG_TB_TO_XS+4)(r9)
-	mulhwu	r3,r7,r6
-	mullw	r10,r7,r5
-	mulhwu	r4,r7,r5
-	addc	r10,r3,r10
+	mulhwu	r4,r4,r5
 	li	r3,0
 
 	beq+	4f			/* skip high part computation if 0 */
 	mulhwu	r3,r0,r5
-	mullw	r7,r0,r5
-	mulhwu	r5,r0,r6
-	mullw	r6,r0,r6
-	adde	r4,r4,r7
-	addze	r3,r3
+	mullw	r5,r0,r5
 	addc	r4,r4,r5
 	addze	r3,r3
-	addc	r10,r10,r6
-
-4:	addze	r4,r4			/* add in carry */
-	lis	r7,NSEC_PER_SEC@h
-	ori	r7,r7,NSEC_PER_SEC@l
-	mulhwu	r4,r4,r7		/* convert to nanoseconds */
-
-	/* At this point, we have seconds & nanoseconds since the xtime
-	 * stamp in r3+CA and r4.  Load & add the xtime stamp.
+4:
+	/* At this point, we have seconds since the xtime stamp
+	 * as a 32.32 fixed-point number in r3 and r4.
+	 * Load & add the xtime stamp.
 	 */
-#ifdef CONFIG_PPC64
-	lwz	r5,STAMP_XTIME+TSPC64_TV_SEC+LOPART(r9)
-	lwz	r6,STAMP_XTIME+TSPC64_TV_NSEC+LOPART(r9)
-#else
-	lwz	r5,STAMP_XTIME+TSPC32_TV_SEC(r9)
-	lwz	r6,STAMP_XTIME+TSPC32_TV_NSEC(r9)
-#endif
-	add	r4,r4,r6
+	lwz	r5,STAMP_XTIME+TSPEC_TV_SEC(r9)
+	lwz	r6,STAMP_SEC_FRAC(r9)
+	addc	r4,r4,r6
 	adde	r3,r3,r5
 
-	/* We now have our result in r3,r4. We create a fake dependency
-	 * on that result and re-check the counter
+	/* We create a fake dependency on the result in r3/r4
+	 * and re-check the counter
 	 */
 	or	r6,r4,r3
 	xor	r0,r6,r6
 	add	r9,r9,r0
 	lwz	r0,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
-        cmpl    cr0,r8,r0		/* check if updated */
+        cmplw	cr0,r8,r0		/* check if updated */
 	bne-	1b
 
-	/* check for nanosecond overflow and adjust if necessary */
-	cmpw	r4,r7
-	bltlr				/* all done if no overflow */
-	subf	r4,r7,r4		/* adjust if overflow */
-	addi	r3,r3,1
+	mulhwu	r4,r4,r7		/* convert to micro or nanoseconds */
 
 	blr
   .cfi_endproc
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 262cd58..e97a9a0 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -33,18 +33,11 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
 	cmpldi	r11,0			/* check if tv is NULL */
 	beq	2f
-	bl	V_LOCAL_FUNC(__do_get_xsec)	/* get xsec from tb & kernel */
-	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
-	ori     r7,r7,16960
-	rldicl  r5,r4,44,20		/* r5 = sec = xsec / XSEC_PER_SEC */
-	rldicr  r6,r5,20,43		/* r6 = sec * XSEC_PER_SEC */
-	std	r5,TVAL64_TV_SEC(r11)	/* store sec in tv */
-	subf	r0,r6,r4		/* r0 = xsec = (xsec - r6) */
-	mulld   r0,r0,r7		/* usec = (xsec * USEC_PER_SEC) /
-					 * XSEC_PER_SEC
-					 */
-	rldicl  r0,r0,44,20
-	std	r0,TVAL64_TV_USEC(r11)	/* store usec in tv */
+	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
+	addi	r7,r7,1000000@l
+	bl	V_LOCAL_FUNC(__do_get_tspec) /* get sec/us from tb & kernel */
+	std	r4,TVAL64_TV_SEC(r11)	/* store sec in tv */
+	std	r5,TVAL64_TV_USEC(r11)	/* store usec in tv */
 2:	cmpldi	r10,0			/* check if tz is NULL */
 	beq	1f
 	lwz	r4,CFG_TZ_MINUTEWEST(r3)/* fill tz */
@@ -77,6 +70,8 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
   .cfi_register lr,r12
 	mr	r11,r4			/* r11 saves tp */
 	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
+	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
+	ori	r7,r7,NSEC_PER_SEC@l
 50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
 	bne	cr1,80f			/* if not monotonic, all done */
 
@@ -171,49 +166,12 @@ V_FUNCTION_END(__kernel_clock_getres)
 
 
 /*
- * This is the core of gettimeofday(), it returns the xsec
- * value in r4 and expects the datapage ptr (non clobbered)
- * in r3. clobbers r0,r4,r5,r6,r7,r8
- * When returning, r8 contains the counter value that can be reused
- */
-V_FUNCTION_BEGIN(__do_get_xsec)
-  .cfi_startproc
-	/* check for update count & load values */
-1:	ld	r8,CFG_TB_UPDATE_COUNT(r3)
-	andi.	r0,r8,1			/* pending update ? loop */
-	bne-	1b
-	xor	r0,r8,r8		/* create dependency */
-	add	r3,r3,r0
-
-	/* Get TB & offset it. We use the MFTB macro which will generate
-	 * workaround code for Cell.
-	 */
-	MFTB(r7)
-	ld	r9,CFG_TB_ORIG_STAMP(r3)
-	subf	r7,r9,r7
-
-	/* Scale result */
-	ld	r5,CFG_TB_TO_XS(r3)
-	mulhdu	r7,r7,r5
-
-	/* Add stamp since epoch */
-	ld	r6,CFG_STAMP_XSEC(r3)
-	add	r4,r6,r7
-
-	xor	r0,r4,r4
-	add	r3,r3,r0
-	ld	r0,CFG_TB_UPDATE_COUNT(r3)
-        cmpld   cr0,r0,r8		/* check if updated */
-	bne-	1b
-	blr
-  .cfi_endproc
-V_FUNCTION_END(__do_get_xsec)
-
-/*
- * This is the core of clock_gettime(), it returns the current
- * time in seconds and nanoseconds in r4 and r5.
+ * This is the core of clock_gettime() and gettimeofday(),
+ * it returns the current time in r4 (seconds) and r5.
+ * On entry, r7 gives the resolution of r5, either USEC_PER_SEC
+ * or NSEC_PER_SEC, giving r5 in microseconds or nanoseconds.
  * It expects the datapage ptr in r3 and doesn't clobber it.
- * It clobbers r0 and r6 and returns NSEC_PER_SEC in r7.
+ * It clobbers r0, r6 and r9.
  * On return, r8 contains the counter value that can be reused.
  * This clobbers cr0 but not any other cr field.
  */
@@ -229,18 +187,18 @@ V_FUNCTION_BEGIN(__do_get_tspec)
 	/* Get TB & offset it. We use the MFTB macro which will generate
 	 * workaround code for Cell.
 	 */
-	MFTB(r7)
+	MFTB(r6)
 	ld	r9,CFG_TB_ORIG_STAMP(r3)
-	subf	r7,r9,r7
+	subf	r6,r9,r6
 
 	/* Scale result */
 	ld	r5,CFG_TB_TO_XS(r3)
-	sldi	r7,r7,12		/* compute time since stamp_xtime */
-	mulhdu	r6,r7,r5		/* in units of 2^-32 seconds */
+	sldi	r6,r6,12		/* compute time since stamp_xtime */
+	mulhdu	r6,r6,r5		/* in units of 2^-32 seconds */
 
 	/* Add stamp since epoch */
 	ld	r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
-	ld	r5,STAMP_XTIME+TSPC64_TV_NSEC(r3)
+	lwz	r5,STAMP_SEC_FRAC(r3)
 	or	r0,r4,r5
 	or	r0,r0,r6
 	xor	r0,r0,r0
@@ -250,17 +208,11 @@ V_FUNCTION_BEGIN(__do_get_tspec)
 	bne-	1b			/* reload if so */
 
 	/* convert to seconds & nanoseconds and add to stamp */
-	lis	r7,NSEC_PER_SEC@h
-	ori	r7,r7,NSEC_PER_SEC@l
-	mulhwu	r0,r6,r7		/* compute nanoseconds and */
+	add	r6,r6,r5		/* add on fractional seconds of xtime */
+	mulhwu	r5,r6,r7		/* compute micro or nanoseconds and */
 	srdi	r6,r6,32		/* seconds since stamp_xtime */
-	clrldi	r0,r0,32
-	add	r5,r5,r0		/* add nanoseconds together */
-	cmpd	r5,r7			/* overflow? */
+	clrldi	r5,r5,32
 	add	r4,r4,r6
-	bltlr				/* all done if no overflow */
-	subf	r5,r7,r5		/* if overflow, adjust */
-	addi	r4,r4,1
 	blr
   .cfi_endproc
 V_FUNCTION_END(__do_get_tspec)
-- 
1.7.1
