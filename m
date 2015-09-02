Return-Path: <ananth@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 751C31A1E05
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 15:10:15 +1000 (AEST)
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F2CB51401F0
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2015 15:10:13 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 2 Sep 2015 01:10:11 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9962B6E804F
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2015 01:01:53 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t825A9vp61472994
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2015 05:10:09 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t825A6uf006374
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2015 01:10:08 -0400
Date: Wed, 2 Sep 2015 10:39:58 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>,
 "Paul Mackerras" <paulus@samba.org>, <ego@linux.vnet.ibm.com>
Subject: Re: powerpc: Add user-return-notifier support
Message-ID: <20150902050958.GC1196@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <20150825054110.GD3815@in.ibm.com>
 <20150831103517.96D1A1401E7@ozlabs.org>
 <20150901064113.GA1196@in.ibm.com>
 <1441152192.4966.103.camel@freescale.com>
 <20150902023713.GB1196@in.ibm.com>
 <1441164552.4966.153.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441164552.4966.153.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 01, 2015 at 10:29:12PM -0500, Scott Wood wrote:
> On Wed, 2015-09-02 at 08:07 +0530, Ananth N Mavinakayanahalli wrote:
> > On Tue, Sep 01, 2015 at 07:03:12PM -0500, Scott Wood wrote:
> > > On Tue, 2015-09-01 at 12:11 +0530, Ananth N Mavinakayanahalli wrote:
> > > > On Mon, Aug 31, 2015 at 08:35:17PM +1000, Michael Ellerman wrote:
> > > > > On Tue, 2015-25-08 at 05:41:10 UTC, Ananth N Mavinakayanahalli wrote:

...

> > > > We could certainly make this a generic config option.. but I am yet to
> > > > see a real usecase outside of the KVM thingy. We do use TIF_UPROBE for
> > > > something very similar, though that needs to fire much before the
> > > > outstanding signals get handled. The user-return notifier is the last
> > > > thing executed before return to userspace -- the two cannot be merged.
> > > > 
> > > > Ananth
> > > > 
> > > > PS: I am not sure having an 'ok' against the Documentation/features/ for
> > > > powerpc is a valid enough argument for this :-)
> > > 
> > > So how did you test this?  What platforms did you test it on?  What 
> > > hardware 
> > > support does it need?
> > 
> > Simple kernel module below... Its fairly evident from the patch that the
> > feature is a software only construct and no specific hardware support is
> > needed.
> 
> It's evident now that I'm aware of what the purpose is... It wasn't 100% 
> 
> clear before, at least from a quick glance, given that the explanation was 
> 
> "look at this hardware-specific KVM patch", whether there was an assumption 
> of something else going on -- and even things that are implemented in 
> software often work differently on book3s versus book3e, ppc32 versus ppc64, 
> etc.

I meant the infrastructure is agnostic of the underlying Power platform.
Sorry if I wasn't clear.

> Why is this selected by KVM on PPC if KVM on PPC doesn't use it?  What is the 
> user you're trying to enable?

I copied Paul and Gautham to get their thoughts on whether it is
something they could use on Power. At this time, apart from enabling the
feature, I do not have a specific usecase for it. We can park this patch
pending a real user on powerpc.

> Where is the "profiler" that Documentation/features/debug/user-ret-
> profiler/arch-support.txt hints at?

I guess profiler is a misnomer. Not sure why it was named that and not a
notifier.

Ananth
