Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 64511B70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 Aug 2009 11:25:46 +1000 (EST)
Received: by yxe8 with SMTP id 8so1365435yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 01 Aug 2009 18:25:43 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 2 Aug 2009 09:25:43 +0800
Message-ID: <e997b7420908011825n4ba2df16u71d53953d6774c21@mail.gmail.com>
Subject: Re:[PATCH 1/2] powerpc: add kexec support on FSL-Book-E
From: "wilbur.chan" <wilbur512@gmail.com>
To: bigeasy@linutronix.de
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Sebastian,

>From: Sebastian Andrzej Siewior <bigeasy at linutronix.de>

>The relocate_new_kernel() code usually disables the MMU and the small code
>operates on physicall pages while moving the kernel to its final position.
>Book-E doesn't support this so a 1:1 mapping must be created.
>This patch adds support for FSL-BOOK-E implementation.

>Signed-off-by: Sebastian Andrzej Siewior <bigeasy at linutronix.de>




>+      xori    r6,r4,1                 /* Setup TMP mapping in the other A=
ddress space */
>+      slwi    r6,r6,12
>+      oris    r6,r6,(MAS1_VALID|MAS1_IPROT)@h
>+      ori     r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_1GB))@l
>+      mtspr   SPRN_MAS1,r6

>.........

>+      /* find our address */
>+      addi    r7, r30, final_copy_code - relocate_new_kernel
>+
>+      mtspr   SPRN_SRR0,r7
>+      mtspr   SPRN_SRR1,r6
>+      rfi

...........................................................................=
.................................................................

In your patch of Booke support for kexec , it setup a 1GB TMP mapping
and jump to it.

But I saw that, the max size for an e500 entry is 256M=A3=ACso I changed
your code to setup 4*256M entries, and it works well on mpc8541.

Howerver,it didn't work on mpc8548(e500 v2)  and
P2020ds(SMP,e500 v2) , and  'rfi' to final_copy_code failed.(I also
setup a 1:1 mapping for serial ,so I can trap the flowchart in
relocate_new_kernel)


Any suggestions about this ?   Thank you very much.


regards,

wilbur
