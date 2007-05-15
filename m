Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 941C7DDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:38:46 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4F1chna023131
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:38:43 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F1cgGm226148
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 19:38:42 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F1cgk6006055
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 19:38:42 -0600
Subject: Re: [PATCH 0/3] Initial AMCC Bamboo support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070515012629.GC565@localhost.localdomain>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<20070515012629.GC565@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 14 May 2007 20:38:33 -0500
Message-Id: <1179193113.3420.95.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 11:26 +1000, David Gibson wrote:
> On Mon, May 14, 2007 at 09:56:48AM -0500, Josh Boyer wrote:
> > Hi All,
> > 
> > The following patches add the initial AMCC Bamboo eval board support.  
> > 
> > The support for peripheral devices at the moment is rather limited as
> > the board is quite complicated in it's muxing of I/O lines.  Until the
> > bootwrapper can figure out how to setup the EBC peripherals based on the
> > dip switch settings, the DTS will lack any EBC devices.
> 
> Ick.  Can you describe roughly the setup here?  It might be that the
> simplest approach is to include all options in the DTS, and delete
> ones that aren't selected from the bootwrapper.

There's 3 switches that directly control the EBC memory map, and a
handful of other pin strap registers add to that.  To further complicate
things, there are two passes of the Bamboo board and the settings mean
different things to the individual board revisions.

By comparison, there's about 350 lines of code in U-Boot to do the setup
of the EBC.  It's not horrible, but I'm not sure it wants to be
duplicated in the wrapper either.

> I have a patch which might help here, which fills in the ebc's
> 'ranges' property based on the contents of the EBC bridge registers.
> I'm using it as part of the code necessary to get the right address
> for the Ebony flash depending on DIP switch settings.

Ooh... that's actually what I was thinking of doing.  Though I was
planning on poking individual nodes' regs properties instead.

josh
