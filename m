Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0F6BDDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:08:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8JJ0SBo027072
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 15:00:28 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8JK8ME7423346
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 14:08:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8JK8LtZ004468
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 14:08:22 -0600
Date: Wed, 19 Sep 2007 15:08:18 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: Sequoia kernel crash workaround.
Message-ID: <20070919150818.3fecc1bc@weaponx.rchland.ibm.com>
In-Reply-To: <20070919193024.GA28163@lixom.net>
References: <46F16CC9.3010003@ru.mvista.com> <200709192119.48259.sr@denx.de>
	<20070919193024.GA28163@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Josh Boyer <jwboyer@gmail.com>,
	Stefan Roese <sr@denx.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Sep 2007 14:30:24 -0500
Olof Johansson <olof@lixom.net> wrote:

> On Wed, Sep 19, 2007 at 09:19:47PM +0200, Stefan Roese wrote:
> > Hi Valentine,
> > 
> > On Wednesday 19 September 2007, Valentine Barshak wrote:
> > > Disabling write pipelining really helps.
> > > Josh, David, what is the right place to put this workaround to?
> > >
> > > Is it OK to do mtdcr(PLB4A0_ACR, mfdcr(PLB4A0_ACR) & ~PLB4_WRP); in
> > > arch/powerpc/boot/cuboot-sequoia.c:sequoia_fixups()?
> > > or
> > > should this be done in
> > > arch/powerpc/platforms/44x/sequoia.c:sequoia_setup_arch()
> > > with dcr_map, dcr_read/write stuff?
> > 
> > I vote for putting it into sequoia.c, since it's very likely to happen that 
> > Sequoia will at one point be booted without the bootwrapper. Or perhaps it 
> > should go into some common code checking the PVR and disabling it when this 
> > 440EPx/GRx is detected, since all those boards are affected.
> 
> This is what we have setup_cpu functions in the cpu table for. Please
> put it there instead of in board code.

Yes, agreed.

josh
