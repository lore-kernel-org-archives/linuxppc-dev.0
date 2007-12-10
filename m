Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 567B9DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 10:18:56 +1100 (EST)
Message-ID: <475DC966.6070301@freescale.com>
Date: Mon, 10 Dec 2007 17:19:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] Use embedded libfdt in the bootwrapper
References: <20071210032343.GB29611@localhost.localdomain>
	<20071210032839.71412DDDFA@ozlabs.org>
	<20071210173217.GB4497@loki.buserror.net>
	<20071210231056.GC5495@localhost.localdomain>
In-Reply-To: <20071210231056.GC5495@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Dec 10, 2007 at 11:32:17AM -0600, Scott Wood wrote:
>> How does using offsets as devps work if a devp was previously
>> acquired to a node that has to be moved due to a change later made
>> in an earlier part of the tree?
> 
> It doesn't; don't do that.  I just don't think truly persistent 
> phandles are worth the code complexity to implement them.

We already have working code to implement them.  This is a regression 
over flatdevicetree.c, and it (or something else in libfdt) seems to be 
breaking the ep8248e wrapper (it didn't make it in to the last window 
because of dependency on a netdev patch, but I'll probably send it out 
tomorrow).

It breaks the extremely common and useful usage of:

devp = create node;
setprop(devp, "foo", something);
setprop(devp, "bar", something);

> Especially since their use more-or-less completely precludes libfdt's
> "stateless" approach, which has significant other advantages.

It doesn't preclude stateless read-only -- what are the benefits to 
stateless read-write that are worth invalidating all node references any 
time something changes?

-Scott
