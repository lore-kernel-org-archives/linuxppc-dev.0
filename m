Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E265067B14
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 18:20:02 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673066CF6DF@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673066CF6DF@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 18:19:50 +1000
Message-Id: <1149236391.16202.70.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-02 at 16:05 +0800, Zang Roy-r61911 wrote:
> > > If I really need to use bat0 or bat1( I see that the 
> > general mmu use 
> > > bat2 and bat3, where should I set up them?
> > > 
> > > For tsi108 pci configuration access, I need to map 16Mbyte physical 
> > > address.  If I do not use an extra bat, I can not get the correct 
> > > virtual address use ioremap.
> > 
> > What do you mean ? An ioremap will work, it will give you any 
> > virtual address, you just have to store that in a global 
> > instead of hard coding it. Hard coded virtual addresses are 
> > bad. Especially for things like PCI config space that really 
> > isn't performance sensitive.
> > 
> > Ben.
> > 
> 
> I had hoped to get the pci configure base address by ioremap, but failed.
> the tsi108 register locates at 0xc000,0000 ~0xC001,0000. It is OK to 
> access them by ioremap. While pci configure access need to ioremap 
> 0xfb00,0000 ~0xfc00,0000. 
> I traced my code, when I do ioremap, there is no bat match, I get the virtual
> address from ioremap_bot. the init ioremap_bot is 0xfe000000. When I do
> tsi108_csr_vir_base = ioremap(0xfb000000,0x1000000), 
> the ioremap_bot is 0xfdffe000 ( I get the serial port ioremap steal some space), 
> tsi108_csr_vir_base = 0xfdfee000, I can not access the configure space with this
> address.

What happens if you try ?

> While if I use bat0 or bat1 to map my tsi108 register space, the ioremap_bot will keep
> to 0xfe000000 until I do 
> tsi108_csr_vir_base = ioremap(0xfb000000,0x1000000)
> then I get  tsi108_csr_vir_base = 0xfd000000. Everything is OK.

Both should work fine

Ben.
