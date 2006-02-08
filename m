Return-Path: <jaf@lcsaudio.com>
Received: from smtpauth01.mail.atl.earthlink.net
	(smtpauth01.mail.atl.earthlink.net [209.86.89.61])
	by ozlabs.org (Postfix) with ESMTP id 8A69368A00
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 19:32:24 +1100 (EST)
Received: from [4.232.75.165] (helo=smtpauth.earthlink.net)
	by smtpauth01.mail.atl.earthlink.net with asmtp (Exim 4.34)
	id 1F6kkP-00083H-PL
	for linuxppc-embedded@ozlabs.org; Wed, 08 Feb 2006 03:32:22 -0500
In-Reply-To: <mailman.294.1139321937.857.linuxppc-embedded@ozlabs.org>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Floating point math in kernel interrupt -- am I doing this
	right?(repost)
From: "Jeremy Friesner" <jaf@lcsaudio.com>
Date: Wed, 08 Feb 2006 00:32:12 PST (-0800)
Message-Id: <1193761678-BeMail@jeremy.lcsaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I figured out what was wrong with my FPU save/restore code:  I was neglecting to save and restore the state of the FPSCR register.  Thanks to all who helped me figure it out!

For the sake of the list archives, I've pasted my fixed FP save/restore routines below.

-Jeremy

---------------------- snip -------------------------------

/* macros to save and restore floating point register state */
# define SAVE=5FFPR(x)    {=5F=5Fasm=5F=5F =5F=5Fvolatile=5F=5F ("stfd " #x ", " #x "*8(%0)\n" : : "b" (saved=5Ffpr));}
# define RESTORE=5FFPR(x) {=5F=5Fasm=5F=5F =5F=5Fvolatile=5F=5F ("lfd  " #x ", " #x "*8(%0)\n" : : "b" (saved=5Ffpr));}    

/* Set up floating-point-enabled-mode */
uint32 saved=5Fmsr;        /* space for the MSR register (32 bits) */
uint32 saved=5Ffpscr[1*2]; /* space for the FPSCR register (64 bits) */
uint32 saved=5Ffpr[14*2];  /* space for the 14 floating point registers I'll use (64 bits each) */
{
   uint32 msr;

   /* Save existing MSR for later */
   =5F=5Fasm=5F=5F =5F=5Fvolatile=5F=5F ("mfmsr %0" : "=3Dr" (msr) : );
   saved=5Fmsr =3D msr;

   /* Enable floating point */
   msr |=3D MSR=5FFP;
   msr &=3D ~(MSR=5FFE0 | MSR=5FFE1);
   =5F=5Fasm=5F=5F =5F=5Fvolatile=5F=5F ("mtmsr %0\n\tisync" : : "r" (msr));

   /* Save the floating point registers that will be used, so that we won't screw up user processes */
   SAVE=5FFPR(0);  SAVE=5FFPR(1);  SAVE=5FFPR(2);  SAVE=5FFPR(3);  SAVE=5FFPR(4);
   SAVE=5FFPR(5);  SAVE=5FFPR(6);  SAVE=5FFPR(7);  SAVE=5FFPR(8);  SAVE=5FFPR(9);
   SAVE=5FFPR(10); SAVE=5FFPR(11); SAVE=5FFPR(12); SAVE=5FFPR(13);

   /* Save existing FPSCR, by first retrieving it into FPR0, then storing FPR0 to the stack */
   =5F=5Fasm=5F=5F =5F=5Fvolatile=5F=5F ("mffs 0\n\tstfd 0, 0(%0)\n" : : "b" (saved=5Ffpscr));
}                

DoFloatingPointMathHere();

/* End floating-point-enabled-mode */
{
   /* Restore FPSCR, by first loading it into FPR0, then calling mtfsf to put it back into the register */
   =5F=5Fasm=5F=5F =5F=5Fvolatile=5F=5F ("lfd 0, 0(%0)\n\tmtfsf 0xFF,0" : : "b" (saved=5Ffpscr));

   /* Restore the FP registers that may have been munged */
   RESTORE=5FFPR(0);  RESTORE=5FFPR(1);  RESTORE=5FFPR(2);  RESTORE=5FFPR(3);  RESTORE=5FFPR(4);
   RESTORE=5FFPR(5);  RESTORE=5FFPR(6);  RESTORE=5FFPR(7);  RESTORE=5FFPR(8);  RESTORE=5FFPR(9);
   RESTORE=5FFPR(10); RESTORE=5FFPR(11); RESTORE=5FFPR(12); RESTORE=5FFPR(13);

   /* Restore MSR */
   =5F=5Fasm=5F=5F =5F=5Fvolatile=5F=5F ("mtmsr %0\n" "isync" : : "r" (saved=5Fmsr));
}
 
