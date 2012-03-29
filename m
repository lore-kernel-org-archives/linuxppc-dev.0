Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 08893B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2012 18:26:27 +1100 (EST)
Message-ID: <4F740E98.50104@linutronix.de>
Date: Thu, 29 Mar 2012 09:26:16 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/85xx: p2020rdb - move the NAND address.
References: <E9CCADB024EDCD44A9C1083605680C42B9053302@ES05CO.wgti.net>
In-Reply-To: <E9CCADB024EDCD44A9C1083605680C42B9053302@ES05CO.wgti.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Bryan Hundven <Bryan.Hundven@watchguard.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/28/2012 10:30 PM, Bryan Hundven wrote:
>  > It is not at 0xffa00000. According to current u-boot source the NAND
>  > controller is always at 0xff800000 and it is either at CS0 or CS1
>  > depending on NAND or NAND+NOR mode. In 36bit mode it is shifted to
>  > 0xfff800000 but it has always an eight there and never an A.
>  >
>  > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>  > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> I am having a hard time verifying this change. I don't think you are
> wrong, I'm just having a hard time following.
>
> I do not see where this has always been 0xff800000 in u-boot.

<cut>

> But while I was checking changes in arch/powerpc/, I found this change
> and wanted to understand why 0xffa00000 has worked for us for so long?

Kumar, I wasn't wrong entirely I just missed one detail. U-Boot
provides two different configs, not just one define like its for
SPL/SPI/...:

- include/configs/P1_P2_RDB.h

  #ifndef CONFIG_NAND_SPL
  #define CONFIG_SYS_NAND_BASE            0xffa00000
  #ifdef CONFIG_PHYS_64BIT
  #define CONFIG_SYS_NAND_BASE_PHYS       0xfffa00000ull
  #else
  #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
  #endif
  #else
  #define CONFIG_SYS_NAND_BASE            0xfff00000
  #ifdef CONFIG_PHYS_64BIT
  #define CONFIG_SYS_NAND_BASE_PHYS       0xffff00000ull
  #else
  #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
  #endif
  #endif

- include/configs/p1_p2_rdb_pc.h

  #ifdef CONFIG_NAND_FSL_ELBC
  #define CONFIG_SYS_NAND_BASE            0xff800000
  #ifdef CONFIG_PHYS_64BIT
  #define CONFIG_SYS_NAND_BASE_PHYS       0xfff800000ull
  #else
  #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
  #endif

and for kernel they use both the same device tree. So with the change,
the _pc variant finds its flash. Before that it worked for the non-pc
variant only if NAND_SPL wasn't used.
Any suggestion on fixing that? Providing a new dt for _pc would "fix"
it but the non pc variant won't find it in the case of NAND_SPL.

Since both system have the same SoC and the NAND_SPL is always linked
against 0xfff00000 I don't see anything wrong to relocate the NAND CS
later to 0xff800000 (or to 0xffa00000) and having it consistent among
both configs.

> -Bryan

Sebastian
