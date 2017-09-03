Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel2.indieserve.net (cpanel2.indieserve.net [199.212.143.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlV2P150gzDqj2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 20:43:40 +1000 (AEST)
Date: Sun, 3 Sep 2017 06:43:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org, monstr@monstr.eu,
 Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
In-Reply-To: <1504390854.4974.108.camel@kernel.crashing.org>
Message-ID: <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
 <1504390854.4974.108.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 3 Sep 2017, Benjamin Herrenschmidt wrote:

> On Sat, 2017-09-02 at 04:43 -0400, Robert P. J. Day wrote:
> > Since, according to a recent devicetree ML posting by Rob Herring,
> > the node "/chosen@0" is most likely for real Open Firmware and
> > does not apply to DTSpec, remove all remaining tests and
> > references for that node, of which there are very few left:
>
> Technically that would break Open Firmware systems where the node is
> really called chosen@0
>
> Now I'm not sure such a thing actually exist however.
>
> My collection of DTs don't seem to have one, except in the ancient
> html variants that were extracted by the pengionppc folks for the
> original PowerMac 8600 but I wonder if that's a bug in the
> extraction script since they also have @0 on /packages etc...

  obviously, this isn't a priority issue, i was just working off a
comment by rob herring that "chosen@0" is not defined by the current
DTSpec 0.1, so it seemed appropriate to toss it. if there's a reason
to hang onto it, that's fine with me.

  however, given the diff stat of the change to remove every single
reference to that node name in the current kernel source:

 arch/microblaze/kernel/prom.c | 3 +--
 arch/mips/generic/yamon-dt.c  | 4 ----
 arch/powerpc/boot/oflib.c     | 7 ++-----
 drivers/of/base.c             | 2 --
 drivers/of/fdt.c              | 5 +----
 5 files changed, 4 insertions(+), 17 deletions(-)

it seems inconsistent that three architectures would be testing for
that node, but none of the rest. consistency suggests that every
architecture should take it into account, or none should.

  anyway, not a big deal, i'm fine with any decision.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
