Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B29FBB7BD9
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 11:34:29 +1000 (EST)
Message-Id: <20091002012427.251860546@mini.kroah.org>
Date: Thu, 01 Oct 2009 18:17:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org,
 stable@kernel.org
Subject: [128/136] powerpc: Fix incorrect setting of __HAVE_ARCH_PTE_SPECIAL
References: <20091002011548.335611824@mini.kroah.org>
In-Reply-To: <20091002012911.GA18542@kroah.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, bernhard.weirich@riedel.net,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	stable-review@kernel.org, alan@lxorguk.ukuu.org.uk, RFeany@mrv.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


2.6.31-stable review patch.  If anyone has any objections, please let us know.

------------------
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
 
