Return-Path: <jaf@lcsaudio.com>
Received: from lcsaudio.com (lcsaudio.com [66.160.193.223])
	by ozlabs.org (Postfix) with SMTP id D9C9F68A0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Feb 2006 13:30:24 +1100 (EST)
Received: from jeremy.lcsaudio.com ([24.75.158.194]) by lcsaudio.com for
	<linuxppc-embedded@ozlabs.org>; Sun, 5 Feb 2006 18:30:23 -0800
From: Jeremy Friesner <jaf@lcsaudio.com>
To: linuxppc-embedded@ozlabs.org
Subject: Floating point math in kernel interrupt -- am I doing this right?
	(repost)
Date: Sun, 5 Feb 2006 18:29:47 -0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602051829.47824.jaf@lcsaudio.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

(Sorry if this is dupe, my first posting didn't seem to make it through)

Hi all,

Can someone who is well-versed in PowerPC kernel issues give me some advice?

First, a bit of background:  I'm working on an audio mixing/playback engine 
that runs on an embedded PowerPC chip (82xx) using the 2.4.23 kernel.  The 
audio output format is 48kHz floating point, and the mixing is done inside an 
interrupt routine that runs 6000 times per second, and calculates 8 samples 
per interrupt.

In order to do the necessary floating point math, without corrupting the state 
of any other processes that might be using the FPU, the interrupt routine 
first saves the state of the FPU registers to the stack, then does the math, 
then restores FPU registers again, before returning.

In general this seems to work fine, i.e. I get the audio output I expect and 
user processes aren't effected.  However, I've noticed that every so often I 
will get a kernel oops and my userland application will crash.  The oops 
looks like this:

<4>Oops: kernel access of bad area, sig: 11
<4>NIP: C001D408 XER: 20000000 LR: C001D3E0 SP: C6091E30 REGS: c6091d80 TRAP: 
0300    Not tainted
<4>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
<4>DAR: 3FE8228D, DSISR: 20000000
<4>TASK = c6090000[118] 'wtrxd' Last syscall: 178
<4>last math c6054000 last altivec 00000000
<4>GPR00: 0000001F C6091E30 C6090000 00000020 C6090398 C6055DE8 C017AB4C 
00000000
<4>GPR08: 408CC599 3FE8228D 0000001F 00000000 84022884 10510E98 105800BC 
308259E8
<4>GPR16: 1057302C 1058006C 00000000 00000000 00009032 06091F40 00000000 
C0005DE8
<4>GPR24: C0005B40 00000020 00008000 00000000 C6091F50 C6091F20 C6091E78 
00000020
<4>Call backtrace:
<4>00000400 C0009AB8 C0009CC0 C0009060 C0005B9C 0FC1BBA4 0FEF51D0
<4>0FEF6F58 0FEF3C3C 10366F34 10365C64 103572A0 103895D8 0FEF37EC
<4>0FCCDE2C

The frequency of the 'oops' occurrences appears to be proportional to the 
amount of code that is present in the FPU-enabled section of the interrupt 
routine.  If I enable all of the mixing code, they appear every 10-20 
minutes.  If I disable all of the mixing code except the saving and restoring 
of the FPU registers, they only occur about once every 6-12 hours.  If I 
disable the saving and restoring of the FPU registers entirely, they don't 
seem to occur at all (at least within the bounds of my testing so far -- 15+ 
hours).

So my question is, is there some minor detail that my FPU-state-save/restore 
code is missing, that would cause these sort of symptoms?  I just enough 
about kernel/assembly/PowerPC issues to be dangerous, so I thought maybe 
there was something obvious that I am missing.  The relevant code is shown 
below.

Many thanks for any help or hints you can provide,

Jeremy Friesner

--------------- begin code snippet ----------------------
[... in interrupt routine...]
   uint32 saved_msr;
   uint32 saved_fpr[32*2];  // temp storage space for the current floating 
point registers

   /* Set up floating point enabled mode -- NO FLOATING POINT OPS ALLOWED 
ABOVE THIS POINT! */
   {
      // Save existing MSR
      uint32 msr;
      __asm__ __volatile__ ("mfmsr %0" : "=r" (msr) : );
      saved_msr = msr;

      // Enable floating point
      msr |= MSR_FP;
      msr &= ~(MSR_FE0 | MSR_FE1);
      __asm__ __volatile__ ("mtmsr %0\n\tisync" : : "r" (msr));

      /* Save the floating point registers that the mix code uses, so that we 
won't screw up the user process */
#define SAVE_FPR(x) {uint32 * saveTo = &saved_fpr[x*2]; __asm__ __volatile__ 
("stfd " #x ", 0(%0)\n" : : "b" (saveTo));}
      SAVE_FPR(0);  SAVE_FPR(1);  SAVE_FPR(2); SAVE_FPR(3);  SAVE_FPR(4); 
      SAVE_FPR(5);  SAVE_FPR(6);  SAVE_FPR(7); SAVE_FPR(8);  SAVE_FPR(9);  
      SAVE_FPR(10); SAVE_FPR(11); SAVE_FPR(12); SAVE_FPR(13);
      /* Note that I only save/restore the first 13 FP registers, since gcc's 
generated code doesn't use the other ones anyway(!) */
   }

   [... the actual mixing routine is called here.  I compile the mix function 
in a separate file, without the -msoft-float flag ...]
   [... but note that I get crashes even if I comment out the call to the 
mixing routine, which suggests the problem is somewhere else...]
   DoMixing();

   /* Exit floating point enabled mode -- NO FLOATING POINT OPS ALLOWED BELOW 
THIS POINT! */
   {
      /* Restore the FP registers back to their original state */
#define RESTORE_FPR(x) {uint32 * restoreFrom = &saved_fpr[x*2]; __asm__ 
__volatile__ ("lfd  " #x ", 0(%0)\n" : : "b" (restoreFrom));}
      RESTORE_FPR(0);  RESTORE_FPR(1);  RESTORE_FPR(2); RESTORE_FPR(3);  
RESTORE_FPR(4);  
      RESTORE_FPR(5);  RESTORE_FPR(6);  RESTORE_FPR(7); RESTORE_FPR(8);  
RESTORE_FPR(9);  
      RESTORE_FPR(10); RESTORE_FPR(11); RESTORE_FPR(12); RESTORE_FPR(13);

      /* Restore MSR */
      __asm__ __volatile__ ("mtmsr %0\n" "isync" : : "r" (saved_msr));
   }
