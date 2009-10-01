Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 028F0B7BB3
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 09:00:30 +1000 (EST)
Subject: patch powerpc-fix-incorrect-setting-of-__have_arch_pte_special.patch
	added to 2.6.30-stable tree
To: Bernhard.Weirich@riedel.net, benh@kernel.crashing.org,
	bernhard.weirich@riedel.net, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, stable@kernel.org
From: <gregkh@suse.de>
Date: Thu, 01 Oct 2009 15:51:50 -0700
In-Reply-To: <1253776613.7103.433.camel@pasglop>
Message-Id: <20091001225418.41F82487FF@coco.kroah.org>
Cc: stable@kernel.org, stable-commits@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that we have just queued up the patch titled

    Subject: powerpc: Fix incorrect setting of __HAVE_ARCH_PTE_SPECIAL

to the 2.6.30-stable tree.  Its filename is

    powerpc-fix-incorrect-setting-of-__have_arch_pte_special.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From benh@kernel.crashing.org  Thu Oct  1 15:36:15 2009
From: Weirich, Bernhard <Bernhard.Weirich@riedel.net>
Date: Thu, 24 Sep 2009 17:16:53 +1000
Subject: powerpc: Fix incorrect setting of __HAVE_ARCH_PTE_SPECIAL
To: stable <stable@kernel.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, bernhard.weirich@riedel.net, RFeany@mrv.com
Message-ID: <1253776613.7103.433.camel@pasglop>


From: Weirich, Bernhard <Bernhard.Weirich@riedel.net>

[I'm going to fix upstream differently, by having all CPU types
actually support _PAGE_SPECIAL, but I prefer the simple and obvious
fix for -stable. -- Ben]

The test that decides whether to define __HAVE_ARCH_PTE_SPECIAL on
powerpc is bogus and will end up always defining it, even when
_PAGE_SPECIAL is not supported (in which case it's 0) such as on
8xx or 40x processors.

Signed-off-by: Bernhard Weirich <bernhard.weirich@riedel.net>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/powerpc/include/asm/pte-common.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -176,7 +176,7 @@ extern unsigned long bad_call_to_PMD_PAG
 #define HAVE_PAGE_AGP
 
 /* Advertise support for _PAGE_SPECIAL */
-#ifdef _PAGE_SPECIAL
+#if _PAGE_SPECIAL != 0
 #define __HAVE_ARCH_PTE_SPECIAL
 #endif
 


Patches currently in stable-queue which might be from Bernhard.Weirich@riedel.net are

queue-2.6.30/powerpc-fix-incorrect-setting-of-__have_arch_pte_special.patch
