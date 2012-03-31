Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C0529B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2012 01:48:27 +1100 (EST)
Subject: Re: powerpc/85xx: p2020rdb - move the NAND address.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4F75BD6B.30609@linutronix.de>
Date: Sat, 31 Mar 2012 09:48:18 -0500
Message-Id: <926BF56B-AA5C-443B-BD52-6844518810DB@kernel.crashing.org>
References: <E9CCADB024EDCD44A9C1083605680C42B9053302@ES05CO.wgti.net>
 <4F740E98.50104@linutronix.de>
 <9460468D-281C-4960-839A-F8435638DE4B@kernel.crashing.org>
 <4F75BD6B.30609@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bryan Hundven <Bryan.Hundven@watchguard.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 30, 2012, at 9:04 AM, Sebastian Andrzej Siewior wrote:

> On 03/29/2012 03:10 PM, Kumar Gala wrote:
> 
>>> - include/configs/P1_P2_RDB.h
>>> 
>>> #ifndef CONFIG_NAND_SPL
>>> #define CONFIG_SYS_NAND_BASE            0xffa00000
>>> #ifdef CONFIG_PHYS_64BIT
>>> #define CONFIG_SYS_NAND_BASE_PHYS       0xfffa00000ull
>>> #else
>>> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
>>> #endif
>>> #else
>>> #define CONFIG_SYS_NAND_BASE            0xfff00000
>>> #ifdef CONFIG_PHYS_64BIT
>>> #define CONFIG_SYS_NAND_BASE_PHYS       0xffff00000ull
>>> #else
>>> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
>>> #endif
>>> #endif
>>> 
>>> - include/configs/p1_p2_rdb_pc.h
>>> 
>>> #ifdef CONFIG_NAND_FSL_ELBC
>>> #define CONFIG_SYS_NAND_BASE            0xff800000
>>> #ifdef CONFIG_PHYS_64BIT
>>> #define CONFIG_SYS_NAND_BASE_PHYS       0xfff800000ull
>>> #else
>>> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
>>> #endif
>>> 
>> 
>> There are two (well 3 since rdb-pc has both 32b&  36b) in the tree now:
>> 
>> arch/powerpc/boot/dts/p2020rdb.dts
>> arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
>> arch/powerpc/boot/dts/p2020rdb-pc_36b.dts
> 
> Okay. So I assume that one has the proper NAND address and my patch
> should be reverted then. Do want a patch from me for that?

Yes, please do.

>>> Since both system have the same SoC and the NAND_SPL is always linked
>>> against 0xfff00000 I don't see anything wrong to relocate the NAND CS
>>> later to 0xff800000 (or to 0xffa00000) and having it consistent among
>>> both configs.
> 
> what about this thing? Should leave it as it or move to the same
> location? Since I have no HW *I* would prefer not to touch it :)

Hmm, that implies a u-boot change, right?

- k
