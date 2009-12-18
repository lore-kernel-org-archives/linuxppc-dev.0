Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37D3FB6F10
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 01:46:37 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBIEkXtT017232
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 07:46:33 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nBIEpr2p017561
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 08:51:54 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
Date: Fri, 18 Dec 2009 22:46:27 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED01059523@zch01exm26.fsl.freescale.net>
In-Reply-To: <20091217170958.GE18271@ovro.caltech.edu>
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
	<20091216164144.daff5468.kim.phillips@freescale.com>
	<2868C8CF-584B-4FA7-9C3B-2FACEF77527E@kernel.crashing.org>
	<4B296394.9010709@intel.com>
	<20091217170958.GE18271@ovro.caltech.edu>
From: "Li Yang-R58472" <r58472@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>,
	"Dan Williams" <dan.j.williams@intel.com>
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
>On Wed, Dec 16, 2009 at 03:47:48PM -0700, Dan Williams wrote:
>> Kumar Gala wrote:
>> >>> Changes with respect to v1 as per comments received o.=20
>Rebased to=20
>> >>> linux-next as of 20091216 o. The selection is based exclusive of=20
>> >>> fsldma o. Intoduced a new Kernel Configuration variable
>> >>>   *. This enables selecting the Cryptographic functionality
>> >>>      of Talitos along with fsldma.
>> >>>   *. Disables the XOR parity calculation offload, if=20
>fsldma enabled
>> >>>      either as kernel in-built or as a module
>> >>>   *. Once the inter-operability with fsldma is resolved,=20
>this option
>> >>>      can be removed
>> >> wait, why can't the interoperability bug be fixed in the=20
>first place?
>> >=20
>> > I agree w/Kim.  We need to better understand what the bug=20
>is and how to reproduce it so we can get to the root cause.
>> >=20
>> > Paper taping over it by disabling fsldma is not the right solution.
>>=20
>> Hopefully this prompts fsldma authors to get involved because the=20
>> interoperability issue has been out there without comment*, just=20
>> band-aids, since October.
>>=20
>> --
>> Dan
>>=20
>> * well one comment from Ira saying the interrupt=20
>functionality worked=20
>> for him.
>
>Yes, I have used the device_prep_dma_interrupt() functionality=20
>quite a while back. However, I found it to be pretty much=20
>useless. Any functionality I need is covered by adding a=20
>callback to the last DMA
>memcpy() operation. Since the operations happen in-order, I=20
>can be sure that the entire set of memcpy()s cas completed. I=20
>never needed the capability to generate an interrupt without a=20
>memcpy().
>
>I agree that the fsldma driver could use some love. There are=20
>places where I am still not confident in the locking. Perhaps=20
>I can find some time over Christmas to work on it, but I need=20
>someone with 85xx/86xx hardware to test the changes. I only=20
>have 83xx hardware.

I can also help with the 85xx testing when I finish the busy project
soon.

- Leo
