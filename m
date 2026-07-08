Return-Path: <linuxppc-dev+bounces-23776-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E76C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:51:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw9K93gBbz2yS0;
	Wed, 08 Jul 2026 17:51:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783497101;
	cv=none; b=gw1geddY+GjBOvjeggHtZvCUvCAtcZT04tAW1aSUZOl5My6WARBq29bsCp3ztxL4sqLjoz6h5XqfYIxCR9uKpSJg9Xfey1UxRjA8I/pWfEBYyI1ITouShNaELOp+IbKltrwuszowgt2DpeuwVS23n9EC8QdcfFofien2WRNljeie1BVI+p2wwFFI8dmBoMiMceS4cbcgOV9REPu3k1KXzYPStahaOYVDZ43WSdKwjP0o8HlaVatFAz3jMabILkgFn5x9v3+dD4JltB65B9xrSza73hhF3cRshIOPkg3dyv9z4eoA6t8ycwaWCSw0S8U1CgqFfou5kE+xPgqWy3lXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783497101; c=relaxed/relaxed;
	bh=OJHANmKsQdwywYX/0CEdvcwYSI8WhfS0TBSkz/+ZIVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEyHZ9u41j1W8AHn4ethi1qAGa7IdJlAHArDOqICdSfTW9aD316glwsiLAAZQJHKEDx0kLn3eFUWrDreX+p7j/TC8GzwbKpn4M1VBzpka8+/oUlmtesu1yaZtobeKGmHzIgVEBvTdzKblTj7dZEp7DdTibi1rWE5i91a4trkhcvZJVWanddo5SrZ++/LrFnPItcI67NJNEC8817ZkIcml7PPeRXPsqMctNggSFyjB0m5n846lrMaSikXPBTkcn6TjXOaJOkfBAlLb0V93a+td/ztP3f/A+gQD42TrMiyJlCUDo3Q6pvtCtZsKWy11G+johCHwvVrY+/qdZIZobIszg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrWWMJeC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrWWMJeC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw9K83Gfdz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 17:51:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E95646001A;
	Wed,  8 Jul 2026 07:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6181F000E9;
	Wed,  8 Jul 2026 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783497097;
	bh=OJHANmKsQdwywYX/0CEdvcwYSI8WhfS0TBSkz/+ZIVA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JrWWMJeCIPfuWaRQJgmV6c/Wr7w9QdTKRfcgh3AMqT66FTXnmQ7xiqVXdH3WYta1q
	 UIeRkFOsFi7tipM8vJJng/Vq/vU72r2hBfdXmaFsH90jdpllMATXFjJ89HipX2Ho8D
	 I6GPQhZwhNrWvg2XRxVmksec+d1Ttp6YP8/8I1hmCatmL7/tA1pR6RtXi2yqDX6Qm/
	 ge7pQ0E0G4fp1plnuj+GcZ0rnlwx7D0nafKZouvqHXSFCcRQNHhPmZ27/TeyUr3gl7
	 ku+ByKMCud3F7pwrweb6x5U9jspxfUYNcJkyzlQAkMRTSZ67fqwI3i4j/HJfWFMqzY
	 08a3wXsVwf2rQ==
Message-ID: <5430b52d-a072-41ea-ab56-9bb2f6f88849@kernel.org>
Date: Wed, 8 Jul 2026 09:51:34 +0200
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
Subject: Re: test_bitmap fails on ppc/ppc64 on kernels v7.1.3, v7.2-rc2
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Erhard Furtner <erhard_f@mailbox.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org
References: <ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org>
 <98d65de7-e5aa-4197-85bd-219eab01e572@kernel.org>
 <b9b762d0-cfe1-4fdb-b668-b6ef4afb0059@mailbox.org>
 <ak3_sGAnFxbmxfe8@ashevche-desk.local>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <ak3_sGAnFxbmxfe8@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/07/2026 à 09:43, Andy Shevchenko a écrit :
> On Wed, Jul 08, 2026 at 01:25:01AM +0200, Erhard Furtner wrote:
> 
> ...
> 
>>> So there is something with your config
>>
>> Interesting! As I get the same test failure on my Talos II too.
>>
>> Anyhow, I was able to bisect the issue. Offending commit is:
>>
>>   # git bisect bad
>> 6b5a4b68736798df1031404a2fad06d031253ef7 is the first bad commit
>> commit 6b5a4b68736798df1031404a2fad06d031253ef7 (HEAD)
>> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Date:   Thu Feb 26 12:16:44 2026 +0100
>>
>>      bitmap: Add test for out-of-boundary modifications for scatter & gather
>>
>>      Make sure that bitmap_scatter() and bitmap_gather() do not modify
>>      the bits outside of the given nbits span.
>>
>>      Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>      Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>
>>   lib/test_bitmap.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>>
>> Reverting this commit on top of v7.2-rc2 lets the test pass:
>>
>> test_bitmap: loaded.
>> test_bitmap: parselist('0-2047:128/256'):	888
>> test_bitmap: scnprintf("%*pbl", '0-32767'):	6074
>> test_bitmap: test_bitmap_read_perf:		1190938
>> test_bitmap: test_bitmap_write_perf:		1259471
>> test_bitmap: all 208655 tests passed
>>
>> Your hint about my config made me check a few options and I found the
>> offending one, which is INIT_STACK_ALL_PATTERN=y. On a kernel built with
>> INIT_STACK_ALL_ZERO=y the issue does not show up.
> 
> Oh, this is nice. So, there are two (more?) options I see to mitigate
> the issue:
> - carefully copy the garbage from the stack to the expected values
>    (effectively merge the whatever is on stack with the expected value)
> - allocate buffers on heap
> 
> The latter seems the easiest and right thing to do (since we can't really
> predict if the stack pattern is the same or bitmap APIs scatters the bits
> just on top of the respective set or clear ones over that pattern).
> 
> I will send a patch, thanks for the report and analysis!
> 
> 

The following change fixes the issue for me:

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 69813c10e6c0b..448c3eb48a4a8 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -392,6 +392,7 @@ static void __init test_bitmap_sg(void)

  	/* Scatter/gather relationship */
  	bitmap_zero(bmap_tmp, 100);
+	bitmap_zero(bmap_res, 100);
  	bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
  	bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
  	expect_eq_bitmap(bmap_scatter, bmap_res, 100);


Christophe

