Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 09BC3679F1
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 15:51:12 +1000 (EST)
In-Reply-To: <1116200069.5095.51.camel@gaston>
References: <1116200069.5095.51.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <5833cd030098e5fc4600f691cab4f36c@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 16 May 2005 00:51:03 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 15, 2005, at 6:34 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2005-05-16 at 09:29 +1000, Paul Mackerras wrote:
>  > Benjamin Herrenschmidt writes:
>  >
> > > We "inherited" from some historic junk in the prep and chrp=20
> support,
>  > > that a lot of embedded platforms blindly copied, where archs use
>  > > io_block_mapping() early during boot to hard-wire various IO=20
> stuffs in
>  > > various places in the address space, including just after 2Gb.=20
> It's
>  > > totally bogus, but nobody really cared to fix it so far. The 2Gb
>  > > TASK_SIZE limit doesn't seem to have ever been an issue for ppc32=20=

> users
>  > > so far I must say, at least you are the first one to complain ;)
>  >
> > I believe that prep and chrp are also now OK with a 3GB TASK_SIZE
>  > limit, it's just various embedded board ports that will blow up =
with
>  > 3GB.=A0 We should change the default to 3GB to encourage the =
embedded
>  > guys to fix their ports properly (or else to put in the appropriate
>  > Kconfig stuff to force it back to 2GB for their port).
>  >
>
>  static void __init
>  prep_map_io(void)
> {
>  =A0=A0=A0=A0=A0=A0=A0 io_block_mapping(0x80000000, PREP_ISA_IO_BASE, =
0x10000000,=20
> _PAGE_IO);
>  =A0=A0=A0=A0=A0=A0=A0 io_block_mapping(0xf0000000, PREP_ISA_MEM_BASE, =
0x08000000,=20
> _PAGE_IO);
>  }
>
> We need to fix that too :) Though I suppose we can just switch that to
>  page tables, I don't really see the point of using a BAT here...

Are the embedded board ports broken because of similar=20
io_block_mapping() calls or for some other reason?

I'm in agreement that we should bump TASK_SIZE to 3GB and fix things,=20
how about after 2.6.12 is out?

- kumar=
