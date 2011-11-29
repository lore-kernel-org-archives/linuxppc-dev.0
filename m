Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 241231007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 06:07:59 +1100 (EST)
Message-ID: <4ED52D87.9000805@freescale.com>
Date: Tue, 29 Nov 2011 13:07:51 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
Subject: Re: Booting Linux on one core of P1022
References: <93CD5F41FDBC6042A6B449764F3B35CC050B8ADA@EU-MBX-01.mgc.mentorg.com>
In-Reply-To: <93CD5F41FDBC6042A6B449764F3B35CC050B8ADA@EU-MBX-01.mgc.mentorg.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/29/2011 02:36 AM, Arshad, Farrukh wrote:
> I am loading the kernel from Uboot as following way
> 
>  
> 
> Setenv bootm_low 0x10000000
> 
> Setenv bootm_size 0x10000000
> 
> Setenv bootm boot=/dev/mmcblk0p3 ro debug rootdelay=5
> 
> Interrupts off
> 
> Bootm start $load1addr - $fdt1addr
> 
> Bootm loados
> 
> Bootm fdt
> 
> Fdt boardsetup
> 
> Fdt chosen
> 
> Bootm prep
> 
> Bootm go

You set up the device tree to reflect a core 1 boot, but I don't see
where you told U-Boot to use core 1.  You need to use a command like
"cpu 1 release 0x10000000 - $fdt1addr 0x45504150" instead of "bootm go".

Also make sure that you pass -b1 to dtc.

BTW, your e-mail client appears to be inappropriately adding
capitalization to pasted text.

-Scott
