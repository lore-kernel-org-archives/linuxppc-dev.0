Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CCDFCDE0F6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 21:53:06 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m55Bt8rl020635
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 07:55:08 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m55BqgI0239908
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 07:52:42 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m55Bqgcm032756
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 07:52:42 -0400
Date: Thu, 5 Jun 2008 06:52:25 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605065225.739ec4a8@zod.rchland.ibm.com>
In-Reply-To: <200806051045.42966.sr@denx.de>
References: <200806041706.21557.sr@denx.de> <200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
	<200806051045.42966.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 10:45:42 +0200
Stefan Roese <sr@denx.de> wrote:

> On Thursday 05 June 2008, Jean Delvare wrote:
> > > > Maybe it is time to remove the index, or maybe we should go back to
> > > > using both a static and the index. But at the time we decided to
> > > > enforce an index.
> > >
> > > So what should we do now? Currently I2C doesn't work at all on 4xx since
> > > the driver expects the "index" property and no dts sets this property.
> > > Personally I would like to move to using cell-index here, since this
> > > seems to be more common. But I could also life with removing the index
> > > property and using the "static index" if this is preferred and/or
> > > acceptable.
> > >
> > > Please advise. Thanks.
> >
> > As far as I am concerned, it's really up to the maintainers and users
> > of this platform. All I am asking for is that you do not call
> > i2c_add_numbered_adapter() on an adapter with an automatically
> > generated number. This function must only be used for adapter's those
> > number is well defined. If an adapter doesn't have a well-defined
> > number then use i2c_add_adapter() (but then you can no longer declare
> > your I2C devices as part of the platform data.)
> 
> Full ack from me. So I suggest to use "cell-index" if available and otherwise 
> use an incremented number, same as the FSL i2c driver does now:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html
> 
> If nobody objects I'll send a patch to add the cell-index to all 4xx dts files 
> in a short while.

I have no large objections.  Though as Scott pointed out, this isn't
really a proper use of "cell-index".  Something like:

"linux,i2c-index"

seems to be a more distinct definition of what this is.  But I have no
idea how well that would go over, and it would probably need to be
changed in all the fsl boards as well.

josh
