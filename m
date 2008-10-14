Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 646FFDDDE0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 20:08:53 +1100 (EST)
Date: Tue, 14 Oct 2008 11:08:44 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: don't pass unused regs around in head_.*.S
Message-ID: <20081014090844.GA20507@Chamillionaire.breakpoint.cc>
References: <1223820494-7822-1-git-send-email-sebastian@breakpoint.cc>
	<1223820494-7822-2-git-send-email-sebastian@breakpoint.cc>
	<1223940312.8157.281.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1223940312.8157.281.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt | 2008-10-14 10:25:12 [+1100]:

>On Sun, 2008-10-12 at 16:08 +0200, Sebastian Andrzej Siewior wrote:
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> 
>> This looks like a relict from arch/ppc. machine_init() is accepting
>> only two parameters (dtb, phys) and is using only the first one.
>
>This isn't 100% correct actually...
>
>First, the base head_32.S (could be called head_6xx.S I suppose)
>supports a few more calling conventions such as the real OF one, with
>added support for initrd and cmdline in registers , and the BootX one.
Yep, those extra register are only used in prom_init() or bootx_init().
In case we called one of those two we end up again in __start(dtb, phys, 0)

>Then, calling convention for the other cases is slightly better defined
>than just having r3 contain a device-tree pointer. The physical address
>is an important part of it, the fact that r5 is NULL to differenciate
>from an OF entry too, and we're moving toward the full ePAPR definition.
Okay. Power_ePAPR_APPROVED_v1.0.pdf says we have r4, r5, r8, r9 = 0, r6 =
magic and r7 size of the initial mapped area. I don't see the physical
address here.

Do you want me to update the comment / patch description or leave
everything as it? I guess we don't have to pass unused register to
machine_init(), do we?

>Cheers,
>Ben.

Sebastian
