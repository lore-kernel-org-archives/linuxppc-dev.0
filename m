Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 085932BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Dec 2004 20:51:46 +1100 (EST)
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-7310224810"
Date: Tue, 28 Dec 2004 10:51:14 +0100
Sender: wd@denx.de
Message-Id: <20041228095119.F07EDC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart MIME message.

--==_Exmh_-7310224810
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 27 Dec 2004 22:52:30 EST."
	<313680C9A886D511A06000204840E1CF0A64741E@whq-msgusr-02.pit.comms.marconi.com>

Dear Alex,

in message <313680C9A886D511A06000204840E1CF0A64741E@whq-msgusr-02.pit.comms.marconi.com> you wrote:
>  
> >Moving things around in the kernel sometimes 
> >makes this go away but really its just hidden.
> >In my case it would explode in zlib_inflate also.  Putting some output 
> >in the routine would move it ...
> 
> Yes that is exactly what I have observed (but I did'nt have the correct
> explanation for it) 

I think Paul may be right  with  his  suspicion;  it  sounds  like  a
manifestation  of the CPU15 problem (but it could also be incorrectly
initialized SDRAMs which fail  during  heavy  load  with  burst  mode
accesses, or one more instability of the 2.6 kernel on 8xx systems).

Note that all our work relating to this problem was done on  the  2.4
kernel  base,  and  I  make no claims that it might actually help for
your 2.6 problems.

> Could this code be used for 2.6 ?

The patch does not apply cleanly as is to the 2.6 tree, but it should
be simple enough to port.

> Could someone point me to it, please ?

It's in the linuxppc_2_4_devel tree on our CVS server.

Please  find  attached  the  patch  to  the  2.4  kernel  tree  which
implements  the  workaround,  and  a  test  application  to  reliably
reproduce the CPU15 errata. It usually takes  1-10  minutes  for  the
application to crash, if the workaround is disabled:

	bash-2.05b# date; ./cpu15 ; date
	Thu Aug  2 02:02:42 MEST 2001
	Illegal instruction
	Thu Aug  2 02:02:54 MEST 2001
	bash-2.05b# date; ./cpu15 ; date
	Thu Aug  2 02:02:58 MEST 2001
	Illegal instruction
	Thu Aug  2 02:03:48 MEST 2001
	bash-2.05b# date; ./cpu15 ; date
	Thu Aug  2 02:03:54 MEST 2001
	Illegal instruction
	Thu Aug  2 02:03:57 MEST 2001
	bash-2.05b# date; ./cpu15 ; date
	Thu Aug  2 02:04:07 MEST 2001
	Illegal instruction
	Thu Aug  2 02:04:16 MEST 2001
	bash-2.05b#

We noticed that some background activitly, like logging in/out to the
target via 'telnet', while the application is running over the serial
console, additionally speeds up the crash.

You can use this command to enable the workaround at run-time (it  is
disabled by default):

	bash# sysctl -w kernel.8xx_cpu15=1

Please note that for the h/w problem  to  show  up,  the  instruction
cache  has  to  be enabled.

Hope this helps.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Wish not to seem, but to be, the best."                  - Aeschylus


--==_Exmh_-7310224810
Content-Type: application/octet-stream ; name="patch"
Content-Description: patch
Content-Disposition: attachment; filename="patch"

CVS Root: :pserver:anonymous@www.denx.de:/cvsroot
CVS Module: linuxppc_2_4_devel
PatchSet: 295 
Date: 2004/08/25 16:16:30
Log: Implement work-around for CPU15 Silicon Errata on MPC8xx processors.
Signed-off-by: Wolfgang Denk <wd@denx.de>
  
Index: arch/ppc/8xx_io/Config.in
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/arch/ppc/8xx_io/Config.in,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -r1.8 -r1.9
--- arch/ppc/8xx_io/Config.in	11 Mar 2004 22:43:31 -0000	1.8
+++ arch/ppc/8xx_io/Config.in	25 Aug 2004 15:16:30 -0000	1.9
@@ -7,6 +7,7 @@
 comment 'Generic MPC8xx Options'
 bool 'Copy-Back Data Cache (else Writethrough)' CONFIG_8xx_COPYBACK
 bool 'CPU6 Silicon Errata (860 Pre Rev. C)' CONFIG_8xx_CPU6
+bool 'CPU15 Silicon Errata' CONFIG_8xx_CPU15
 bool 'I2C/SPI Microcode Patch' CONFIG_UCODE_PATCH
 if [ "$CONFIG_UCODE_PATCH" = "y" ]; then
   bool '  Use MPC850-specific microcode patch' CONFIG_MPC850_UCODE_PATCH
Index: arch/ppc/kernel/head_8xx.S
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/arch/ppc/kernel/head_8xx.S,v
retrieving revision 1.6
retrieving revision 1.7
diff -u -r1.6 -r1.7
--- arch/ppc/kernel/head_8xx.S	30 Oct 2003 00:32:14 -0000	1.6
+++ arch/ppc/kernel/head_8xx.S	25 Aug 2004 15:16:30 -0000	1.7
@@ -324,6 +324,19 @@
 	stw	r3, 12(r0)
 	lwz	r3, 12(r0)
 #endif
+#ifdef CONFIG_8xx_CPU15
+	lis	r21, cpu15_fix@h
+	ori	r21, r21, cpu15_fix@l
+	tophys(r21,r21)
+	lwz	r21, 0(r21)		/* value of cpu15 variable */
+	cmpwi	r21, 0
+	beq	4f
+	subi	r21, r20, 0x1000	/* EA of prev page */
+	tlbie	r21
+	addi	r21, r20, 0x1000	/* EA of next page */
+	tlbie	r21
+4:
+#endif
 	mtspr	MD_EPN, r20	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r20, M_TWB	/* Get level 1 table entry address */
 
Index: include/linux/sysctl.h
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/include/linux/sysctl.h,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -r1.8 -r1.9
--- include/linux/sysctl.h	11 Mar 2004 22:44:32 -0000	1.8
+++ include/linux/sysctl.h	25 Aug 2004 15:16:30 -0000	1.9
@@ -128,6 +128,7 @@
 	KERN_PPC_L3CR=57,       /* l3cr register on PPC */
 	KERN_EXCEPTION_TRACE=58, /* boolean: exception trace */
  	KERN_CORE_SETUID=59,	/* int: set to allow core dumps of setuid apps */
+ 	KERN_8XX_CPU15=60,	/* boolean: patch cpu15 errata on mpc8xx cpu */
 };
 
 
Index: kernel/sysctl.c
===================================================================
RCS file: /cvsroot/linuxppc_2_4_devel/kernel/sysctl.c,v
retrieving revision 1.8
retrieving revision 1.9
diff -u -r1.8 -r1.9
--- kernel/sysctl.c	15 Nov 2003 01:37:12 -0000	1.8
+++ kernel/sysctl.c	25 Aug 2004 15:16:30 -0000	1.9
@@ -150,6 +150,10 @@
 static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
 #endif
 
+#ifdef CONFIG_8xx_CPU15
+int cpu15_fix = 0;	/* disabled by default */
+#endif
+
 /* The default sysctl tables: */
 
 static ctl_table root_table[] = {
@@ -273,6 +277,10 @@
 	{KERN_EXCEPTION_TRACE,"exception-trace",
 	 &exception_trace,sizeof(int),0644,NULL,&proc_dointvec},
 #endif	
+#ifdef CONFIG_8xx_CPU15
+	{KERN_8XX_CPU15, "8xx_cpu15", &cpu15_fix, sizeof(int),
+	 0644, NULL, &proc_dointvec},
+#endif
 	{0}
 };
 

--==_Exmh_-7310224810
Content-Type: application/octet-stream ; name="cpu15.c"
Content-Description: cpu15.c
Content-Disposition: attachment; filename="cpu15.c"

#include <sys/mman.h>
#include <fcntl.h>

#define MOV(r, val) \
		"lis	%%"#r", "#val"@h\n" \
		"ori	%%"#r", %%"#r", "#val"@l\n"

int data = 1;	/* read 1 from memory */
void *buffer;	/* buffer for code copy */

void test(int copy_code, int offset)
{
	asm(
		"mflr	%%r20\n"			/* save lr */

		MOV(r24, buffer)
		"lwz	%%r24, 0(%%r24)\n"		/* save buffer address to r24 */
		MOV(r22, page0)
		MOV(r21, page2)
		"sub	%%r23, %%r21, %%r22\n"		/* page0 code size */
		"addi	%%r21, %%r24, 0x1000\n"		/* page1 */
		"sub	%%r25, %%r21, %%r23\n"		/* save code at end of page0 to r25 */

		"cmpwi	%1, 0\n"
		"beq	start\n"			/* jump if code_copy == 0 */

		"mr	%%r21, %%r25\n"
		"bl	copy\n"				/* copy page0 code */
		
		MOV(r22, page2)
		MOV(r21, copy)
		"sub	%%r23, %%r21, %%r22\n"		/* page2 code size */
		"addi	%%r21, %%r24, 0x2000\n"		/* page2 */
		"bl	copy\n"				/* copy page2 code */

		MOV(r23, 0x10000 / 16)			/* buffer size / cache line size */
		"mtctr	%%r23\n"
		"mr	%%r21, %%r24\n"
	"5:\n"
		"dcbst	0, %%r21\n"
		"sync\n"				/* wait for dcbst to complete on bus */
		"icbi	0, %%r21\n"
		"sync\n"				/* wait for icbi to complete on bus */
		"addi	%%r21, %%r21, 16\n"		/* next cache line */
		"bdnz	5b\n"
		"isync\n"

		"b	end\n"

	"start:\n"
		"bl	4f\n"				/* get current pc */
	"4:\n"
		"mflr	%%r26\n"
		"addi	%%r26, %%r26, end-4b\n"		/* save end address to r26 */
		"mtlr	%%r25\n"
		"blr\n"					/* jump to page0 code */

	"page0:\n"
		/* load first cache line at page2 */
		"addi	%%r21, %%r24, 0x2000+touch-page2\n"
		"mtlr	%%r21\n"
		"blr\n"					/* jump to touch */
	"1:\n"
		/* invalidate first cache line at page1 */
		"li	%%r23, 0x1000\n"
		"icbi	%%r24, %%r23\n"
		/* trying to make branch address unresolved long enough */
		"addi	%%r21, %%r24, 0x2000-20\n"
		"sub	%%r21, %%r21, %0\n"		/* add offset */
		"li	%%r23, 20\n"			/* cycle 20 times */
		"mtctr	%%r23\n"
		MOV(r22, data)
	"2:\n"
		"sync\n"
		"lwz	%%r23, 0(%%r22)\n"		/* add content of data i.e 1 */
		"add	%%r21, %%r21, %%r23\n"
		"bdnz	2b\n"
		"mtlr	%%r21\n"
		"blr\n"					/* jump to end of page1 */
	"page2:\n"
		"b	3f\n"				/* invalid or wrong instruction may occur */
		"lwz	%%r0, 0(%%r0)\n"		/* give SIGSEGV */
	"touch:\n"
		"addi	%%r21, %%r25, 1b-page0\n"
		"mtlr	%%r21\n"
		"blr\n"					/* jump back to page0 i.e 1b */
	"3:\n"
		"mtlr	%%r26\n"
		"blr\n"					/* jump to end */
		/* memcpy(r21, r22, r23) */
	"copy:\n"
		"mtctr	%%r23\n"
		"subi	%%r22, %%r22, 1\n"
		"subi	%%r21, %%r21, 1\n"
	"6:\n"
		"lbzu	%%r23, 1(%%r22)\n"
		"stbu	%%r23, 1(%%r21)\n"
		"bdnz	6b\n"
		"blr\n"
	"end:\n"
		"mtlr	%%r20\n"			/* restore lr */
		: "=r" (offset)
		: "r" (copy_code), "r" (offset)
	);
}

int main(int argc, char *argv[])
{
	int i, fd;

	nice(10);
	fd = open("cpu15.log", O_CREAT | O_TRUNC | O_RDWR, 0666);
	buffer = mmap(0, 0x10000, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);

	/* fill buffer with bad instructions */
	for (i = 0; i < 0x10000 / 4; i++)
#if 0
		((int*)buffer)[i] = 0x80000000;	/* lwz r0, 0(r0) - give SIGSEGV */
#else
		((int*)buffer)[i] = 0x7c0003a6;	/* mtspr 0, r0   - give SIGILL */
#endif
	/* fill cache line at end of page1 with nop */
	for (i = 0; i < 4; i++)
		((int*)((int)buffer + 0x1ff0))[i] = 0x60000000; /* nop */
		
	/* copy code to buffer */
	test(1, 0);

	for (i = 0; ; i++) {
		test(0, ((i & 3) << 2) + 4); /* offset 4...16 */
		if (i % 1000000 == 0)
			write(fd, ".", 1);
	}

	return 0;
}

--==_Exmh_-7310224810--
