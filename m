To: mlan@cpu.lu
Cc: DebianPPC <debian-powerpc@lists.debian.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Xvideo acceleration: GATOS for PPC?
References: <200108282111.XAA00990@piglet.grunz.lu>
From: Josh Huber <huber@debian.org>
Date: Tue, 28 Aug 2001 17:39:48 -0400
In-Reply-To: <200108282111.XAA00990@piglet.grunz.lu> (Michel Lanners's
 message of "Tue, 28 Aug 2001 23:11:37 +0200 (CEST)")
Message-ID: <87heurhniz.fsf@mclinux.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-=-=

Michel Lanners <mlan@cpu.lu> writes:

> (II) R128(0): Cannot access BIOS: info->VBIOS==NULL.

Yeah, I just looked at this.  Same problem on mach64, it finds that
the VBIOS pointer is NULL, reports it, and happily tries to
dereference it a couple lines down. (hence the segfault)

alert, this may be a cheap hack, but it makes the xvideo module work
great on my Lombard. (attached)

now, it looks like that code is duplicated throughout the r128_video.c
and radeon_video.c file as well, so you might want to try changing
that too. (for r128)

ttyl,

--
Josh Huber                                   | huber@debian.org |

--=-=-=
Content-Disposition: attachment; filename=atixv_no_bios.diff

Index: atixv.c
===================================================================
RCS file: /cvs/livid/gatos-ati/ati_xv/ati.2/atixv.c,v
retrieving revision 1.14
diff -u -r1.14 atixv.c
--- atixv.c	2001/07/29 17:57:46	1.14
+++ atixv.c	2001/08/28 21:54:05
@@ -1048,7 +1048,9 @@

      if(pATI->VBIOS==NULL){
      	xf86DrvMsg(pScrn->scrnIndex, X_INFO, "Cannot access BIOS: info->VBIOS==NULL.\n");
+	mm_table = 0;
      	}
+     else {

      xf86DrvMsg(pScrn->scrnIndex, X_INFO, "0x%02x 0x%02x\n", pATI->VBIOS[0],
                pATI->VBIOS[1]);
@@ -1057,6 +1059,8 @@

 	/* mach64 table is at different address than r128 one */
      mm_table=pATI->VBIOS[bios_header+0x46];
+     }
+
      if(mm_table==0)
      {
          xf86DrvMsg(pScrn->scrnIndex,X_INFO,"No MM_TABLE found\n",bios_header,mm_table);

--=-=-=--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
