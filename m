Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 41F4567C63
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 08:33:45 +1000 (EST)
Date: Wed, 25 Oct 2006 17:32:40 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
Message-ID: <20061025173240.6c6b7dd1@localhost.localdomain>
In-Reply-To: <17727.55399.959132.886705@cargo.ozlabs.ibm.com>
References: <17727.901.368752.68802@cargo.ozlabs.ibm.com>
	<20061025092210.6d208031@localhost.localdomain>
	<17727.55399.959132.886705@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add check for 970GX for __cpu_preinit_ppc970.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

On Thu, 26 Oct 2006 07:34:31 +1000 Paul Mackerras <paulus@samba.org> wrote:

> There was no "issue", there was a possible further optimization, but
> that's not a reason not to put in the cputable entry in the first
> place.


For the deep nap stuff, yes. But the below was what I meant. Only
really needed on firmware that will never ship with a 970GX chip, but
for correctness sake it should still be in there.


diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 645c7f1..d528641 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1646,6 +1646,8 @@ #endif
 	cmpwi	r0,0x3c		/* 970FX */
 	beq	1f
 	cmpwi	r0,0x44		/* 970MP */
+	beq	1f
+	cmpwi	r0,0x45		/* 970GX */
 	bne	2f
 1:	bl	.__cpu_preinit_ppc970
 2:
