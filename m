Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6BF8867A6F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 18:05:56 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k528MTbo003878
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 01:22:29 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5285rA6019927
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 03:05:54 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673066CF6DF@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Fri, 2 Jun 2006 16:05:45 +0800 
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


> > If I really need to use bat0 or bat1( I see that the 
> general mmu use 
> > bat2 and bat3, where should I set up them?
> > 
> > For tsi108 pci configuration access, I need to map 16Mbyte physical 
> > address.  If I do not use an extra bat, I can not get the correct 
> > virtual address use ioremap.
> 
> What do you mean ? An ioremap will work, it will give you any 
> virtual address, you just have to store that in a global 
> instead of hard coding it. Hard coded virtual addresses are 
> bad. Especially for things like PCI config space that really 
> isn't performance sensitive.
> 
> Ben.
> 

I had hoped to get the pci configure base address by ioremap, but failed.
the tsi108 register locates at 0xc000,0000 ~0xC001,0000. It is OK to 
access them by ioremap. While pci configure access need to ioremap 
0xfb00,0000 ~0xfc00,0000. 
I traced my code, when I do ioremap, there is no bat match, I get the virtual
address from ioremap_bot. the init ioremap_bot is 0xfe000000. When I do
tsi108_csr_vir_base = ioremap(0xfb000000,0x1000000), 
the ioremap_bot is 0xfdffe000 ( I get the serial port ioremap steal some space), 
tsi108_csr_vir_base = 0xfdfee000, I can not access the configure space with this
address.
While if I use bat0 or bat1 to map my tsi108 register space, the ioremap_bot will keep
to 0xfe000000 until I do 
tsi108_csr_vir_base = ioremap(0xfb000000,0x1000000)
then I get  tsi108_csr_vir_base = 0xfd000000. Everything is OK.

Roy
