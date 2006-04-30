Return-Path: <marcelo@kvack.org>
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by ozlabs.org (Postfix) with ESMTP id C241B67B31
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 May 2006 03:01:27 +1000 (EST)
Date: Sun, 30 Apr 2006 13:40:13 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Stephen Williams <steve@icarus.com>
Subject: Re: PPC 405GPr support in linux 2.4.32
Message-ID: <20060430164013.GA4631@dmt>
References: <e2ov5s$1hn$1@sea.gmane.org> <20060426163540.H16236@cox.net>
	<20060427180743.GB11206@gate.ebshome.net>
	<44510E4D.5040504@icarus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44510E4D.5040504@icarus.com>
Cc: Willy Tarreau <willy@w.ods.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 27, 2006 at 11:32:45AM -0700, Stephen Williams wrote:
> Eugene Surovegin wrote:
> > There are bigger problems with 4xx support in 2.4 mainline than just 
> > missing some chips support.
> > 
> > Some parts which are already in 2.4 (e.g. ethernet driver) are of 
> > non-production quality. 
> > 
> > I can imagine Marcelo agreeing to commit 405GPr/405EP support as this 
> > change shouldn't break anything, but this will not make 2.4 support 
> > really useful for real world deployments. I think we are stuck with 
> > maintaining our own 2.4 trees with backports from 2.6. This is what I 
> > do myself of all our products (and yeah, diff between stock 2.4.32 and 
> > my internal version has already grown quite big to be acceptable for 
> > 2.4 inclusion).
> > 
> 
> Of course we are going to have to keep our own per-board trees.
> but the blatantly common stuff, like the core 405gpr support and
> certain drivers, might as well go in if the gatekeeper can be
> convinced. You and I both probably have huge drivers for custom
> devices hanging off our PPCs, with various hacks to squeeze extra
> performance out. These make our transition to 2.6 difficult, and
> surely we are not alone.
> 
> So 2.4 is going to be around for a while longer for us, so we might
> as well make an effort to keep the house in some sort of order. It
> serves no one to keep these fixes a secret:-)
> 
> In any case, if the patches I sent are rejected, then that's that.
> We'll see.

Folks,

The v2.4 patch acceptance policy has been shifting gradually from
"accept new features" to "critical fixes only", and at this point in
time the goal is to have a minimal amount of modifications as possible.

There should be no need for major patch reworking with reference to new
v2.4 releases.

Willy Tarreau created a repository of useful v2.4 patches for this sort
of situations. Stephen, Eugene, I think the 405GPr patches are good candidates.

http://w.ods.org/linux/kernel/2.4/lkup/hardware.html

Of course that it would be incredibly better for everyone to be happy with
v2.6. I see a lot of embedded users complaining about v2.6.

Cyclades (my former employer) has been using v2.6 in production
environments with 48MHz MPC855T PPC's with no problems at all (actually,
it is faster in certain key situations). This boxes have 128MB, which is
can be considered large, but still, no major problems have been seen in
_several_ different v2.6 versions.
