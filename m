Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wjzg5ZvQzDr7s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 18:14:07 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id f1-v6so10173622plt.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:14:07 -0700 (PDT)
Date: Wed, 30 May 2018 16:14:02 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v6 2/4] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20180530081402.GB5951@simonLocalRHEL7.x64>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
 <1527221256-17029-3-git-send-email-wei.guo.simon@gmail.com>
 <20180528110558.GZ17342@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528110558.GZ17342@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,
On Mon, May 28, 2018 at 06:05:59AM -0500, Segher Boessenkool wrote:
> On Fri, May 25, 2018 at 12:07:34PM +0800, wei.guo.simon@gmail.com wrote:
> > +	/* save and restore cr0 */
> > +	mfocrf  r5,64
> > +	EXIT_VMX_OPS
> > +	mtocrf	64,r5
> > +	b	.LcmpAB_lightweight
> 
> That's cr1, not cr0.  You can use mcrf instead, it is cheaper (esp. if
> you have it in a non-volatile CR field before so you need only one, if any).
> 
You are right :) How about using mtcr/mfcr instead, I think they are
fast as well and more readable.

> > +	vcmpequb.  v7,v9,v10
> > +	bnl	cr6,.Ldiffoffset_vmx_diff_found
> 
> In other places you say  bf 24,...  Dunno which is more readable, but
> please pick one?
I will update to bnl for other cases.
> 
> 
> Segher

Thanks for your review.

BR,
- Simon
