Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F809DE197
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 02:52:40 +1100 (EST)
In-Reply-To: <604678.57629.qm@web15104.mail.cnb.yahoo.com>
References: <604678.57629.qm@web15104.mail.cnb.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E8F6B026-A4C0-46F7-9A70-2EF42C0CD019@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: issue about CONFIG_PPC_MMU and CONFIG_SMP define
Date: Tue, 11 Mar 2008 10:53:15 -0500
To: jie han <jiehanca@yahoo.com.cn>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mar 10, 2008, at 3:15 PM, jie han wrote:

> Hi guys,
>
> I want to simulate compile mutli-core using sequoia(IBM/AMCC 44x  
> processor) source code under kernel arch/powerpc directory.I want  
> to define CONFIG_SMP, I sould define CONFIG_STD_MMU at first,but  
> AMCC 44x don't need to config CONFIG_STD_MMU.Is CONFIG_STD_MMU just  
> for freescale chip? How can I do next? Thanks ahead for your help,

STD_MMU is for all powerpc cpus with a non-BookE MMU.  That includes  
all the 64-bit parts from IBM to date, pasemi's parts, and 32-bit  
parts from IBM & Freescale like the 6xx, 7xx, 7xxx, e600 e300, etc.   
You cannot set this for 44x, because it is a BookE part.

BTW, there's no real relationship between STD_MMU and SMP.  It was  
just a convenient way to restrict the SMP config option in the  
kernel, since all the Linux configs that currently support SMP are  
STD_MMU. We will have BookE configs in the future that do support  
SMP, at which point arch/powerpc/platforms/Kconfig.cputype will be  
changed to allow SMP to be set for those configs.

You can't enable SMP on 44x right now.  It's not supported.

Cheers,
B
