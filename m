Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11B8CB6F0A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 09:39:07 +1100 (EST)
Subject: Re: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091216164144.daff5468.kim.phillips@freescale.com>
Date: Wed, 16 Dec 2009 16:38:50 -0600
Message-Id: <2868C8CF-584B-4FA7-9C3B-2FACEF77527E@kernel.crashing.org>
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
	<20091216164144.daff5468.kim.phillips@freescale.com>
To: Kim Phillips <Kim.Phillips@freescale.com>
Cc: herbert@gondor.apana.org.au, B04825@freescale.com,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vishnu Suresh <Vishnu@freescale.com>,
	linux-crypto@vger.kernel.org, Dipen Dudhat <Dipen.Dudhat@freescale.com>,
	dan.j.williams@intel.com, Maneesh Gupta <Maneesh.Gupta@freescale.com>,
	R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 16, 2009, at 4:41 PM, Kim Phillips wrote:

> On Wed, 16 Dec 2009 21:04:58 +0530
> Vishnu Suresh <Vishnu@freescale.com> wrote:
>=20
>> Expose Talitos's XOR functionality to be used for
>> RAID Parity calculation via the Async_tx layer.
>>=20
>> Known Issue:
>> When used with fsldma, random crashes are observed
>> on some platforms. Hence, inter-operability with fsldma
>> is currently disabled
>>=20
>> Thanks to Surender Kumar and Lee Nipper for their help in
>> realising this driver
>>=20
>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>> Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
>> Signed-off-by: Maneesh Gupta <Maneesh.Gupta@freescale.com>
>> Signed-off-by: Vishnu Suresh <Vishnu@freescale.com>
>> ---
>> Changes with respect to v1 as per comments received
>> o. Rebased to linux-next as of 20091216
>> o. The selection is based exclusive of fsldma
>> o. Intoduced a new Kernel Configuration variable
>>   *. This enables selecting the Cryptographic functionality
>>      of Talitos along with fsldma.
>>   *. Disables the XOR parity calculation offload, if fsldma enabled
>>      either as kernel in-built or as a module
>>   *. Once the inter-operability with fsldma is resolved, this option
>>      can be removed
>=20
> wait, why can't the interoperability bug be fixed in the first place?

I agree w/Kim.  We need to better understand what the bug is and how to =
reproduce it so we can get to the root cause.

Paper taping over it by disabling fsldma is not the right solution.

- k=
