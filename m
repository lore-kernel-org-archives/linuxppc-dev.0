Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B2CE0B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 05:53:13 +1000 (EST)
Date: Wed, 9 May 2012 21:53:07 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: powerpc/85xx: p2020rdb - move the NAND address.
Message-ID: <20120509195307.GA25255@linutronix.de>
References: <E9CCADB024EDCD44A9C1083605680C42B9053302@ES05CO.wgti.net>
 <4F740E98.50104@linutronix.de>
 <9460468D-281C-4960-839A-F8435638DE4B@kernel.crashing.org>
 <4F75BD6B.30609@linutronix.de>
 <926BF56B-AA5C-443B-BD52-6844518810DB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <926BF56B-AA5C-443B-BD52-6844518810DB@kernel.crashing.org>
Cc: Bryan Hundven <Bryan.Hundven@watchguard.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kumar Gala | 2012-03-31 09:48:18 [-0500]:

Sorry for the delay Kumar, I though I allready done it.

>Yes, please do.
Here it comes.

>From 5b3e09992615e5670fa8e432e50424466fa9ca1a Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Wed, 9 May 2012 21:48:42 +0200
Subject: [PATCH] Revert "powerpc/85xx: p2020rdb - move the NAND address."

This reverts commit 0c00f65653389a408dfbbee7578e671664eea26a.
The initial commit was my fault. There are two boards out there:
P2020RDB and P2020RDB-PC. I wasn't aware of that and assumed that I have
a RDB board in front of me while I the RDB-PC. This patch makes it work
for the RDB-PC variant and breaks it for the RDB. Now there is a device
tree file available for the RDB-PC which was not there earlier. So with
this revert, everything gets back to normal :)

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/boot/dts/p2020rdb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 153bc76..4d52bce 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -34,7 +34,7 @@
 
 		/* NOR and NAND Flashes */
 		ranges = <0x0 0x0 0x0 0xef000000 0x01000000
-			  0x1 0x0 0x0 0xff800000 0x00040000
+			  0x1 0x0 0x0 0xffa00000 0x00040000
 			  0x2 0x0 0x0 0xffb00000 0x00020000>;
 
 		nor@0,0 {
-- 
1.7.10

>>>> Since both system have the same SoC and the NAND_SPL is always linked
>>>> against 0xfff00000 I don't see anything wrong to relocate the NAND CS
>>>> later to 0xff800000 (or to 0xffa00000) and having it consistent among
>>>> both configs.
>> 
>> what about this thing? Should leave it as it or move to the same
>> location? Since I have no HW *I* would prefer not to touch it :)
>
>Hmm, that implies a u-boot change, right?

Yup.

>- k

Sebastian
