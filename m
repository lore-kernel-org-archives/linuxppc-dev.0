Return-Path: <rsa@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D48A5B7B99
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 00:14:15 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D26D7DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 00:14:14 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7RE4fYL031463
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 08:04:41 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7REDfC2176190
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 08:13:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7REDXK0015430
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 08:13:40 -0600
Subject: Re: Extending virtio_console to support multiple ports
From: Ryan Arnold <rsa@us.ibm.com>
To: Amit Shah <amit.shah@redhat.com>
In-Reply-To: <20090827065251.GB3218@amit-x200.redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
	<20090826112718.GA11117@amit-x200.redhat.com>
	<20090826154552.GA31910@amit-x200.redhat.com>
	<1251349485.6267.6.camel@concordia>
	<20090827065251.GB3218@amit-x200.redhat.com>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 09:13:28 -0500
Message-Id: <1251382408.3063.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
	brueckner@linux.vnet.ibm.com,
	virtualization@lists.linux-foundation.org, alan@linux.intel.com
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-27 at 12:22 +0530, Amit Shah wrote:
> On (Thu) Aug 27 2009 [15:04:45], Michael Ellerman wrote:
>  Ryan you called his code "pure legacy baggage" if you
> > don't ;)
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=commitdiff;h=d450b4ae023fb4be175389c18f4f87677da03020
> 
> Thanks for the link!
> 
> (and this general area might be the one that doesn't get major upheavals
> in 5-yr spans :-)

Actually, quite the opposite... too many cooks in the kitchen in the
last 6 years have left this code with some historical oddities.  When I
added the interrupt context code in the first place I made sure that the
driver did NOTHING in the interrupt handler except awaken the working
thread.  Someone in the subsequent years thought it'd be a good idea to
have the interrupt handler actually do the work.

Furthermore the front and backends were separated so that new front ends
can be used.  This was sometime in the last 5 years as well.

Let's just say I'm happy to pass the torch on this one.

I would suggest that someone perform throughput tests on this driver at
some point.  At the point where I stopped maintaining it I'd gotten the
driver to the point where there was no jerking output or lost data under
heavy I/O load.  I'm not sure where the driver's at now.

Ryan S. Arnold
