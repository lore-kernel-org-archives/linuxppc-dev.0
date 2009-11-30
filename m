Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4CEB1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Nov 2009 17:43:03 +1100 (EST)
Subject: Re: [RFC PATCH v2 08/11] powerpc: gamecube/wii: early debugging
	using usbgecko
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B136624.4030505@yahoo.es>
References: <1259441037-15725-1-git-send-email-albert_herranz@yahoo.es>
	<1259441037-15725-9-git-send-email-albert_herranz@yahoo.es>
	<1259536695.2076.40.camel@pasglop>  <4B135D3D.9030006@yahoo.es>
	<1259561692.2076.78.camel@pasglop>  <4B136624.4030505@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Nov 2009 17:42:57 +1100
Message-ID: <1259563377.2076.84.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-11-30 at 07:28 +0100, Albert Herranz wrote:
> 
> 
> Heh, I was told to identity map it :)

Hah ? By whome ? :-)

> Originally it used kernel address space (
> 0xc{c,d}006800).

In any case, kernel space also needs to be reserved. There is no magic
free spot in the kernel virtual space unless you reserve some either by
lowering ioremap_bot early at boot or by using the fixmap (well, there
is if you don't enable HIGHMEM but that's going away soon :-)

> I've never worked with fixmap entries. I'll look into it. Thanks.

Look at fixmap.h, basically it's an emum of reserved pages starting near
the top of the address space and walking down from there. The kernel
ensure that space stays reserved and it gives you things calculated at
compile time (so via asm-offsets.h you can feed them into your asm).

I'm half tempted to say we should just bluntly reserve the top 128K (or
whatever is the min size of a BAT) for that sort of debug crap though
and be done with it :-) Always handy to have some space we know we can
mess around with.

> But we can use then a known mapping scheme, and have all the i/o
> region covered by bats there.

We could yes. I was hoping Grant would produce something there but he
hadn't had time yet.,

> We can do that already, yes, but setup_io_mappings purpose was
> originally that, no?

Sort-of. I don't like hard coding virtual addresses, it causes all sort
of problems (other than in the fixmap). It wouldn't be very hard to
bring back some variant of io_block_mapping() though that works by
moving ioremap_bot down early during boot, and allows you to setup some
IO BATs for perfs reasons. Subsequent ioremaps would automatically pick
up that space and benefit from it.

Cheers,
Ben.
