Return-Path: <jhsiao@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 268DCDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 06:02:47 +1100 (EST)
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v2]
From: James Hsiao <jhsiao@amcc.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081029131032.07a3be35@zod.rchland.ibm.com>
References: <1225237276.1850.13.camel@jhsiao-usb>
	<20081028205132.255e674d@zod.rchland.ibm.com>
	<1225246700.1850.61.camel@jhsiao-usb>
	<20081029105413.895d5cdb.kim.phillips@freescale.com>
	<1225299899.4841.7.camel@jhsiao-usb>
	<20081029131032.07a3be35@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Oct 2008 12:03:58 -0700
Message-Id: <1225307038.4841.48.camel@jhsiao-usb>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: jhsiao@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our crypto engine has a ring architecture, the descriptor ring is
controlled by two variable head and tail. head only get increased/0 when
we get a request. tail obly get increased/0 in packet done interrupt.

It is safe if anytime we can only get one request.

Yes, it's possible to have multiple requests. One can write a test which
loop and sending requests. If two such loops and then we have two
requests...

Ok. I will put back the locks in. The code used to have locks, we
removed for performance optimization.

James 

On Wed, 2008-10-29 at 13:10 -0400, Josh Boyer wrote:
> On Wed, 29 Oct 2008 10:04:59 -0700
> James Hsiao <jhsiao@amcc.com> wrote:
> > > > > - Complete lack of locking code, how do you enforce mutually exclusive
> > > > > access to the device?
> > > > 
> > > > The crypto engine have couple bits 'command ready' and 'packet done',
> > > > which servers as semaphore here. So, software don't need extra locking.
> > > 
> > > know if it's applicable at all, but I imagine it's not SMP safe.
> > 
> > No, it's not SMP safe. This driver only support single core processors.
> 
> What about preemption?  You do not have to be a multi-core CPU to have
> SMP-like problems.
> 
> josh
