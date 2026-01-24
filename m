Return-Path: <linuxppc-dev+bounces-16269-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B12FD715DE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jan 2026 10:03:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyr3Y0NPmz2xqj;
	Sat, 24 Jan 2026 21:03:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769249017;
	cv=none; b=KkV1nR6pXzw6lz81OneWciFsGPRVm7AXsR4iMMNLCYfVzKwGcA0Dsvs0W2Dxu2gAvUARSRa2V81ANlIzgqM7s9CSAfh/0RywQULKLUhQSfa7XY0h3cELebHDu4HTaoh0H6MoJ/ue8nn7JIM3hRWGoh1ccvpeNVMvfGUe5vqOy3CzqsV/zvQRmJa9gM/hRjubnyhVfTUg33k0rNx1ab/6HIApioZ4mIopwPAuMIUWHM1RNQiygI3xDmdzY7VcCRQEOTSLx0XABB05YDB38Mh9d2Xz45f20eKqImwFZK5OScUuynk4xsjwuHvs4BiWaeUgXejHw8rtmcFM0Q3+L51aqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769249017; c=relaxed/relaxed;
	bh=NhNxN2mwGL1dI8Z9g5/+ywJ01FHB6rX5EmMwd9ajI/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWs6drlAGuoyW8obM/Qv+2gtv5IVDVnny6PcpMdqHUDcJL/6JwPTr0P7pR/7pV6CiBIQJu8SZZ1S1WxJzJoNzeLtNEygxC/c5DFcPBtd5AJ1hgrbPxa8mNloqI28e/hxfqKIpq84x/Xf6yvevZix5USo4mHWdlpbp7b+XImP8c2oko8JlvC09koPlsTpC2CDPWq4A69AlzQbIkb6QZdtW2pv4+EzKJeW9LuvNm2Bo/e8MoKYbMQ1qfauAtbfIM0I1FN7LX1rrgEfpmnWGJ26LCuTCa/CAlQYoLr6drqfPq4BrATFFL96mrn0x+nZoxuuPpOey75QgGPz0e389qExXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Alu5FVsI; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Alu5FVsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyr3X1z9Vz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jan 2026 21:03:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A24B60018;
	Sat, 24 Jan 2026 10:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547E6C116D0;
	Sat, 24 Jan 2026 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769249013;
	bh=7HjDQFsrIZZ2O+jImAdR17W4tRJbmz1pkyFCEQRRsMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Alu5FVsI2zbhiRtD7RJkfmJSHGHQgYngFB/7n2nLVto/ZSDMawxTA2QkO1vyAZUmS
	 CwRDUC8Clu+dWE8EcJSNMJfjPzSU0OipPIepMk7lyKZ5/CUcGhe6+Tnast6xPQXZeT
	 I/hWWGmsXGglhRMK0KBk2t474zRIdpkecJG1q9FyXujjaQ0xYhS1m64eVUXS2IjJL9
	 07n7V73N2GTPIiSHpzgBOezKOsJrykZnNS9xxVSe5BuZ5eUcpZW3DXMD6L+y+x916P
	 FJO7OOI51oS+TxxDdxl3LXA8HTWs1Xx/JGzkxplCSG3Pho1WbPmjWuL+2kr2hq+psn
	 31JN6oWp9jqUg==
Message-ID: <6182e996-f5fb-41fb-a100-a6baca5be540@kernel.org>
Date: Sat, 24 Jan 2026 11:03:28 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] pseries/plpks: add HCALLs for PowerVM Key Wrapping
 Module
To: Nayna Jain <nayna@linux.ibm.com>, Srish Srinivasan
 <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
 zohar@linux.ibm.com, rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260115100504.488665-1-ssrish@linux.ibm.com>
 <20260115100504.488665-5-ssrish@linux.ibm.com>
 <5b29327e-9175-416f-b34b-da4f6ac03a96@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <5b29327e-9175-416f-b34b-da4f6ac03a96@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/01/2026 à 21:45, Nayna Jain a écrit :
> 
> On 1/15/26 5:05 AM, Srish Srinivasan wrote:
>> The hypervisor generated wrapping key is an AES-GCM-256 symmetric key 
>> which
>> is stored in a non-volatile, secure, and encrypted storage called the 
>> Power
>> LPAR Platform KeyStore. It has policy based protections that prevent it
>> from being read out or exposed to the user.
>>
>> Implement H_PKS_GEN_KEY, H_PKS_WRAP_OBJECT, and H_PKS_UNWRAP_OBJECT 
>> HCALLs
>> to enable using the PowerVM Key Wrapping Module (PKWM) as a new trust
>> source for trusted keys. Disallow H_PKS_READ_OBJECT, H_PKS_SIGNED_UPDATE,
>> and H_PKS_WRITE_OBJECT for objects with the 'wrapping key' policy set.
>> Capture the availability status for the H_PKS_WRAP_OBJECT interface.
> 
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> ---
>>   Documentation/arch/powerpc/papr_hcalls.rst |  43 +++
>>   arch/powerpc/include/asm/plpks.h           |  10 +
>>   arch/powerpc/platforms/pseries/plpks.c     | 342 ++++++++++++++++++++-
>>   3 files changed, 393 insertions(+), 2 deletions(-)

[...]

>> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/ 
>> platforms/pseries/plpks.c
>> index 4a08f51537c8..b97b7750f6a8 100644
>> --- a/arch/powerpc/platforms/pseries/plpks.c
>> +++ b/arch/powerpc/platforms/pseries/plpks.c
>> @@ -9,6 +9,32 @@
>>   #define pr_fmt(fmt) "plpks: " fmt
>> +#define PLPKS_WRAPKEY_COMPONENT    "PLPKSWR"
>> +#define PLPKS_WRAPKEY_NAME    "default-wrapping-key"
>> +
>> +/*
>> + * To 4K align the {input, output} buffers to the {UN}WRAP H_CALLs
>> + */
>> +#define PLPKS_WRAPPING_BUF_ALIGN    4096
>> +
>> +/*
>> + * To ensure the output buffer's length is at least 1024 bytes greater
>> + * than the input buffer's length during the WRAP H_CALL
>> + */
>> +#define PLPKS_WRAPPING_BUF_DIFF    1024
>> +
>> +#define PLPKS_WRAP_INTERFACE_BIT    3
>> +#define PLPKS_WRAPPING_KEY_LENGTH    32
>> +
>> +#define WRAPFLAG_BE_BIT_SET(be_bit) \
>> +    BIT_ULL(63 - (be_bit))
>> +
>> +#define WRAPFLAG_BE_GENMASK(be_bit_hi, be_bit_lo) \
>> +    GENMASK_ULL(63 - (be_bit_hi), 63 - (be_bit_lo))
>> +
>> +#define WRAPFLAG_BE_FIELD_PREP(be_bit_hi, be_bit_lo, val) \
>> +    FIELD_PREP(WRAPFLAG_BE_GENMASK(be_bit_hi, be_bit_lo), (val))

I get following build failure:

   CC      arch/powerpc/platforms/pseries/plpks.o
arch/powerpc/platforms/pseries/plpks.c: In function 'plpks_wrap_object':
arch/powerpc/platforms/pseries/plpks.c:36:9: error: implicit declaration 
of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
    36 |         FIELD_PREP(WRAPFLAG_BE_GENMASK(be_bit_hi, be_bit_lo), 
(val))
       |         ^~~~~~~~~~
arch/powerpc/platforms/pseries/plpks.c:1049:25: note: in expansion of 
macro 'WRAPFLAG_BE_FIELD_PREP'
  1049 |         objwrapflags |= WRAPFLAG_BE_FIELD_PREP(60, 63, 0x1);
       |                         ^~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


>> +
>>   #include <linux/delay.h>
>>   #include <linux/errno.h>
>>   #include <linux/io.h>

