Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 135B1B6F04
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 05:45:18 +1100 (EST)
Subject: Re: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B2A6DFA.6000504@intel.com>
Date: Thu, 17 Dec 2009 12:45:01 -0600
Message-Id: <AFE3AE33-41FB-42EE-A861-9C6CC1D1F435@kernel.crashing.org>
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
	<20091216164144.daff5468.kim.phillips@freescale.com>
	<2868C8CF-584B-4FA7-9C3B-2FACEF77527E@kernel.crashing.org>
	<4B296394.9010709@intel.com>
	<20091217170958.GE18271@ovro.caltech.edu>
	<4B2A6DFA.6000504@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>,
	"B04825@freescale.com" <B04825@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Vishnu Suresh <Vishnu@freescale.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	Dipen Dudhat <Dipen.Dudhat@freescale.com>,
	Maneesh Gupta <Maneesh.Gupta@freescale.com>,
	"R58472@freescale.com" <R58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 17, 2009, at 11:44 AM, Dan Williams wrote:

> Ira W. Snyder wrote:
>> Yes, I have used the device_prep_dma_interrupt() functionality quite =
a
>> while back. However, I found it to be pretty much useless.
>=20
> The specific case it is needed for Talitos/raid is a channel switch =
interrupt.  The interrupt causes the cleanup operation to be run which =
will kick off any pending dependent operations on the xor channel.  In =
the raid case we only have callbacks at the end of a chain, so we need =
the interrupt to kick the engine in an operation chain like =
xor->copy->xor->callback.

Ok, I'm still confused as to how the DMA interrupt interacts with the =
Talitos/raid side of things.  The should be completely independent =
(separate interrupts, separate IP blocks).

- k=
