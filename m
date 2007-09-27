Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D27AFDDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 08:20:11 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8RLBuSY019305
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 17:11:56 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8RMK8eN459900
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 16:20:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8RMK8XM012828
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 16:20:08 -0600
Date: Thu, 27 Sep 2007 17:20:07 -0500
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
Message-ID: <20070927222007.GE18686@austin.ibm.com>
References: <20070927191233.201980@gmx.net>
	<20070927192551.GK7970@austin.ibm.com>
	<20070927193131.201920@gmx.net>
	<20070927205012.GN7970@austin.ibm.com>
	<20070927211700.201970@gmx.net>
	<20070927213503.GA18686@austin.ibm.com>
	<20070927215735.201960@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070927215735.201960@gmx.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 11:57:35PM +0200, Gerhard Pircher wrote:
> 
> > Based on your boot messages, it looks like you are failing somewhere in
> > pci probe.  My olde-fashioned, slow, but-usually-works method is to
> > sprinkle enough printk's into the code to catch it in the act.
> I guess the code in arch/powerpc/pci*.c is the right place to sprinkle
> some printk's into the code?

The last identifiable message I was

<7>PCI: Calling quirk...

which is from drivers/pci/quirks.c

...CI: Found 0000:00:07.2 [1106/303...

and this is from pci_setup_device() in drivers/pci/probe.c  So I'd look
to see if pci_setup_device() ever returned, and then I'd look to see
what happened next.

--linas
