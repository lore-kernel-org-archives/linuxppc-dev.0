Date: Thu, 10 Jun 1999 15:28:13 -0600 (MDT)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] mol quit-at-shutdown
In-Reply-To: <199906102103.QAA15072@cegt201.bradley.edu>
Message-ID: <Pine.LNX.3.95.990610151742.24326A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


with this patch, mol quits when macos tries to pull down the power so the
macos shutdown action cleanly exits the emulator.

it appears all the mol cleanup is done in an atexit routine so i figured
this would be safe. my only concern is that it looks like macos does a
couple of scsi operations AFTER telling the cuda to power down. maybe i
should set an alarm and have the alarm kill the emulator instead...?

i would like to make the debugger interface optional via a command-line
interface to mol next...

--- ../mol/drivers/cuda.c       Fri May 21 12:47:58 1999
+++ ./drivers/cuda.c    Thu Jun 10 15:26:21 1999
@@ -332,7 +332,9 @@
                printm("CUDA: rest system\n");
                break;
        case CUDA_MS_RESET:
+               break;
        case CUDA_POWERDOWN:
+               exit(0);
        case CUDA_POWERUP_TIME:
                break;
        case CUDA_AUTOPOLL: /* input_len/output_len : 1/0 */


Brad
brad@pht.com | http://www.pht.com/~brad/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
