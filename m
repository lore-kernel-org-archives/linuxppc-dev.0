Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6661E1A06F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2015 19:16:51 +1100 (AEDT)
Message-ID: <1426493810.4716.0.camel@ellerman.id.au>
Subject: Re: linux panic on 4.0.0-rc4
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 16 Mar 2015 19:16:50 +1100
In-Reply-To: <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
References: <CAJhHMCC+BJWBo3=XbLf2L_kpOTqR==ee667+TpnFdk3DRT3o+Q@mail.gmail.com>
 <CAJhHMCBcyVbNRQSpsyVfk8HMzZ=NXKkknjDRuch+e+yJGB3T5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-16 at 01:34 -0400, Pranith Kumar wrote:
> On Mon, Mar 16, 2015 at 1:11 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> > Hello,
> >
> > I have a power mac mini 32-bit system.
> >
> ...
> > You can see the panic message here: http://imgur.com/s1lH15g. (there
> > is no log and I have no serial console).
> 
> There was some debug code in there when it hit. The actual hang seems
> to be in printk_late_init(). It does not return from this. May be this
> is a hint?

That is where the boot consoles get disabled and it switches to the "real"
console. It suggests that the system is not "hung" there but you just lost
output.

Try booting with "keep_bootcon" ?

If that doesn't help try booting with "udbg-immortal".

cheers
