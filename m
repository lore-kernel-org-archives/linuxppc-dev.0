Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 448BE679E1
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 14:06:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4J4Mgdp029696
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 21:22:42 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4J46ZfT012917
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 23:06:37 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730631505A@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>
Subject: RE: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
Date: Fri, 19 May 2006 12:06:33 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Cc: Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> Jeff Garzik wrote:
> > Benjamin Herrenschmidt wrote:
> >> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
> ..
> >>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
> >>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, 
> void __iomem
> >> *mmio)
> >>>  {
> >>>       u32 tmp;
> >>> -
> >>> +#ifndef CONFIG_PPC
> >>>       writel(0, mmio + MV_GPIO_PORT_CTL);
> >>> +#endif
> >>
> >> You'll have to do better here too... I don't wee why when 
> compiled on
> >> PPC, this driver should "magically" not clear those 
> bits... At the very
> >> least, you should test the machine type if you want to do something
> >> specific to your platform, but first, you'll have to 
> convince Jeff why
> >> this change has to be done in the first place and if there 
> is a better
> >> way to handle it.
> > 
> > Correct...  it does seem some bugs were found, but #ifdef 
> powerpc is 
> > certainly out of the question.  We want the driver to work without 
> > ifdefs on all platforms.
> 
> Yup.  I have a powerpc platform here with PCI-X, and a PCI-X 
> Marvell card
> to try in it.  So I'll pick up these changes and try to 
> integrate them a
> little more nicely in my internal updated driver, and then 
> pass it on to Jeff.
> 
> Cheers
> 
