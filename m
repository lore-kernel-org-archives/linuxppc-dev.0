Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0411DE41A
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 08:08:55 +1100 (EST)
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080327.200215.-1300539001.kouish@swc.toshiba.co.jp>
References: <20080327.200215.-1300539001.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 28 Mar 2008 08:08:21 +1100
Message-Id: <1206652101.10388.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-03-27 at 20:02 +0900, Ishizaki Kou wrote:
> 
> > I'll try to have a closer look next week, but I'm a bit worried by
> > having all IO go through 2 level of function pointers, the PPE isn't
> > very good at it and this will slow things down more than they
> already
> > are.
> 
> Only on celleb, all IO go through 2 level of function pointers.
>  
> On cell blades, you can set global variable "ppc_pci_io" up at
> function 
> spider_pci_workaround_init() directly instead of calling function
> io_workaround_init(), so all IO on cell blades use only one level of 
> function pointer which is stored in ppc_pci_io.

But I would probably want to also use the PCI Express stuff for cell
blades...

> As you said, if read/write/in/out functions take device parameter,
> taking I/O function pointers into the dev_archdata structure should be
> the best solution. But they don't take device parameter, and they must
> search I/O function pointers with address parameter. I think it's
> better they search pointers from bus bridges, because access mothod
> for a device on its parent bus bridge, not device itself.

What I meant is that if the pointers are in dev_archdata, we can
populate with a different set of pointers for PCI vs. PCI-E.

Ben.
