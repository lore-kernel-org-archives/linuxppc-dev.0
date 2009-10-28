Return-Path: <blacklites@gmail.com>
Received: from mail-pw0-f43.google.com (mail-pw0-f43.google.com
	[209.85.160.43]) by ozlabs.org (Postfix) with ESMTP id 9D5B5B7BEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Oct 2009 00:39:13 +1100 (EST)
Received: by pwj6 with SMTP id 6so838607pwj.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 06:39:12 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 28 Oct 2009 19:09:11 +0530
Message-ID: <a9b543570910280639j1ea9038du452249e89215a57e@mail.gmail.com>
Subject: Cache enable missing while creating TLBs for PPC440
	platform.head_44x.S file.
From: Vineeth _ <blacklites@gmail.com>
To: Johnny Hung <johnny.hacking@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
we are porting Linux 2.6.30 on a ppc440x5 based board.
when we check the kernel code in arch/powerpc/kernel/head_44x.S file @
line number 162,
while creating the TLB for 256MB, the cache enable/disable property is
not set by the kernel ? or are we missing smthing ?
when we gave that particular attribute, things started working. Please
find the kernel code below. We added "PPC44x_TLB_I" attribute to set
the cache, kernel started working.

----arch/powerpc/kernel/head_44x.S

/* Load the kernel PID = 0 */
li  r0,0
mtspr   SPRN_PID,r0
sync

/* Initialize MMUCR */
li  r5,0
mtspr   SPRN_MMUCR,r5
sync

/* pageid fields */
clrrwi  r3,r3,10        /* Mask off the effective page number */
ori r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_256M

/* xlat fields */
clrrwi  r4,r4,10        /* Mask off the real page number */
/* ERPN is 0 for first 4GB page */

/* attrib fields */
/* Added guarded bit to protect against speculative loads/stores */
li  r5,0
ori r5,r5,(PPC44x_TLB_I|PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX
| PPC44x_TLB_G)
/* that cache thing u see above line is added by some malguns there's
some issue */

li      r0,63                    /* TLB slot 63 */

tlbwe   r3,r0,PPC44x_TLB_PAGEID /* Load the pageid fields */
tlbwe   r4,r0,PPC44x_TLB_XLAT   /* Load the translation fields */
tlbwe   r5,r0,PPC44x_TLB_ATTRIB /* Load the attrib/access fields */

---------

Is this can be considered as a good patch ?

Thanks
Vineeth _
