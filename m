Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id 91D6FDDF7C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:28:46 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1653312nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 13:28:42 -0700 (PDT)
Message-ID: <fa686aa40710171328y195aca9k6ee8a1a5502fcf57@mail.gmail.com>
Date: Wed, 17 Oct 2007 14:28:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	"Rob Landley" <rob@landley.net>, "Milton Miller" <miltonm@bga.com>,
	"Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH 1/2] qemu platform, v2
In-Reply-To: <20071001053326.GA15132@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de> <200709221416.21580.rob@landley.net>
	<18165.60185.316393.213864@cargo.ozlabs.ibm.com>
	<4d27912d86d1373ca01d43bd296e237b@kernel.crashing.org>
	<20071001053326.GA15132@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/30/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Sep 28, 2007 at 06:53:28PM +0200, Segher Boessenkool wrote:
> > >> I'd be following this more closely if compiling a device tree didn't
> > >> currently
> > >> require an external utility (dtc or some such) that doesn't come with
> > >> the
> > >> Linux kernel.  No other target platform I've built kernels for
> > >> requires such
> > >> an environmental dependency.
> > >
> > > No?  You haven't built kernels for other platforms that have external
> > > dependencies such as perl, gcc, make, binutils, etc.? :)
> >
> > Two of the supported Linux archs cannot be built with a mainline
> > compiler, even!
> >
> > And I have to install GNU sed/awk to get builds to work, too.
> >
> > OTOH, it would be nice if we didn't need DTC -- it itself doesn't
> > build out-of-the-box on all systems, either ;-)
> >
> > >>  (This is a problem both for hardwiring the
> > >> device tree into the kernel and for building a new boot rom from the
> > >> linux
> > >> kernel's ppc boot wrapper that would contain such a device tree to
> > >> feed to
> > >> the kernel.)
> > >
> > > It's only really been a problem for ps3 so far, since the embedded
> > > guys don't seem to have any difficulty with installing dtc.  We are
> > > looking at what to do for ps3 and prep, and the answer may well
> > > involve bundling dtc in the kernel source (it's not too big, around
> > > 3400 lines).
> >
> > If only a few platforms have this problem, we could instead include
> > their .dtb files in the kernel source tree.
>
> Including .dtbs in the kernel tree has a big practical problem:
> they're binary, so can't be patch(1)ed, which makes updating them a
> complete PITA.
>
> I'm working on merging dtc into the kernel tree instead.

I'm kind of late to this party; but I have to say I disagree.  Most of
us are doing just fine installing the dtc tool (and mkimage tool for
that matter).  Cloning it in the kernel tree is just asking for
divergence.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
