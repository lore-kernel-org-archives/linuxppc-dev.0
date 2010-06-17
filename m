Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2486B7D8A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jun 2010 09:57:48 +1000 (EST)
Subject: Re: [PATCH 5/5] of/irq: merge of_irq_map_one()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTin5K0IL5iKj9i9qBucSpQz2-p5wIvUtC4iU0jUP@mail.gmail.com>
References: <20100604212134.10552.70717.stgit@angua>
	<20100604212155.10552.19260.stgit@angua>
	<1276152002.1962.55.camel@pasglop>
	<AANLkTinmDFBvAjcjrgf3RHuiXgNxVV20yLzBaqhE5lrk@mail.gmail.com>
	<1276219072.1962.82.camel@pasglop>
	<AANLkTin5K0IL5iKj9i9qBucSpQz2-p5wIvUtC4iU0jUP@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Jun 2010 09:57:25 +1000
Message-ID: <1276819045.8826.45.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-06-17 at 17:11 -0600, Grant Likely wrote:
> On Thu, Jun 10, 2010 at 7:17 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Thu, 2010-06-10 at 17:36 -0600, Grant Likely wrote:
> >>
> >> Okay.  I had been trying to avoid #ifdefs in the common code, but
> >> you're probably right.  I'll rework.
> >
> > Not even ifdef's ... just move the quirk map there. You can always
> > #define the quirk variable to 0 on archs that have no quirks, to
> > make it compile away if you believe it represents bloat, but they
> > are simple well localized things so I doubt it matters.
> 
> They're pretty small, but powermac32 is the only code that actually
> uses the quirk facility.  Everything else parses sanely it would
> appear.  I'd rather have them localized to the powermac code and
> eliminate the quirks from the common code.

Maybe, but the way you end up gutting out some internal functions of the
parser so they can be overriden by the arch is just plain gross :-) And
more bloat than just having a localized quirk test which can easily
compile to nothing when powermac isn't built.

IE. I'd rather you then add some kind of of_irq_map_fixup() or something
like that in the generic code that can be an empty inline when powermac
isn't there, and be defined by powerpc to do the right thing then,
rather than move the core of the function to a separate weak version.

Because the day you fix a bug in the weak variant, or change a calling
convention, you'll forget to also update the "overrides" in the arch.

> If other platforms show up with bad irq mappings, then I want to take
> the approach of fixing the data rather than adding more quirks cases.
> 
> Anyway, let me try my hand at reworking to be a lot clearer and see
> what it looks like.

Ben.
