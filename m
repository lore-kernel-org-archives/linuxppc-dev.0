Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCD27DE619
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:54:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3ABsEvV024959
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:54:14 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3ABsDDg239424
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:54:13 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3ABsDil011711
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:54:13 -0400
Date: Thu, 10 Apr 2008 06:52:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "M B" <super.firetwister@googlemail.com>
Subject: Re: ppc405ep emac driver loading problem
Message-ID: <20080410065211.7befbfba@zod.rchland.ibm.com>
In-Reply-To: <6a6049b80804100337m6ab33fd5wd3cf9524e7f6d721@mail.gmail.com>
References: <6a6049b80804100337m6ab33fd5wd3cf9524e7f6d721@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 Apr 2008 12:37:45 +0200
"M B" <super.firetwister@googlemail.com> wrote:

> Hi,
> I'm porting vanilla 2.6.25-rc8 (arch=powerpc) to a new board. UART is
> already working in the kernel and Uboot with UART and ethernet is also
> working.
> But I can't get the emac driver (ibm_newemac) working under Linux.
> On boot emac_init get's called and exits normally, but no probe or
> open will get called and no network devices (except lo) are known to
> the kernel.
> 
> Do I have to do something more, than adding the mals and emacs to the
> device tree? I haven't seen any 40x or 44x board in the platforms
> folder doing something special for the emac.
> 
> Any hints?

You have to call of_platform_bus_probe with the various bus types for
your board.  See the top few functions of:

arch/powerpc/platforms/40x/walnut.c

for an example.

josh
