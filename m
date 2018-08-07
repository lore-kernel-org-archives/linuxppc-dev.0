Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lRxR0tfZzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 07:10:18 +1000 (AEST)
Message-ID: <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Rob Herring <robh@kernel.org>, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 galak@kernel.crashing.org, mark.rutland@arm.com,
 kstewart@linuxfoundation.org,  gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  keescook@chromium.org,
 tyreld@linux.vnet.ibm.com, joe@perches.com
Date: Tue, 07 Aug 2018 16:03:36 -0500
In-Reply-To: <20180807180938.GA13623@rob-hp-laptop>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
 <20180807180938.GA13623@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-07 at 12:09 -0600, Rob Herring wrote:
> On Fri, Jul 27, 2018 at 03:17:59PM +0530, Bharat Bhushan wrote:
> > Freescale MPIC h/w may not support all interrupt sources reported
> > by hardware, "last-interrupt-source" or platform. On these platforms
> > a misconfigured device tree that assigns one of the reserved
> > interrupts leaves a non-functioning system without warning.
> 
> There are lots of ways to misconfigure DTs. I don't think this is 
> special and needs a property.

Yeah, the system will be just as non-functioning if you specify a valid-but-
wrong-for-the-device interrupt number.

>  We've had some interrupt mask or valid 
> properties in the past, but generally don't accept those.

FWIW, some of them like protected-sources and mpic-msgr-receive-mask aren't
for detecting errors, but are for partitioning (though the former is obsolete
with pic-no-reset).

-Scott
