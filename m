Return-Path: <scottwood@freescale.com>
Message-ID: <46CDC86E.2070907@freescale.com>
Date: Thu, 23 Aug 2007 12:48:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
	<20070822010907.GA12472@localhost.localdomain>
	<20070822172456.GA22932@ld0162-tx32.am.freescale.net>
	<20070823020147.GB7042@localhost.localdomain>
In-Reply-To: <20070823020147.GB7042@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> Actually, no - sorry, that's the other problem with this, which I
> forgot to mention.  On real OF, the "name" property contains the
> node's name *without the unit address*; that is, only the portion
> before the '@'.  So your getprop change does not match real OF
> behaviour - and real OF behaviour will not do what you want for
> dt_get_path().

Ah, OK.

> Actually, in any case, I don't think we want to implement get_path()
> this way for real OF.  Better to have get_path() itself as a callback:
> on real OF I believe we can directly ask for the full path to a given
> phandle, the get name based implementation can then be made specific
> to the flat device tree.
> 
> Or actually, I think we might be able to come up with a get_path()
> implementation for flat tree that's less hideous than repeatedly
> calling get_parent() which is an ugly, ugly operation on the flat tree

It's likely to be ugly no matter what, though I'll try to come up with 
something slightly nicer.  If I were doing this code from scratch, I'd 
probably liven the tree first and reflatten it to pass to the kernel.

> (and will get worse with libfdt).

Why is that?

>>Plus, something might come along that needs to dynamically look for
>>either name or something else.  It's more flexible this way.
> 
> Hrm... "something might come along" just seems contrived to me.

Well, I generally prefer doing things the more flexible way in the 
absence of a good reason not to.  OF returning the bare name is a good 
reason not to.

-Scott
