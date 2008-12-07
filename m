Return-Path: <npalix@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6F475DDDED
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2008 01:09:12 +1100 (EST)
From: Nicolas Palix <npalix@diku.dk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH linux-next] powerpc/powermac: Add missing of_node_put
Date: Sun, 7 Dec 2008 15:09:08 +0100
References: <200812021445.18670.npalix@diku.dk>
	<18747.13668.304923.709761@cargo.ozlabs.ibm.com>
	<20081207164333.78b69d16.sfr@canb.auug.org.au>
In-Reply-To: <20081207164333.78b69d16.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812071509.09091.npalix@diku.dk>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Julia Lawall <julia@diku.dk>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 07 December 2008 06:43:33 Stephen Rothwell wrote:
> Hi Paul,
> 
> On Sun, 7 Dec 2008 13:31:00 +1100 Paul Mackerras <paulus@samba.org> wrote:
> >
> > I'm really in two minds about applying any of the of_node_put patches
> > that only affect powermacs.  The reference counts only matter on
> > platforms where we update the OF device tree at runtime, which is
> > currently only IBM pSeries machines.  Since we don't have any hotplug
> > on powermacs, and never will have, the OF device tree is completely
> > static and we don't actually need refcounts on the nodes at all, so
> > who cares if they're a bit higher than they might be?
> > 
> > In particular, the VIA whose node we're looking for here is built-in
> > on the motherboard, and there can never be more than one, and it can
> > never be removed.
> 
> I my mind it is about consistent use of the API and good examples for
> people to copy.  Also, in about a year you will be presented with the
> same set of patches when a new pair of eyes looks at the same code and
> notices the discrepancy ...
> 
Hi Andrew,

Indeed, there is an updated version of this patch in my second mail
which fixes this issue.
 
http://lkml.org/lkml/2008/12/3/88
 
Moreover, there is still a reference count unbalanced with your patch in the
case where the function returns 1.

Regards,
-- 
Nicolas Palix
