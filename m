Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26144DDF0A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 22:02:26 +1100 (EST)
Date: Thu, 27 Mar 2008 20:02:15 +0900 (JST)
Message-Id: <20080327.200215.-1300539001.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
In-Reply-To: <1206355474.7197.35.camel@pasglop>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> I may have missed something in your patch but if the workarounds are
> specific to a given bridge, they may as well set the top level
> indirections once straight to the right workarounds.
> 
> Also, my understanding is that we are pretty much using the same 
> bridge on the cell blades, so is there any way that can be
> consolidated rather than having function pointers ?

Celleb has two different bus bridges such as PCI and PCI-Express, and 
they have different bus access methods. Cell blades support only one 
PCI, so you may have only one indirect access method. That is why I 
introduced second level indirect function.
Considering to embed 'second level' indirect function into first level 
macros, it may break iSeries.

> I'll try to have a closer look next week, but I'm a bit worried by
> having all IO go through 2 level of function pointers, the PPE isn't
> very good at it and this will slow things down more than they already
> are.

Only on celleb, all IO go through 2 level of function pointers.
 
On cell blades, you can set global variable "ppc_pci_io" up at function 
spider_pci_workaround_init() directly instead of calling function
io_workaround_init(), so all IO on cell blades use only one level of 
function pointer which is stored in ppc_pci_io.


> > I may have missed something in your patch but if the workarounds are
> > specific to a given bridge, they may as well set the top level
> > indirections once straight to the right workarounds.
> 
> Looking more closely, I wonder if a good solution would be to move the
> function pointers away from globals, to the dev_archdata structure,
> and thus make them per-device (like the DMA ops)

As you said, if read/write/in/out functions take device parameter,
taking I/O function pointers into the dev_archdata structure should be
the best solution. But they don't take device parameter, and they must
search I/O function pointers with address parameter. I think it's
better they search pointers from bus bridges, because access mothod
for a device on its parent bus bridge, not device itself.

Best regards,
Kou Ishizaki
