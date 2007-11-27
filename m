Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3C6BDDDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 04:23:06 +1100 (EST)
Date: Tue, 27 Nov 2007 20:27:58 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
	nodes
Message-ID: <20071127172758.GA15429@localhost.localdomain>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153940.GC14183@localhost.localdomain>
	<474C3C79.5060908@ru.mvista.com>
	<20071127164101.GA14790@localhost.localdomain>
	<474C49D5.2000206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <474C49D5.2000206@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 07:46:13PM +0300, Sergei Shtylyov wrote:
[...]
> >>>+			ioport-shift = <1>;
> 
> >>  Bleh... that shift again. And this is surely not a good name for a 
> >>property (where's I/O ports in your case?) -- why not call it "reg-shift" 
> >>(well, I'd call it "reg-size" or "reg-stride" myself :-)?
> 
> >1. "shift" because pata_platform using that name. I don't see any
> >   reason to contrive indirections. ioport-shift is what the whole
> >   Linux kernel using nowadays, and ioport-shift dts property
> >   anyway Linux-specific.
> 
>    It's just a bad name. There's not even I/O ports in this case (and 
> moreover, the *real* I/O mapped device would always have a shift of 0, I 
> bet -- larger strides are for memory mapped devices).
> 
> >   I'm just following todays' conventions.
> 
> >   If you feel really bad about that, I think better to fix that in
> >   the source of the badness -- pata_platform. It's easy, I can do
> 
>    I only feel really bad about the "ioport" part, I can live with "shift" 
> part. :-)
> 
> >   that. Would you ack patch that converts whole pata_platform and
> >   users? Would Paul ack it?
> 
>    I don't understand -- why the property name should duplicate 
>    pata_platform field name? :-O

Because:

> >1.  [...] I don't see any reason to contrive indirections.

That is, different names for single thing is worse than single
bogus name.

>   Not really -- "size" just seems better, aesthetically. :-)

reg-size will look confusing. Is it ata registers' size? No,
can't be. So, what is it? It's stride/shift because of bus, on
which ata resides.

> >And btw, I can get rid of ioport-shift at all. And do fixups in
> >the pata_of_platform driver via .compatible matching. But I don't
> >want: it feels bad to list every needs-to-fixup board in the common
> >driver. It also feels not so great creating something like
> >pata-platform-stride-{1,2,4,...} compatible stuff. Heh.
> 
>    I didn't propose neither of that. :-)

Yup, that was "by the way"...

>    All I want is that "ioport-*" be renamed.

I give up.

The final name is..? I can think out wrong one, so you'd better
convoy me on that way. ;-) reg-shift sounds okay? Or reg-stride
better? No size, please.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
