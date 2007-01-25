Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F1D6DE397
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 11:47:41 +1100 (EST)
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <523FF36A-46DF-40CA-BFFE-EDE95EFA3EFE@kernel.crashing.org>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost> <200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
	<1169682996.24996.11.camel@localhost.localdomain>
	<523FF36A-46DF-40CA-BFFE-EDE95EFA3EFE@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 11:45:31 +1100
Message-Id: <1169685931.24996.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-01-25 at 01:29 +0100, Segher Boessenkool wrote:
> >> +static int __devexit ipmi_of_remove(struct of_device *dev)
> >> +{
> >> +	/* should call
> >> +	 * cleanup_one_si(dev->dev.driver_data); */
> >> +	return 0;
> >> +}
> >
> > If your remove doesn't work, don't implement one.
> 
> As explained before, it's the underlying thing that doesn't
> work.  Yeah someone should fix it one day.  Still it's better
> to have this comment than to not have anything at all.  An
> XXX FIXME: tag wouldn't be out of place of course.

If the underlying ipmi stuff cannot cleanup, then the driver should not
have a module_exit() so the module cannot be removed.

Ben.
