Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0114.outbound.protection.outlook.com [157.56.110.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F13D51A0AD3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 05:11:12 +1100 (AEDT)
Message-ID: <1420481454.4961.16.camel@freescale.com>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
From: Scott Wood <scottwood@freescale.com>
To: Andreas Mohr <andi@lisas.de>
Date: Mon, 5 Jan 2015 12:10:54 -0600
In-Reply-To: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
References: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
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

I'm not convinced that it's required in real silicon (though there are
many MPIC implementations which have their own quirks...), and I'm 100%
sure that it's not required in the QEMU/KVM implementation of MPIC.

It would have been nice if a code comment explained why it was doing the
readback...  I don't see any particular need to wait for EOI completion
here (unlike when masking).

-Scott
