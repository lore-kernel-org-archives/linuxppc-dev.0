Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7128E1A0EE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 01:43:27 +1100 (AEDT)
Message-ID: <1420641795.5830.31.camel@kernel.crashing.org>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Mohr <andi@lisas.de>
Date: Wed, 07 Jan 2015 15:43:15 +0100
In-Reply-To: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
References: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Purcareata Bogdan <b43198@freescale.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-05 at 18:46 +0100, Andreas Mohr wrote:
> Hi,
> 
> > I was curious why the mpic_cpu_read(MPIC_INFO(CPU_WHOAMI)) was there in
> > the first place and if it's still needed. If it's still required, I
> > guess a better approach is to eliminate the call only if the kernel is
> > running on the KVM guest side, where the MPIC is emulated and no longer
> > requires a readback.
> 
> "Why not?"
> 
> A mechanism being "emulated"/"virtual" or not
> may not necessarily be much of a distinction (if at all!).
> The readback might be required
> to properly fulfill all requirements
> of a full state change protocol specification,
> which might easily be the case for both RS(*) and virtual hardware.
> And especially for virtual hardware
> such a "readback" event
> might be an extremely important "end of transaction" marker
> which may often be needed for freeing of temporary resources etc.

In that case it was purely something we added after trial and error to
correct a problem, it's not specified as necessary. Basically it's about
making the store synchronous to the MPIC logic. It's definitely not
necessary on an emulated implementation.

> I'm talking out of my *ss without any MPIC specifics here
> (and especially not why the readback there actually is needed -
> if that doesn't happen to be the case for PCI Posting reasons or some such),
> but it's just intended as food for thought :)
> 
> *) Real Silicon (rather than RL - Real Life)
> 
> HTH,
> 
> Andreas Mohr
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
