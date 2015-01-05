Return-Path: <andi@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32C3B1A0A50
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 04:52:44 +1100 (AEDT)
Date: Mon, 5 Jan 2015 18:46:16 +0100
From: Andreas Mohr <andi@lisas.de>
To: Purcareata Bogdan <b43198@freescale.com>
Subject: Re: [RFC] PPC: MPIC: necessary readback after EOI?
Message-ID: <20150105174616.GA3159@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54AA9C4D.3000001@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> I was curious why the mpic_cpu_read(MPIC_INFO(CPU_WHOAMI)) was there in
> the first place and if it's still needed. If it's still required, I
> guess a better approach is to eliminate the call only if the kernel is
> running on the KVM guest side, where the MPIC is emulated and no longer
> requires a readback.

"Why not?"

A mechanism being "emulated"/"virtual" or not
may not necessarily be much of a distinction (if at all!).
The readback might be required
to properly fulfill all requirements
of a full state change protocol specification,
which might easily be the case for both RS(*) and virtual hardware.
And especially for virtual hardware
such a "readback" event
might be an extremely important "end of transaction" marker
which may often be needed for freeing of temporary resources etc.

I'm talking out of my *ss without any MPIC specifics here
(and especially not why the readback there actually is needed -
if that doesn't happen to be the case for PCI Posting reasons or some such),
but it's just intended as food for thought :)

*) Real Silicon (rather than RL - Real Life)

HTH,

Andreas Mohr
