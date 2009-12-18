Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2853B6F14
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 02:02:43 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBIF2Q4B022349
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 08:02:36 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBIF6ql6005647
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 09:06:53 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
Date: Fri, 18 Dec 2009 23:02:22 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED01059526@zch01exm26.fsl.freescale.net>
In-Reply-To: <4B2A6DFA.6000504@intel.com>
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
	<20091216164144.daff5468.kim.phillips@freescale.com>
	<2868C8CF-584B-4FA7-9C3B-2FACEF77527E@kernel.crashing.org>
	<4B296394.9010709@intel.com>
	<20091217170958.GE18271@ovro.caltech.edu>
	<4B2A6DFA.6000504@intel.com>
From: "Li Yang-R58472" <r58472@freescale.com>
To: "Dan Williams" <dan.j.williams@intel.com>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: herbert@gondor.apana.org.au, Suresh Vishnu-B05022 <B05022@freescale.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Dudhat Dipen-B09055 <B09055@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>Subject: Re: [PATCH v2 2/2] Crypto: Talitos: Support for=20
>Async_tx XOR offload
>
>Ira W. Snyder wrote:
>> Yes, I have used the device_prep_dma_interrupt()=20
>functionality quite a=20
>> while back. However, I found it to be pretty much useless.
>
>The specific case it is needed for Talitos/raid is a channel=20
>switch interrupt.  The interrupt causes the cleanup operation=20
>to be run which will kick off any pending dependent operations=20
>on the xor channel.  In the raid case we only have callbacks=20
>at the end of a chain, so we need the interrupt to kick the=20
>engine in an operation chain like=20
>xor->copy->xor->callback.

I am wondering if can use more callbacks to kick off pending dependent =
operations?
Like xor->callback->copy->callback->xor->callback?

- Leo
