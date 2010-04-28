Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7814CB7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Apr 2010 05:34:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3SJYQfj005854 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Apr 2010 12:34:26 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3SJiYlf016269
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Apr 2010 14:44:34 -0500 (CDT)
Date: Wed, 28 Apr 2010 14:46:51 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
Message-Id: <20100428144651.7f64b5c0.kim.phillips@freescale.com>
In-Reply-To: <y2te6bf505b1004281215n9dcc6190j9915aa27ae91f75d@mail.gmail.com>
References: <1272439375.24542.94.camel@pasglop>
	<y2te6bf505b1004281215n9dcc6190j9915aa27ae91f75d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Apr 2010 14:15:50 -0500
Xianghua Xiao <xiaoxianghua@gmail.com> wrote:

> On Wed, Apr 28, 2010 at 2:22 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > So we tried to speed things up a bit using flush_hash_pages() directly
> > but that falls over on 603 of course meaning we fail to flush the TLB
> > properly and we may even end up having it corrupt memory randomly by
> > accessing a hash table that doesn't exist.
> >
> > This removes the "optimization" by always going through flush_tlb_page()
> > for now at least.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > Somebody with a 603 or e300 core based FSL SoC to try this out for me ?
> >
> This change works me on a 834x(e300) platform, tested with lmbench and
> a production-ready application with 2.6.33.3.

moi aussi, Ben: booted this on an 8377 and started a kernel build.
It seems to be progressing normally, I'm just not going to wait for it
to complete before hitting send :).

Kim
