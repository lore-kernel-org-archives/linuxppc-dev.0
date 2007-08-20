Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC397DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 11:29:29 +1000 (EST)
Date: Sun, 19 Aug 2007 20:29:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/7 v2] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Message-ID: <20070820012913.GA25222@ld0162-tx32.am.freescale.net>
References: <20070817181718.GA15792@ld0162-tx32.am.freescale.net>
	<55FCD650-548C-40C9-8B1E-16259EF93F1D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55FCD650-548C-40C9-8B1E-16259EF93F1D@kernel.crashing.org>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 18, 2007 at 11:36:24AM -0500, Kumar Gala wrote:
> This patch seems to mix moving to using the device tree directly w/o  
> some other modifications.  Can it be broken into those two changes as  
> they'd be easier to review.

The last iteration of these patches, I got complaints that I was
splitting them up too fine-grained.  I don't think it's productive to
keep iterating on exactly how much is in any given patch until I hit the
right combination of granularity and whoever happens to be reading e-mail
when I submit.

In the case of this particular patch, most of what isn't directly related
to converting to using the device tree directly is fixing problems that I
encountered in doing so -- what value is there in coming up with
intermediary versions that kind-of-sort-of make sense, on a good day, if
you don't look to closely?  The existing codebase is crap, and if every
logical change were its own patch, the patchset would be ten times as
long, and take ten times as long to produce.  Note that I did separate
what I thought were the more relevant-to-review and/or highly indpendent
changes.

The major thing I see in this patch that could have been usefully
separated out was the conversion of mii_bitbang.c to use the generic code
introduced by patch 1.  However, that would require retrieving and
retesting the intermediate version, and I don't think there's sufficient
damage to reviewability (apart perhaps from diff's stupidity in thinking
that a single "{" is relevant common ground between completely unrelated
chunks of code) relative to the cost in preparing such a split.

Is there anything of the actual content of the patch that you object to,
or have a question about?

-Scott
