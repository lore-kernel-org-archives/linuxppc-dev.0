Date: Fri, 3 Aug 2001 13:34:13 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] IBM PReP power down
Message-ID: <20010803133413.A10131@austin.ibm.com>
References: <20010803114608.A9987@austin.ibm.com> <20010803100251.A20944@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
In-Reply-To: <20010803100251.A20944@opus.bloom.county>; from trini@kernel.crashing.org on Fri, Aug 03, 2001 at 10:02:51AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2001 at 10:02:51AM -0700, Tom Rini wrote:
>
> On Fri, Aug 03, 2001 at 11:46:08AM -0500, Hollis Blanchard wrote:
>
> > The patch is against _2_4, but applies with slight offsets to _2_4_devel as
> > well. Please commit to both?
>
> It currently fails on 2_4, and it's the big hunk too.  Also, can't
> utah_sig87c750_setbit be 'static'?  Aside from that it looks good..

This one should be better.

-Hollis

--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ibmprep_poweroff.patch2"

diff -Nru a/arch/ppc/kernel/prep_setup.c b/arch/ppc/kernel/prep_setup.c
--- a/arch/ppc/kernel/prep_setup.c	Fri Aug  3 13:33:01 2001
+++ b/arch/ppc/kernel/prep_setup.c	Fri Aug  3 13:33:01 2001
@@ -14,6 +14,7 @@
  */

 #include <linux/config.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -496,21 +497,20 @@
 void __prep
 prep_restart(char *cmd)
 {
-        unsigned long i = 10000;
-
+	unsigned long i = 10000;

 	__cli();

-        /* set exception prefix high - to the prom */
-        _nmask_and_or_msr(0, MSR_IP);
+	/* set exception prefix high - to the prom */
+	_nmask_and_or_msr(0, MSR_IP);

-        /* make sure bit 0 (reset) is a 0 */
-        outb( inb(0x92) & ~1L , 0x92 );
-        /* signal a reset to system control port A - soft reset */
-        outb( inb(0x92) | 1 , 0x92 );
+	/* make sure bit 0 (reset) is a 0 */
+	outb( inb(0x92) & ~1L , 0x92 );
+	/* signal a reset to system control port A - soft reset */
+	outb( inb(0x92) | 1 , 0x92 );

-        while ( i != 0 ) i++;
-        panic("restart failed\n");
+	while ( i != 0 ) i++;
+	panic("restart failed\n");
 }

 /*
@@ -542,27 +542,92 @@
 void __prep
 prep_halt(void)
 {
-        unsigned long flags;
+	unsigned long flags;
 	__cli();
 	/* set exception prefix high - to the prom */
 	save_flags( flags );
 	restore_flags( flags|MSR_IP );
-
+
 	/* make sure bit 0 (reset) is a 0 */
 	outb( inb(0x92) & ~1L , 0x92 );
 	/* signal a reset to system control port A - soft reset */
 	outb( inb(0x92) | 1 , 0x92 );
-
+
 	while ( 1 ) ;
 	/*
 	 * Not reached
 	 */
 }

+/*
+ * On IBM PReP's, power management is handled by a Signetics 87c750 behind the
+ * Utah component on the ISA bus. To access the 750 you must write a series of
+ * nibbles to port 0x82a (decoded by the Utah). This is described somewhat in
+ * the IBM Carolina Technical Specification.
+ * -Hollis
+ */
+static void __prep
+utah_sig87c750_setbit(unsigned int bytenum, unsigned int bitnum, int value)
+{
+	/*
+	 * byte1: 0 0 0 1 0  d  a5 a4
+	 * byte2: 0 0 0 1 a3 a2 a1 a0
+	 *
+	 * d = the bit's value, enabled or disabled
+	 * (a5 a4 a3) = the byte number, minus 20
+	 * (a2 a1 a0) = the bit number
+	 *
+	 * example: set the 5th bit of byte 21 (21.5)
+	 *     a5 a4 a3 = 001 (byte 1)
+	 *     a2 a1 a0 = 101 (bit 5)
+	 *
+	 *     byte1 = 0001 0100 (0x14)
+	 *     byte2 = 0001 1101 (0x1d)
+	 */
+	unsigned char byte1=0x10, byte2=0x10;
+	const unsigned int pm_reg_1=0x82a; /* ISA address */
+
+	/* the 750's '20.0' is accessed as '0.0' through Utah (which adds 20) */
+	bytenum -= 20;
+
+	byte1 |= (!!value) << 2;		/* set d */
+	byte1 |= (bytenum >> 1) & 0x3;	/* set a5, a4 */
+
+	byte2 |= (bytenum & 0x1) << 3;	/* set a3 */
+	byte2 |= bitnum & 0x7;			/* set a2, a1, a0 */
+
+	outb(byte1, pm_reg_1);		/* first nibble */
+	mb();
+	udelay(100);				/* important: let controller recover */
+
+	outb(byte2, pm_reg_1);		/* second nibble */
+	mb();
+	udelay(100);				/* important: let controller recover */
+}
+
 void __prep
 prep_power_off(void)
 {
-	prep_halt();
+	if ( _prep_type == _PREP_IBM) {
+		/* tested on:
+		 * 		7248-43P (Carolina)
+		 * should work on:
+		 * 		6050, 6070 (Carolina's)
+		 * 		7043-140 (Tiger 1)
+		 */
+		unsigned long flags;
+		__cli();
+		/* set exception prefix high - to the prom */
+		save_flags( flags );
+		restore_flags( flags|MSR_IP );
+
+		utah_sig87c750_setbit(21, 5, 1); /* set bit 21.5, "PMEXEC_OFF" */
+
+		while ( 1 ) ;
+		/* not reached */
+	} else {
+		prep_halt();
+	}
 }

 int __prep

--Yylu36WmvOXNoKYn--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
