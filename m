Return-Path: <jfannin@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 52369DDEEC
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 17:31:03 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so3028932ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 00:30:49 -0700 (PDT)
Date: Mon, 16 Jun 2008 03:30:41 -0400
From: Joseph Fannin <jfannin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG() in current git, __dma_alloc_coherent, Beige G3
Message-ID: <20080616073041.GA26917@nineveh.local>
References: <20080616014615.GA8960@nineveh.local>
	<1213591838.8129.123.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1213591838.8129.123.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2008 at 02:50:38PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2008-06-15 at 21:46 -0400, Joseph Fannin wrote:
> > Hello!
> >
> > I'm reproducably hitting a BUG() in Linus' git (current as of about
> > noon, Sunday 15, GMT -0500) on my Beige PowerMac G3 (32bit, natch).
> > The line indicted in the (hand-copied) traceback that follows is:
> >
> >     BUG_ON(!pte_none(*pte));
> >
> > ...in __dma_alloc_coherent().
>
>  .../...
>
> > [   261.043131] ------------[ cut here ]------------
> > [   261.044194] kernel BUG at arch/powerpc/lib/dma-noncoherent.c:209!
>
> I wonder how you end up hitting code in dma-noncoherent.c in the first
> place ! PowerMac kernels should not have that code compiled in at all...

I think it's because PPC_PRPMC2800 and MPC5121_ADS both live under
PPC_MULTIPLATFORM, and end up selecting NOT_COHERENT_CACHE.

If the button in Kconfig isn't labeled "Do Not Push", heck, I'll build
it.

--
Joseph Fannin
jfannin@gmail.com
