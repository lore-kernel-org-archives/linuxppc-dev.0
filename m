Return-Path: <dan.j.williams@gmail.com>
Received: from mail-vw0-f172.google.com (mail-vw0-f172.google.com
	[209.85.212.172]) by ozlabs.org (Postfix) with ESMTP id A533BB6F17
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 11:58:25 +1100 (EST)
Received: by vws2 with SMTP id 2so839874vws.17
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 16:58:23 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <AFE3AE33-41FB-42EE-A861-9C6CC1D1F435@kernel.crashing.org>
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
	<20091216164144.daff5468.kim.phillips@freescale.com>
	<2868C8CF-584B-4FA7-9C3B-2FACEF77527E@kernel.crashing.org>
	<4B296394.9010709@intel.com> <20091217170958.GE18271@ovro.caltech.edu>
	<4B2A6DFA.6000504@intel.com>
	<AFE3AE33-41FB-42EE-A861-9C6CC1D1F435@kernel.crashing.org>
Date: Thu, 17 Dec 2009 17:58:23 -0700
Message-ID: <e9c3a7c20912171658r48f13600kfdfb41a75efa9838@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
From: Dan Williams <dan.j.williams@intel.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Dec 17, 2009 at 11:45 AM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>> The specific case it is needed for Talitos/raid is a channel switch inte=
rrupt. =A0The interrupt causes the cleanup operation to be run which will k=
ick off any pending dependent operations on the xor channel. =A0In the raid=
 case we only have callbacks at the end of a chain, so we need the interrup=
t to kick the engine in an operation chain like xor->copy->xor->callback.
>
> Ok, I'm still confused as to how the DMA interrupt interacts with the Tal=
itos/raid side of things. =A0The should be completely independent (separate=
 interrupts, separate IP blocks).
>

To keep hardware implementation details out of md/raid the async_tx
api provides support for managing cross-channel dependency chains.
When the raid5 code submits a xor->copy->xor chain the api prepares
all the descriptors across all the involved channels but then delays
submission as needed to maintain ordering.  So at a minimum we need
two interrupts in this scenario one from Talitos to kick the
submission of the copy-descriptor to fsldma when the first xor
completes, and another one to kick the submission of the second
xor-descriptor on Talitos when fsldma completes the copy.  Needless to
say it is more efficient when a channel has all the capabilities, but
this channel switch mechanism has proven effective on iop3xx and
ppc4xx.

--
Dan
