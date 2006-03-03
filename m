Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1CF66679A6
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 06:16:41 +1100 (EST)
Date: Fri, 3 Mar 2006 20:16:33 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
Subject: [PATCH] force stackpointer alignment in 64bit kernel
Message-ID: <20060303191633.GA7792@suse.de>
References: <20060303135717.GA5707@suse.de> <20060303165253.GA6494@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060303165253.GA6494@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix gcc "bug" #26549 which causes pointers to be truncated.

The address of variable val in prom_init_stdout is passed to prom_getprop.
prom_getprop casts the pointer to u32 and passes it to call_prom in the hope
that OpenFirmware stores something there.
But the pointer is truncated in the lower bits and the expected value is
stored somewhere else.

In my testing I had a stackpointer of 0x0023e6b4. val was at offset 120, 
wich has address 0x0023e72c. But the value passed to OF was 0x0023e728.

c00000000040b710:       3b 01 00 78     addi    r24,r1,120
...
c00000000040b754:       57 08 00 38     rlwinm  r8,r24,0,0,28
...
c00000000040b784:       80 01 00 78     lwz     r0,120(r1)
...
c00000000040b798:       90 1b 00 0c     stw     r0,12(r27)
...

The stackpointer came from 32bit code, which appearently has different
alignment rules than 64bit code. The chain was yaboot -> zImage -> vmlinux
Force the stackpointer to be 16 byte aligned.


Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/kernel/head_64.S |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.16-rc5-olh/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-2.6.16-rc5-olh.orig/arch/powerpc/kernel/head_64.S
+++ linux-2.6.16-rc5-olh/arch/powerpc/kernel/head_64.S
@@ -1547,6 +1547,8 @@ _STATIC(__boot_from_prom)
 	mr	r27,r7
 
 	/* Make sure we are running in 64 bits mode */
+	addi	r1,r1,16
+	rlwinm	r1,r1,0,0,28
 	bl	.enable_64b_mode
 
 	/* put a relocation offset into r3 */
