Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8383CDE981
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:25:03 +1000 (EST)
Subject: Re: 1 GB lowmem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B046E79B3@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B046E79B3@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Wed, 21 May 2008 17:24:38 -0400
Message-Id: <1211405078.8297.258.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 13:00 -0500, Rune Torgersen wrote:
> Hi
> 
> I am trying to enable 1 GB of lowmem on a Freescale 8280.
> In arch/ppc this was easilly done by:
> CONFIG_ADVANCED_OPTIONS=y
> CONFIG_HIGHMEM_START=0xfe000000
> CONFIG_LOWMEM_SIZE_BOOL=y
> CONFIG_LOWMEM_SIZE=0x40000000
> CONFIG_KERNEL_START_BOOL=y
> CONFIG_KERNEL_START=0xa0000000
> 
> This does not work in arch/powerpc. CPU hangs as soon as init starts.
> Any ideas what to look at, what to change?

You probably need to lower TASK_SIZE too.

> The reason I want to do this is because I cannot get highmem support to
> work when using CONFIG_PREEMPT_RT.
> (hitting a bug_on in kmap_atomic)

We should look into fixing that :-)

Ben.
