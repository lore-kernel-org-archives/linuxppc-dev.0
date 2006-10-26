Return-Path: <tnt@246tNt.com>
Message-ID: <4540F16E.2050305@246tNt.com>
Date: Thu, 26 Oct 2006 19:33:34 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: John Rigby <jcrigby@gmail.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>
	<4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
In-Reply-To: <4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
>>
>> * mpc5k2_bestcomm.c (& helpers): I've been in contact with others people
>> using bestcomm and please to see the development was still active. I'm
>> already using latest code on my board but this is not include in this
>> patch. Indeed, it needs some changes for ARCH=powerpc. Moreover, we have
>> a different approach for the tasks. I'll be pleased to work with the
>> bestcomm folks.
>>
>
> So you preload the bestcomm task code in your boot loader?  Do those
> of us using other bootloaders still have the option of loading the
> task code later in linux?
>
> What api are you using?  Sylvain's proposed one based on Dale's with
> some additions from me?  Or have you come up with your own?
>
Hi John,

I've sent him the latest API you describe.

As for task preloading, I'm not too sure what Nicolas' plan is. I'm
waiting to see
what he's proposing.

Since the bestcomm init is in a module, a different module could be
implemented,
(like bestcomm-chrp5k2.ko) that instead of clearing SRAM and doing
everything
from scrtch, would rely on the bootloader more. This would allow
"custom" tasks
to be marked as "don't touch". So if the bootloader want to load
something that
will not be altered by the linux driver (for whatever reason ...)

However, for the tasks like FEC and ATA and everything supported in the
kernel
natively, I would still recommend reload the task code (anyway the
driver is gonna
reset the task and everything ...) Trying to reuse the microcode loaded
by the
bootloader is not a great idea IMHO. (Imagine, the fec driver is changed
to use
the latest microcode, but the bootloader is not ... both have to be in
perfect sync ...)

We would still have to compare the internal FDT and the preloaded one
though since
they have to match ...



       Sylvain
