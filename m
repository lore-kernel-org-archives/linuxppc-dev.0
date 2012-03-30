Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 027C1B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 01:04:36 +1100 (EST)
Message-ID: <4F75BD6B.30609@linutronix.de>
Date: Fri, 30 Mar 2012 16:04:27 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: powerpc/85xx: p2020rdb - move the NAND address.
References: <E9CCADB024EDCD44A9C1083605680C42B9053302@ES05CO.wgti.net>
 <4F740E98.50104@linutronix.de>
 <9460468D-281C-4960-839A-F8435638DE4B@kernel.crashing.org>
In-Reply-To: <9460468D-281C-4960-839A-F8435638DE4B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Bryan Hundven <Bryan.Hundven@watchguard.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/29/2012 03:10 PM, Kumar Gala wrote:

>> - include/configs/P1_P2_RDB.h
>>
>> #ifndef CONFIG_NAND_SPL
>> #define CONFIG_SYS_NAND_BASE            0xffa00000
>> #ifdef CONFIG_PHYS_64BIT
>> #define CONFIG_SYS_NAND_BASE_PHYS       0xfffa00000ull
>> #else
>> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
>> #endif
>> #else
>> #define CONFIG_SYS_NAND_BASE            0xfff00000
>> #ifdef CONFIG_PHYS_64BIT
>> #define CONFIG_SYS_NAND_BASE_PHYS       0xffff00000ull
>> #else
>> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
>> #endif
>> #endif
>>
>> - include/configs/p1_p2_rdb_pc.h
>>
>> #ifdef CONFIG_NAND_FSL_ELBC
>> #define CONFIG_SYS_NAND_BASE            0xff800000
>> #ifdef CONFIG_PHYS_64BIT
>> #define CONFIG_SYS_NAND_BASE_PHYS       0xfff800000ull
>> #else
>> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
>> #endif
>>
>
> There are two (well 3 since rdb-pc has both 32b&  36b) in the tree now:
>
> arch/powerpc/boot/dts/p2020rdb.dts
> arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
> arch/powerpc/boot/dts/p2020rdb-pc_36b.dts

Okay. So I assume that one has the proper NAND address and my patch
should be reverted then. Do want a patch from me for that?

>> Since both system have the same SoC and the NAND_SPL is always linked
>> against 0xfff00000 I don't see anything wrong to relocate the NAND CS
>> later to 0xff800000 (or to 0xffa00000) and having it consistent among
>> both configs.

what about this thing? Should leave it as it or move to the same
location? Since I have no HW *I* would prefer not to touch it :)

>
> - k

Sebastian
