Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B514EDDE98
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 15:47:57 +1000 (EST)
Subject: Re: mpc8541 pci1 ioport allocation address space problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Jian <lark@linux.net.cn>
In-Reply-To: <48D4DB89.3040607@linux.net.cn>
References: <48D4DB89.3040607@linux.net.cn>
Content-Type: text/plain
Date: Mon, 22 Sep 2008 15:47:44 +1000
Message-Id: <1222062464.12085.25.camel@pasglop>
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

On Sat, 2008-09-20 at 19:16 +0800, Wang Jian wrote:
> Hi,
> 
> Here I have a 8541 dev board, with 2 e1000 attached to pci0 and a
> homebrewed addon board inserted into pci1. I am trying to make it work
> under 2.6.26-rc8 (2.6.26 broken so I am working at rc8).
> 
> The ioports allocation reads
> 
> $ cat /proc/ioports
> 00000000-000fffff : /pci@e0008000
>   00001000-0000103f : 0000:00:0a.0
>   00001040-0000107f : 0000:00:0b.0
> ffefe000-ffffdfff : /pci@e0009000
>   ffeff000-ffeff00f : 0001:01:0a.0
>   ffeff010-ffeff01f : 0001:01:0b.0
>   ffeff020-ffeff02f : 0001:01:0c.0
>   ffeff030-ffeff03f : 0001:01:0d.0
> 
> The port allocation for pci1 looks ridiculous. The addon board doesn't work.
> 
> After poking around, I find pci_process_bridge_OF_ranges() in
> arch/powerpc/kernel/pci-common.c

 .../...

This is expected and should work. Depending on the relative
physical addresses of IO space and the order in which the bridges are
discovered, the bridge IO ports will look at either positive or negative
values. This should be fine, as port numbers are supposed to be 32 bits
and in-kernel arithmetic should do the right thing... I suppose unless a
driver stores those in a 64 bits integer and doesn't sign extend.

I would like to change that whole thing to something more similar to
64 bits where I reserve a portion of the address space for IO ports,
though address space on 32 bits platforms is scarce, but nothing I have
time to toy with right now.

Cheers,
Ben. 
