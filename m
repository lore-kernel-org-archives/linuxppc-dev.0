Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CCCDDDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Sep 2008 07:51:54 +1000 (EST)
Message-ID: <48C992D6.8050604@emcraft.com>
Date: Fri, 12 Sep 2008 01:51:18 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: prodyut hazarika <prodyuth@gmail.com>
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>	
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>	
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>	
	<48C96349.1040903@emcraft.com>
	<49c0ff980809111153m508f8c90x8db61f2bd287c07@mail.gmail.com>
In-Reply-To: <49c0ff980809111153m508f8c90x8db61f2bd287c07@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

prodyut hazarika wrote:
> Also, it would be great if you could point me what changes are
> necessary to recompile the binutils.
> I would like to test the 256KB changes on my Canyonlands board. I have
> got 16KB/64KB working.
>   

I think this should be enough:

--- binutils-2.16.1/ld/emulparams/elf32ppc.sh.orig    2007-08-21 
14:18:56.000000000 +0200
+++ binutils-2.16.1/ld/emulparams/elf32ppc.sh    2007-08-21 
14:19:42.000000000 +0200
@@ -8,7 +8,7 @@ GENERATE_PIE_SCRIPT=yes
 SCRIPT_NAME=elf
 OUTPUT_FORMAT="elf32-powerpc"
 TEXT_START_ADDR=0x01800000
-MAXPAGESIZE=0x10000
+MAXPAGESIZE=0x40000
 COMMONPAGESIZE=0x1000
 ARCH=powerpc:common
 MACHINE=
--- binutils-2.16.1/bfd/elf32-ppc.c.orig    2007-09-04 
13:11:29.000000000 +0200
+++ binutils-2.16.1/bfd/elf32-ppc.c    2007-09-04 13:10:25.000000000 +0200
@@ -6197,7 +6197,7 @@
 #ifdef __QNXTARGET__
 #define ELF_MAXPAGESIZE        0x1000
 #else
-#define ELF_MAXPAGESIZE        0x10000
+#define ELF_MAXPAGESIZE        0x40000
 #endif
 #define ELF_MINPAGESIZE        0x1000
 #define elf_info_to_howto    ppc_elf_info_to_howto

And you need to rebuild the whole RFS with patched binutils of cause.

Regards, Ilya.
