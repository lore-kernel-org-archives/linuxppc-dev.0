Message-ID: <373824A6.26FDBA2C@uab.ericsson.se>
Date: Tue, 11 May 1999 14:37:58 +0200
From: Leif Lindholm <Leif.Lindholm@uab.ericsson.se>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: [PATCH] Softemu 8xx implementation of LFS
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello

I had some trouble with softemu failures for LFS, so I implemented it
(well, actually stole Corts code for LFD and changed it to float :). In
case someone else wants it, there is a patch below (against
embedded-2.2.5 kernel).

Please correct me if I messed up (first dabbling in softemu), but it
seems to be working.

regards
	/
		Leif



--- linux/arch/ppc/kernel/softemu8xx.c.old      Fri Apr  9 06:28:20 1999
+++ linux/arch/ppc/kernel/softemu8xx.c  Tue May 11 14:20:56 1999
@@ -34,6 +34,7 @@
 
 /* Eventually we may need a look-up table, but this works for now.
 */
+#define LFS    48
 #define LFD    50
 #define LFDU   51
 #define STFD   54
@@ -86,6 +87,12 @@
                else
                        regs->gpr[idxreg] = (uint)ea;
                break;
+       case LFS:
+               sdisp = (instword & 0xffff);
+               ea = (uint *)(regs->gpr[idxreg] + sdisp);
+               if (copy_from_user(ip, ea, sizeof(float)))
+                       retval = EFAULT;
+               break;    
        case STFD:
                /* this is a 16 bit quantity that is sign extended
                 * so use a signed short here -- Cort

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
