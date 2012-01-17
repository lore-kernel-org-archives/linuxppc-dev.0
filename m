Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AC4A21007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 14:42:55 +1100 (EST)
Message-ID: <1326771731.26116.29.camel@pasglop>
Subject: Re: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of
 the ppc one
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Bohan <mbohan@codeaurora.org>
Date: Tue, 17 Jan 2012 14:42:11 +1100
In-Reply-To: <4F14E05C.30207@codeaurora.org>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
 <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
 <4F0F7B60.5040701@gmail.com> <4F14E05C.30207@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robherring2@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-01-16 at 18:43 -0800, Michael Bohan wrote:
> 
> I was planning on sending these patches out, but it seems like with 
> Grant's patches, they may no longer be up to date. I was curious if any 
> thought was given to supporting configurations like this the one I 
> mentioned with the advent of these patches. I am happy to help test if 
> you can steer me in the right direction.

I haven't had a chance to look in detail at what Grant is doing in his
latest series, but the ppc domain scheme that he's basing it on has the
concept of sparse interrupt domains.

For these, we use a radix tree for the reverse map (we do not rely on a
linear range) and we "allocate" linux IRQ numbers on-demand as we create
mapping for individual HW interrupts.

Cheers,
Ben.
