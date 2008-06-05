Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4157FDDF87
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 11:10:41 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m5619s0i023286
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 11:09:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m561ALtO3268850
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 11:10:21 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m561AcA1031011
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 11:10:39 +1000
Date: Fri, 6 Jun 2008 08:47:31 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605224731.GE30980@yookeroo.seuss>
References: <200806041706.21557.sr@denx.de> <200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
	<200806051045.42966.sr@denx.de>
	<20080605065225.739ec4a8@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080605065225.739ec4a8@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 06:52:25AM -0500, Josh Boyer wrote:
> On Thu, 5 Jun 2008 10:45:42 +0200
> Stefan Roese <sr@denx.de> wrote:
> 
> > On Thursday 05 June 2008, Jean Delvare wrote:
> > > > > Maybe it is time to remove the index, or maybe we should go back to
> > > > > using both a static and the index. But at the time we decided to
> > > > > enforce an index.
> > > >
> > > > So what should we do now? Currently I2C doesn't work at all on 4xx since
> > > > the driver expects the "index" property and no dts sets this property.
> > > > Personally I would like to move to using cell-index here, since this
> > > > seems to be more common. But I could also life with removing the index
> > > > property and using the "static index" if this is preferred and/or
> > > > acceptable.
> > > >
> > > > Please advise. Thanks.
> > >
> > > As far as I am concerned, it's really up to the maintainers and users
> > > of this platform. All I am asking for is that you do not call
> > > i2c_add_numbered_adapter() on an adapter with an automatically
> > > generated number. This function must only be used for adapter's those
> > > number is well defined. If an adapter doesn't have a well-defined
> > > number then use i2c_add_adapter() (but then you can no longer declare
> > > your I2C devices as part of the platform data.)
> > 
> > Full ack from me. So I suggest to use "cell-index" if available and otherwise 
> > use an incremented number, same as the FSL i2c driver does now:
> > 
> > http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html
> > 
> > If nobody objects I'll send a patch to add the cell-index to all 4xx dts files 
> > in a short while.
> 
> I have no large objections.  Though as Scott pointed out, this isn't
> really a proper use of "cell-index".  Something like:
> 
> "linux,i2c-index"
> 
> seems to be a more distinct definition of what this is.  But I have no
> idea how well that would go over, and it would probably need to be
> changed in all the fsl boards as well.

Don't do that.  Use aliases, that's what they're for.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
