Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (unknown [192.88.158.103])
	by ozlabs.org (Postfix) with ESMTP id E37A067A42
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 14:20:57 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4P4bAqM012218
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 21:37:10 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k4P4Ko8Q023290
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 23:20:52 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306485CEB@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 3/10] Powerpc: Add tsi108 common function
Date: Thu, 25 May 2006 12:20:46 +0800
MIME-Version: 1.0
Content-Type: text/plain
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


> Can the PCI use indirect like used on most other PPC platforms.

Now , I was confirmed that we cannot switch to it.
Reason for that is our need for the machine check exception handling for PCI Config reads.
Tsi108/109 does not have HW mechanism to ignore Master Abort during Config read and return all ones. 
We have to provide our routine with .fixup section to be able process failed PCI Config reads (Master Abort on PCI).
The indirect method relies on the HW mechanism. 

Another question that appeared around machine check handling was calling of tsi108_clear_pci_cfg_error() function.
We have it to clean errors reported during PCI bus probe. We may skip it (and PCI block still be operational) but
 this will block error reporting mechanism because the PCI block only records the first detected error. 
So we decided it may be better to keep error reporting active by cleaning errors that we expect during PCI enumeration.
 I do not see any harm here because I will  provide our own machine check handler in my board support file according to 
Ben's suggestion.

Roy 


> 
> > +int
> > +tsi108_direct_write_config(struct pci_bus *bus, unsigned 
> int devfunc,
> > +			   int offset, int len, u32 val)
> > +{
> > +	volatile unsigned char *cfg_addr;
> > +
> > +	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
> > +							
> devfunc, offset) |
> > +				     (offset & 0x03));
> > +
> > +#ifdef TSI108_PCI_DEBUG
> > +	printk("PCI CFG write : ");
> > +	printk("%d:0x%x:0x%x ", bus->number, devfunc, offset);
> > +	printk("%d ADDR=0x%08x ", len, (uint) cfg_addr);
> > +	printk("data = 0x%08x\n", val);
> > +#endif
> > +
> > +	switch (len) {
> > +	case 1:
> > +		out_8((u8 *) cfg_addr, val);
> > +		break;
> > +	case 2:
> > +		out_le16((u16 *) cfg_addr, val);
> > +		break;
> > +	default:
> > +		out_le32((u32 *) cfg_addr, val);
> > +		break;
> > +	}
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
> > +
