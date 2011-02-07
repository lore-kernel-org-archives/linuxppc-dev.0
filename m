Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07583B7101
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 08:40:50 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p17Lc2qI019390
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 14:38:02 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p17LeXL4090594
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 14:40:33 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p17LeXAF009075
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Feb 2011 14:40:33 -0700
Subject: Re: [PATCH v2 3/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1297055437.14982.57.camel@pasglop>
References: <1294267483.24377.30.camel@flin.austin.ibm.com>
	<1297055437.14982.57.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 15:40:32 -0600
Message-ID: <1297114832.24377.42.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 16:10 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2011-01-05 at 16:44 -0600, Tseng-Hui (Frank) Lin wrote:
> > This patch adds support for handling IO Event interrupts which come
> > through at the /event-sources/ibm,io-events device tree node.
> 
>  .../...
> 
> The previous patches regarding the error log sometimes call it error log
> and sometimes event log. Can you consolidate that ?

Sure. The top level of the RTAS error/event log is for both error and
event. Starting V6 extension, they should be all event.

> 
> > +int pseries_ioei_register_handler(pseries_ioei_handler_t handler)
> > +{
> 
> Shouldn't we have a void * to attach with each client so it can put
> its private data there and get them back in the handler ?

Although not used at this moment, this is a good idea. Will add private
data.

> We are -really- re-inventing interrupts and/or notifiers here, which
> I find a tad annoying..

Agree. This is ugly. We could have just used the regular interrupt
mechanism if the firmware didn't use shared rtas call and interrupt
to report multiple types of events.

> 
> Cheers,
> Ben.
> 
> 
