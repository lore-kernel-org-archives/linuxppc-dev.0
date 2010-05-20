Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 9CA0EB7D2E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 10:03:48 +1000 (EST)
Received: by iwn10 with SMTP id 10so168611iwn.15
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 17:03:47 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1274309050.1931.21.camel@pasglop>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop> <4BF4593E.8030101@freescale.com>
	<1274309050.1931.21.camel@pasglop>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 19 May 2010 19:03:17 -0500
Message-ID: <AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 19, 2010 at 5:44 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> It's still not kernel business to have to deal with u-boot memory
> allocation constraints.

I agree, but it still makes sense to me to allow the padding to be configurable.

> The padding in the kernel built is intended to
> make space for DT changes done by the zImage wrapper.

Well, okay.  I think it would be nice if we expanded that to handle
general usage.

> Maybe we could add to libfdt a way to provide a realloc() callback to it
> when it hits the max size, and uboot can then move things around (or
> fail).

The problem is that the code which allocates a block for the fdt is
completely distinct from the code that manipulates the fdt.  We'd need
to put in either some kind of funky callback mechanism, or insist that
every fdt exist in a block of memory allocated by some specific method
(e.g. lmb).

I'm stuck between a rock and a hard place, it seems.  No one is
willing to compromise on any of my ideas.  It's hard to convince our
BSP developers that they should be pushing more code upstream when I
get so much resistance for a such a mundane change.

-- 
Timur Tabi
Linux kernel developer at Freescale
