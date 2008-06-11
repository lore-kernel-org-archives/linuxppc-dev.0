Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BA51BDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 22:29:21 +1000 (EST)
Date: Wed, 11 Jun 2008 16:29:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080611122919.GA2573@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174705.GD28185@polina.dev.rtsoft.ru>
	<CC7DA92D-EE00-48E9-AAA0-51A13A3BD5D0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <CC7DA92D-EE00-48E9-AAA0-51A13A3BD5D0@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2008 at 11:15:08AM -0500, Kumar Gala wrote:
>
> On May 19, 2008, at 12:47 PM, Anton Vorontsov wrote:
>
>> This is needed to access QE GPIOs via Linux GPIO API.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> Acked-By: Timur Tabi <timur@freescale.com>
>> ---
>> Documentation/powerpc/booting-without-of.txt |   27 +++++
>> arch/powerpc/sysdev/qe_lib/Kconfig           |    9 ++
>> arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
>> arch/powerpc/sysdev/qe_lib/gpio.c            |  146 +++++++++++++++++ 
>> +++++++++
>> include/asm-powerpc/qe.h                     |    3 +
>> 5 files changed, 186 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c
>
> applied.

I've just rebased on the pushed out powerpc-next branch, and noticed
that you merged this patch from the old series.

The difference is in absence of arch_initcall() for QE GPIOs
initialization, i.e. in this version boards should explicitly call
qe_add_gpiochips(). So.. was this done deliberately? Or should I send
you an update?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
