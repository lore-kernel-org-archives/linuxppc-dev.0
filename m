Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3E593DE081
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:30:32 +1100 (EST)
Date: Mon, 5 Jan 2009 19:30:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Liu Dave <DaveLiu@freescale.com>
Subject: Re: [PATCH v2 3/4] powerpc/fsl_pci: Add MPC83xx PCI-E controller
	RCmode support
Message-ID: <20090105163029.GA7345@oksana.dev.rtsoft.ru>
References: <20081229210559.GA10801@oksana.dev.rtsoft.ru>
	<D7CCA83BB0796C49BC0BB53B6AB1208904074B@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <D7CCA83BB0796C49BC0BB53B6AB1208904074B@zch01exm21.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Huang Changming-R66093 <Chang-Ming.Huang@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 05, 2009 at 04:18:26PM +0800, Liu Dave wrote:
> > +static void __iomem *mpc83xx_pcie_remap_cfg(struct pci_bus *bus,
> > +				    unsigned int devfn, int offset)
> > +{
> > +	struct pci_controller *hose = bus->sysdata;
> > +	struct mpc83xx_pcie *pcie = hose->dn->data;
> > +	u8 bus_no = bus->number - hose->first_busno;
> > +	u32 dev_base = bus_no << 20 | devfn << 12;
> 
> Hello Anton,
> 
> There is one bug for the bus/device number shift according to the latest
> 83xx UM. The shift should be
> 
> dev_base = (bus_no << 24) | (devfn << 16);
> 
> You can download the latest MPC8315 UM as reference from
> http://www.freescale.com.

Ah! Thanks a lot, that explains a lot.

I was quite puzzled why FSL u-boots are using "wrong" shifts, so I
"corrected" them. And indeed, I was looking at the old reference
manual: MPC8315ERM   Rev. 0   09/2007. The new manual (MPC8315ERM
Rev. 1   2/2008) specifies other bits, the same as used in the FSL
U-Boot, i.e. 31:24 for bus no, 23:19 and 18:16 for device and func.

> AFAIK, you will work on the u-boot for 83xx PEX, Any question forward
> to Jerry Huang (in cc). I think he should have some update for PEX.

Much thanks for the information,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
