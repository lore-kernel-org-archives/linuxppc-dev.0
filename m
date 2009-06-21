Return-Path: <barkalow@iabervon.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EB86AB7200
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 14:14:53 +1000 (EST)
Received: from iabervon.org (iabervon.org [66.92.72.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "iabervon.org", Issuer "iabervon.org" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 86EDDDDD1B
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 14:14:52 +1000 (EST)
Date: Sun, 21 Jun 2009 00:08:05 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Frans Pop <elendil@planet.nl>
Subject: Re: Badness on the Warp
In-Reply-To: <200906210126.09049.elendil@planet.nl>
Message-ID: <alpine.LNX.2.00.0906202323580.2147@iabervon.org>
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
	<20090620191034.48fa085a@lappy.seanm.ca>
	<200906210126.09049.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 21 Jun 2009, Frans Pop wrote:

> On Sunday 21 June 2009, Sean MacLennan wrote:
> > On Sat, 20 Jun 2009 22:56:45 +0200 Frans Pop <elendil@planet.nl> wrote:
> > > The fact that your bisect ended at a merge essentially means that it
> > > is invalid. As a merge does not introduce any actual change (unless
> > > it includes changes to resolve conflicts), it normally cannot be the
> > > cause of a regression.
> >
> > Makes sense I messed up somewhere. This is the commit that causes
> > problems:
> >
> > Merge branch 'topic/slab/earlyboot' of
> > git://git./linux/kernel/git/penberg/slab-2.6
> >
> > * 'topic/slab/earlyboot' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/penberg/slab-2.6:
> 
> Hmmm. That's b640f042faa2, which is another merge...
> So you're still not there.

It's not implausible that this is, in fact, the first bad commit. The 
early slab topic could easily have been correct for everything in the tree 
when it was written, but cause problems with some other patch developed 
simultaneously.

It's worth rechecking that both 871fa90 and b8ec757 are good and 
b640f042faa2 is bad, since it's also pretty likely that the test isn't 
reproducing perfectly.

	-Daniel
*This .sig left intentionally blank*
