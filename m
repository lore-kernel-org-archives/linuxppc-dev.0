Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410zcp5jtszF12M
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 16:42:34 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id 31-v6so3171959plc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 23:42:34 -0700 (PDT)
Date: Wed, 6 Jun 2018 14:42:27 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v6 2/4] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20180606064227.GB7342@simonLocalRHEL7.x64>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
 <1527221256-17029-3-git-send-email-wei.guo.simon@gmail.com>
 <20180528110558.GZ17342@gate.crashing.org>
 <20180530081402.GB5951@simonLocalRHEL7.x64>
 <20180530083540.GG17342@gate.crashing.org>
 <20180530090321.GE5951@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530090321.GE5951@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi segher,
On Wed, May 30, 2018 at 05:03:21PM +0800, Simon Guo wrote:
> On Wed, May 30, 2018 at 03:35:40AM -0500, Segher Boessenkool wrote:
> > On Wed, May 30, 2018 at 04:14:02PM +0800, Simon Guo wrote:
> > > Hi Segher,
> > > On Mon, May 28, 2018 at 06:05:59AM -0500, Segher Boessenkool wrote:
> > > > On Fri, May 25, 2018 at 12:07:34PM +0800, wei.guo.simon@gmail.com wrote:
> > > > > +	/* save and restore cr0 */
> > > > > +	mfocrf  r5,64
> > > > > +	EXIT_VMX_OPS
> > > > > +	mtocrf	64,r5
> > > > > +	b	.LcmpAB_lightweight
> > > > 
> > > > That's cr1, not cr0.  You can use mcrf instead, it is cheaper (esp. if
> > > > you have it in a non-volatile CR field before so you need only one, if any).
> > > > 
> > > You are right :) How about using mtcr/mfcr instead, I think they are
> > > fast as well and more readable.
> > 
> > Those are much worse than m[ft]ocrf.
> > 
> > You probably should just shuffle things around so that EXIT_VMX_OPS
> > does not clobber the CR field you need to keep.
> Let me use mcrf then :)

I now felt unformatable to use mcrf like:
mcrf    7,0

since I cannot 100% confident that compiler will not use CR7 or other
CR# in exit_vmx_ops().

Can we switch back to mfocrf/mtocrf with correct CR0 value?
       mfocrf  r5,128
        ...
       mtocrf  128,r5

Thanks,
- Simon
