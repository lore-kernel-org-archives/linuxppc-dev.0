From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 23 Jun 2003 10:27:51 +0200
To: Chris Studholme <cvs@cs.utoronto.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	Terry Greeniaus <tgree@phys.ualberta.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pismo upgraded to 750fx not detected correctly
Message-ID: <20030623082751.GA2738@iram.es>
References: <1056275365.3808.49.camel@gaston> <Pine.LNX.4.44.0306230032020.17411-100000@stoa.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0306230032020.17411-100000@stoa.dhs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jun 23, 2003 at 12:47:56AM -0400, Chris Studholme wrote:
>
> On Sun, 22 Jun 2003, Benjamin Herrenschmidt wrote:
> > Note that the kernel doesn't use the device tree to detect the
> > CPU type. It rather runs the PVR through a table in
> > arch/ppc/kernel/cputable.c. There is currently no hook you could
> > use to 'fix' that. Ideally, you should make sure the CPU is properly
> > detected before the fixups are done or you may "lose" some 750fx
> > specific code.
>
> Ok, so to properly detect the cpu, I ported Terry's code to assembler and
> added it to identify_cpu in arch/ppc/kernel/misc.S.  See the attached diff
> below.  This code does the following:
>
> - detects 750FX strapped as 750 in identify_cpu
> - stores the real pvr is a new global called 'real_pvr'
> - updates the cache and clock_frequency values in the device tree at the
>   end of finish_device_tree() in prom.c
> - makes use of real_pvr instead of mfspr(PVR) in show_cpuinfo() in setup.c
>
> Note that I currently hardcode the clock frequency to 900MHz (speed of my
> pismo).  I'll fix that as soon as I learn how to detect the true processor
> speed.
>
> For a complete solution, I believe all that needs to be done is to change
> all instances of 'mfspr(PVR)' to 'real_pvr', except the one in prom.c.
>
> Also, I just learned ppc assembler today while doing this so please let me
> know if you see a more efficient/eloquent way to do the cpu detection, or
> if you find a bug in what I have.  I've only tested this on my upgraded
> pismo and it seems to work.  Here's my /proc/cpuinfo now:
>
>   cpu             : 750FX
>   temperature     : 18-20 C (uncalibrated)
>   clock           : 900MHz
>   revision        : 2.2 (pvr 7000 0202)
>   bogomips        : 1795.68
>   machine         : PowerBook3,1
>   motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
>   detected as     : 70 (PowerBook Pismo)
>   pmac flags      : 0000000f
>   L2 cache        : 512K unified
>   memory          : 256MB
>   pmac-generation : NewWorld
>
> Chris.
>
>
> diff -c -r linux-2.4.21-ac1.orig/arch/ppc/kernel/cputable.c linux-2.4.21-ac1/arch/ppc/kernel/cputable.c
> *** linux-2.4.21-ac1.orig/arch/ppc/kernel/cputable.c	Fri Jun 13 10:51:31 2003
> --- linux-2.4.21-ac1/arch/ppc/kernel/cputable.c	Sun Jun 22 21:10:37 2003
> ***************
> *** 18,23 ****
> --- 18,25 ----
>
>   struct cpu_spec* cur_cpu_spec[NR_CPUS];
>
> + unsigned int real_pvr;
> +
>   extern void __setup_cpu_601(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
>   extern void __setup_cpu_603(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
>   extern void __setup_cpu_604(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
> diff -c -r linux-2.4.21-ac1.orig/arch/ppc/kernel/misc.S linux-2.4.21-ac1/arch/ppc/kernel/misc.S
> *** linux-2.4.21-ac1.orig/arch/ppc/kernel/misc.S	Fri Jun 13 10:51:31 2003
> --- linux-2.4.21-ac1/arch/ppc/kernel/misc.S	Sun Jun 22 21:25:32 2003
> ***************
> *** 113,118 ****
> --- 113,139 ----
>   	addis	r8,r3,cpu_specs@ha
>   	addi	r8,r8,cpu_specs@l
>   	mfpvr	r7
> +
> + /* check for 750fx strapped on as 750 */
> + 	srwi	r6,r7,16
> + 	cmpli	0,r6,8
> + 	bne	1f
> + 	mfspr	r5,0x3F1
> + 	srwi.	r6,r5,17
> + 	bso	2f

Are you sure you want to test the summary overflow bit
in this branch ? This bit is not related to the result
of the preceding srwi. instruction, so this looks
strange to say the least.


> + 	xori	r6,r5,0x0200
> + 	b	3f
> + 2:
> + 	xori	r6,r5,0x0002
> + 3:
> + 	mtspr	0x3F1,r6
> + 	mfspr	r6,0x3F1
> + 	cmplw	0,r5,r6
> + 	beq	1f
> +
> + /* pvr is actually 0x7000nnnn, not 0x0008nnnn */
> + 	xoris	r7,r7,0x7008
> +
>   1:
>   	lwz	r5,CPU_SPEC_PVR_MASK(r8)
>   	and	r5,r5,r7
> ***************
> *** 127,132 ****
> --- 148,158 ----
>   	slwi	r4,r4,2
>   	sub	r8,r8,r3
>   	stwx	r8,r4,r6
> +
> + 	addis	r6,r3,real_pvr@ha
> + 	addi	r6,r6,real_pvr@l
> + 	stwx	r7,0,r6

A bit convoluted no? r3 is supposed to be zero, so
the standard way of performing this is:

	lis r6,real_pvr@ha
	stw r7,real_pvr@l(r6)

> +
>   	blr
>

The rest looks fine, but I can't test it and did not check
the details of the boring C code.

	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
