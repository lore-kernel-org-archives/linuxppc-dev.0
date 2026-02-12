Return-Path: <linuxppc-dev+bounces-16856-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338D2EEA871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Feb 2026 00:00:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBsjx4kp4z2xnh;
	Fri, 13 Feb 2026 11:00:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::aa"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770940805;
	cv=none; b=cL2ieCQK+Tus8fsG8jdtCDfIsO524JfI2Jn4WvZk7Fzef/BsWEMfadVFj0KL639C8HCs+9IgKsslwMUEwZbLwBn+EIzIQmiTBr8uLPzKh2o+wrAThMTp5zU7oDHLY7o1G4in0fgDMQNE5Z8kyqvsDT4ZT9Xlcbus7+wGPeqtlf8cttj43f+qUN0pgPKE+ImaYSBADVa79hAKj6qYBZSnWwHDsB+ky6yJto8OEDQFPKEAfkQcy5Y4/33z69fR8Qc6XDYiUP8bBWTm4PLV/vhsR4ShTsEpaG1Ye3VIrXIi206cw+ajHSXVtHJ2y1JkyAx2szgd7XxDOiTikfdOagCY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770940805; c=relaxed/relaxed;
	bh=ECZ3Gr3aPzDdLph7XL37lAMGWK6WSXx8uq0q0FNltrM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NcPJoAC29mSKJ1qqGRARVjxmIjvSyKvBiFvSBI64b2U7upTCZm8tCDfGWdXbx3ex2QIgcK5SYaUjZqM2kDIhanzV92zxZhKNPx5fu8h/kP/y5/WTnTu425qVN4jr779xN4SsruDqHdsXQy3w5fAC93RaQYrmllAIHPB6pb09CZhVb9mnxBoslKqIRfSXKJpOtwGl0rCiTqegdk8+vf/2LehLdmrXCYQCjOtAD9+2UzHpSuV7j8t4pqA5dQszgVWPNZ4GRdnKDD5O25OCKWTW2/6xGLQlGeI0TUeSz41fHuST6VQetun6zXMDbwPeGtGRC45inLsiZgLzFgefgG9WAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZlwWRC4t; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::aa; helo=out-170.mta1.migadu.com; envelope-from=yonghong.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZlwWRC4t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::aa; helo=out-170.mta1.migadu.com; envelope-from=yonghong.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 341 seconds by postgrey-1.37 at boromir; Fri, 13 Feb 2026 11:00:04 AEDT
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBsjw6Yqtz2xlx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2026 11:00:04 +1100 (AEDT)
Message-ID: <2e8a8754-5b4e-45c4-a54a-488f0a7b1633@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770940439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECZ3Gr3aPzDdLph7XL37lAMGWK6WSXx8uq0q0FNltrM=;
	b=ZlwWRC4t9UIkaxR129QlAsVOcFIufN3uopaEVE6kKLVKI4UQseHqGC6gXhLlEOaUZWjnY8
	K7oLkZiG0VfXrf8shahIoskBgaEYOXuHK+ZerzqWmuUPb8sgGo2Piah/RXxJYAw1+B5ETy
	tlmP/xiJ+Ls/LJu24WrA0Gp9gZuUDrA=
Date: Thu, 12 Feb 2026 15:53:49 -0800
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
Subject: Re: [PATCH v2] selftests/bpf: Add powerpc support for
 get_preempt_count() in selftest
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 christophe.leroy@csgroup.eu, maddy@linux.ibm.com, mpe@ellerman.id.au
References: <20260212092558.370623-1-skb99@linux.ibm.com>
 <a3dfdbc2-bd72-412d-83b4-f17d68949c6b@linux.dev>
In-Reply-To: <a3dfdbc2-bd72-412d-83b4-f17d68949c6b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/12/26 3:52 PM, Yonghong Song wrote:
>
>
> On 2/12/26 1:25 AM, Saket Kumar Bhaskar wrote:
>> get_preempt_count() is enabled to return preempt_count for powerpc,
>> so that bpf_in_interrupt()/bpf_in_nmi()/bpf_in_serving_softirq()/
>> bpf_in_task()/bpf_in_hardirq()/get_preempt_count() works for
>> powerpc as well.
>>
>> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>> ---
>> Changes since v1:
>> * Updated the comments to include powerpc for the APIs.
>>
>> v1: 
>> https://lore.kernel.org/bpf/20260129054035.168078-1-skb99@linux.ibm.com/
>> ---
>>   tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h 
>> b/tools/testing/selftests/bpf/bpf_experimental.h
>> index 4b7210c318dd..9df77e59d4f5 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -645,6 +645,8 @@ static inline int get_preempt_count(void)
>> bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
>>   #elif defined(bpf_target_arm64)
>>       return bpf_get_current_task_btf()->thread_info.preempt.count;
>> +#elif defined(bpf_target_powerpc)
>> +    return bpf_get_current_task_btf()->thread_info.preempt_count;
>>   #endif
>
> Maybe do
>   #elif defined(bpf_target_arm64) || defined(bpf_target_powerpc)
> ?

Sorry, my bad. Please ignore as missing preempt.count vs. preempt_count.

>
>>       return 0;
>>   }
>> @@ -653,6 +655,7 @@ static inline int get_preempt_count(void)
>>    *    Report whether it is in interrupt context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_interrupt(void)
>>   {
>> @@ -672,6 +675,7 @@ static inline int bpf_in_interrupt(void)
>>    *    Report whether it is in NMI context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_nmi(void)
>>   {
>> @@ -682,6 +686,7 @@ static inline int bpf_in_nmi(void)
>>    *    Report whether it is in hard IRQ context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_hardirq(void)
>>   {
>> @@ -692,6 +697,7 @@ static inline int bpf_in_hardirq(void)
>>    *    Report whether it is in softirq context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_serving_softirq(void)
>>   {
>> @@ -710,6 +716,7 @@ static inline int bpf_in_serving_softirq(void)
>>    *    Report whether it is in task context. Only works on the 
>> following archs:
>>    *    * x86
>>    *    * arm64
>> + *    * powerpc64
>>    */
>>   static inline int bpf_in_task(void)
>>   {
>
>


