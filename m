Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22266DE3F9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 04:22:04 +1000 (EST)
Message-ID: <488624EE.9040502@freescale.com>
Date: Tue, 22 Jul 2008 13:20:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mike Timmons <mike_timmons@trimble.com>
Subject: Re: Problem with cuImage Linux entry from old U-boot
References: <295C5089A56CE143B316E5F67CA99CB001D0626A@cowboy.inovate.inovate.com>
	<20080722180506.GB13940@loki.buserror.net>
	<161B3BAD77161449A144FF054231C3D60249D825@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <161B3BAD77161449A144FF054231C3D60249D825@uss-am-xch-01.am.trimblecorp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Stephen Horton <SHorton@kodiaknetworks.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mike Timmons wrote:
> Related question: I'm using a newer U-boot and managing the load of the
> kernel and the device tree from separate partitions of my boot media.
> 
> Having the two partitions and managing the kernel and the tree
> separately is a bit cumbersome, or maybe I'm just lazy. Regardless, can
> I just use that "static" file name option when I build the kernel, load
> the cuImage, and just invoke 
> 
> bootm <cuImageLoadAddress> ?
> 
> Will it work to just leave off the - <device tree Ram address>
> 
> I think I had it set-p right yesterday and I gave it a try, but no joy.
> 
> Can it be this simple to statically link the device tree with the kernel
> build? For my application I don't see a benefit in keeping them separate
> (the kernel and the tree).

Yes, you can use cuImage to bundle the device tree with the kernel (note 
that the type of image you use *must* match the type of bootm command 
you use), though it's not recommended if you have a u-boot that can 
properly pass a device tree.  cuImage relies on the bd_t to get 
information from u-boot, and this is a very fragile structure, and 
contains less information than the device tree.

-Scott
