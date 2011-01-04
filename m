Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id CACDDB7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 08:00:11 +1100 (EST)
In-Reply-To: <20110104132317.006ead39@udp111988uds.am.freescale.net>
References: <OF413F3FA8.B1C9F99A-ON8825780E.006706F6-8825780E.00683E0B@selinc.com>
	<20110104132317.006ead39@udp111988uds.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: Question about combining a PCI driver with an OF driver
Message-ID: <OF2F9BC586.7E8383F3-ON8825780E.0072ACEA-8825780E.00735E90@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Tue, 4 Jan 2011 13:00:07 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

Thanks for the feedback.

> 
> Making a faithful clone of any reasonably complex device strikes me as
> more work than writing a new ethernet driver.
> 
> The last thing you want to end up doing is...
> 
> >  And for speed sake it would go on the PCI bus. 
> > (So much for letting HW make decisions regarding SW :)   )
> 
> ...hacking up the existing driver to deal with the quirks of the clone,
> and having to maintain those hacks. :-)
>

True, but we really didn't want to recreate all the infrastructure that 
the gianfar driver has in it we wanted to just use it.  Maybe what I 
should do is just take the guts of the gianfar driver and make a pure PCI 
driver out of it. 
> 
> It shouldn't matter -- the way buses work in Linux, you should be able
> to add a platform device at any time, and the driver will receive a
> probe() callback.  The driver never actively searches for devices to
> claim.
> 

Okay, I get that and it makes sense with what I know so far about how the 
kernel device model works (which I'm still learning).  So how would I 
manually add a device?  Say I create the PCI wrapper driver that claims 
the clone-TSEC, is there a "register device" type call similar to 
pci_register_driver() that I could put in the wrapper code that causes the 
gfar_probe() to be called?

Bruce
