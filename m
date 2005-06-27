Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF44D679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 06:18:24 +1000 (EST)
Date: Mon, 27 Jun 2005 10:39:30 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050627133930.GA9109@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050626143004.GA5198@logos.cnet>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: map_page() skip pinned region and tlbie debugging
	aid
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Jun 26, 2005 at 11:30:04AM -0300, Marcelo Tosatti wrote:
> 
> Hi Dan,
> 
> On Sat, Jun 25, 2005 at 06:24:47PM -0400, Dan Malek wrote:
> > 
> > On Jun 25, 2005, at 10:53 AM, Marcelo Tosatti wrote:
> > 
> > >Dan: I dont think ioremap() is an issue because it never works inside 
> > >the
> > >kernel's static virtual address space (which is the only one we're 
> > >interested
> > >in having pinned at the moment).
> > 
> > Take a close look at the initialization code.  I believe it also
> > pins the IMMR space, which is subject to ioremap().
> 
> OK. Now that makes me think that the IMMR pinned entry is also always
> thrashed by the tlbie at map_page() :(

Bullshit, map_page()'s call for flush_HPTE() is conditioned by "mem_init_done", 
and mapin_ram() is called before mem_init_done is set.

> The IMMR space is a 16kB window (correct?), so I wonder if it might
> be better to the use occupied pinned slot for another more accessed
> region (an 8MB one preferably!).

Thats still some food for thought...
