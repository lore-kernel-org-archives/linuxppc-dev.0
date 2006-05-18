Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (unknown [192.88.158.103])
	by ozlabs.org (Postfix) with ESMTP id 76D7567A60
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 16:50:00 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4I762H7001451
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 00:06:02 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4I6nvWW009999
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 01:49:58 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C0589@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 3/10] Powerpc: Add tsi108 common function
Date: Thu, 18 May 2006 14:49:55 +0800
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



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]

> 
> Can the PCI use indirect like used on most other PPC platforms.

I am not sure. I will have a try!

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
> 
