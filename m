Date: Mon, 19 Apr 1999 21:24:59 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New boot attempts on a MVME2431 
In-Reply-To: <371B741C.35603A35@fi.infn.it>
Message-ID: <Pine.LNX.3.96.990419211131.17086A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Apr 1999, Simone Piccardi wrote:

> I'm still trying to boot LinucPPC on this board. Thanks to new kernel
> images provided by G. Paubert in his site I could obtain some new
> results (not a success but at least this time the boot is going a bit
> further).
> 
> The board has no drive, so I tried two versions of the kernel image: the
> initrd and the nfsroot, (this last try was to see if something different
> happens, becauase I do not have a NFS root tree for the PPC).
> 
<initrd boot deleted> 
> ------ END CLIP ------
> 
> and here it freeze and I have t reset the board.

Can't comment on this one, not using the same code base here.

> The results of the zImage.nfsroot boot was obiuvsly different:
> 
> ------ CLIP HERE ------
> 
> 08:00:3e:28:28:00,
>       and requires IRQ18 (provided by PCI BIOS).
> de4x5.c:V0.543 1998/12/30 davies@maniac.ultranet.com
> NIP: C000FDE0 XER: 00000000 LR: C000FDC4 REGS: c0197ce0 TRAP: 0300
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c0196000[1] 'swapper' mm->pgd c00ba000 Last syscall: 120
> last math 00000000
> GPR00: 00001032 C0197DD0 C0196000 00000001 00008000 00000000 00038C98
> 00000001
> GPR08: 00000001 00007800 80000000 000001E0 0000001F 01F720A0 00000000
> 00000000
> GPR16: 00000000 00000000 20000002 00000000 00000000 E0001FFE 00000000
> 00000000
> GPR24: 00000000 00000000 C00E0000 000000FA 00000000 00009032 C011F76C
> C0197DD0
> Call backtrace:
> 00000000 C009BFD4 C0095C38 C00945AC C00942E4 C0056300 C0057368
> C00D5608 C00D6300 C00D4DE4 C00D678C C00CB714 C0004044 C000870C
> Instruction DUMP: 2c090000  912b0000  41820008 <91690004> 3b800001 
> 48000008  3b
> 800000  73aa8000  38000000
> Kernel panic: kernel access of bad area pc c000fde0 lr c000fdc4 address
> 7804 tsk
>  swapper/1

Apply the following patch:

diff -ud linux-2.1-bak/drivers/net/de4x5.c linux-2.1/drivers/net/de4x5.c
--- linux-2.1-bak/drivers/net/de4x5.c	Tue Jan  5 09:37:38 1999
+++ linux-2.1/drivers/net/de4x5.c	Mon Mar  8 02:30:23 1999
@@ -4794,6 +4794,7 @@
     if (lp->state == INITIALISED) {
         lp->ibn = 3;
         lp->active = *p++;
+	if (MOTO_SROM_BUG) lp->active = 0;
 	lp->phy[lp->active].gep = (*p ? p : 0); p += (2 * (*p) + 1);
 	lp->phy[lp->active].rst = (*p ? p : 0); p += (2 * (*p) + 1);
 	lp->phy[lp->active].mc  = TWIDDLE(p); p += 2;
@@ -4805,6 +4806,7 @@
     } else if ((lp->media == INIT) && (lp->timeout < 0)) {
         lp->ibn = 3;
 	lp->active = *p;
+	if (MOTO_SROM_BUG) lp->active = 0;
 	lp->infoblock_csr6 = OMR_MII_100;
 	lp->useMII = TRUE;
 	lp->infoblock_media = ANS;
diff -ud linux-2.1-bak/drivers/net/de4x5.h linux-2.1/drivers/net/de4x5.h
--- linux-2.1-bak/drivers/net/de4x5.h	Tue Jan  5 09:37:40 1999
+++ linux-2.1/drivers/net/de4x5.h	Mon Mar  8 02:30:43 1999
@@ -599,6 +599,11 @@
 #define BLOCK0_MC      0x3f        /* Media Code */
 
 /*
+** SROM fixup
+*/
+#define MOTO_SROM_BUG	((lp->active == 8) &&
((le32_to_cpu(get_unaligned((u32 *)dev->dev_addr))&0x00ffffff)==0x3e0008))
+
+/*
 ** DC21040 Full Duplex Register (DE4X5_FDR)
 */
 #define FDR_FDACV  0x0000ffff      /* Full Duplex Auto Configuration
Value */

> My question are: 
> Is the way I gave the boot parameter (root=/dev/nfs) right? 
> I exported an empty /home/ppc directory on the same PC that I used as 
> tftp server, but how the board can recognize just this directory? And 
> what files I have to put in this directory?

You need a rarp or bootp server set up on the machine so that it will
provide your board config info after it gets past the SROM bug in the
driver.  You can build a quick base system by grabbing the Debian "potato"
base tarball at
ftp://ftp.debian/org/pub/debian/dists/potato/main/disks-powerpc/2.1.8-1999-02-24/base2_2.tgz
Untar it into your nfsroot directory, remove the unconfigure.sh script
from /sbin (I believe), modify inittab to boot into single user mode, and
reboot your system.  You may also want to set up the sysvinit link in the
rcS.d runlevel directory so that the nfsroot dir is remounted rw.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
