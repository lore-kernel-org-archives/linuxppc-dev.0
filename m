Return-Path: <linuxppc-dev+bounces-16855-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71F6EEA871
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Feb 2026 23:54:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBsb11CHpz2xnh;
	Fri, 13 Feb 2026 10:54:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770940445;
	cv=none; b=bUz5OI+fPjs9OOu0RHRhpICB2v0g+mNzDYfXcnJDC5Zmx59yXbeLluLCBK7so4spJ2K2WMogv3KbErgh4QGamvdeDBGmRhdT69zzFqDRhlmpnvirBwJk+eCv8la8yyCm0RoYBucjZw6lvzf9ZzUp+ZPdZfVpcVNGWXE7NFGoODHXPuzGGx9YYgw9at/G+3k7UYb/tsLwVd2rRBnsFm+3N9FVSwk6tLm7GPiYkSdvMeEtzeqKeklRSHVsuauVbNmB71lI9rBHvsoecBx0F4ERmdlSy00Exs10/a126oienWydlBGLO80VxolaTRO+la7WYRRC+AjwDNrfV8oBi82XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770940445; c=relaxed/relaxed;
	bh=1xQI/Fr3XtpQFzHaYiW8tEPZj7GG6uqufZbmsGpsNuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTt7nww4pjr92LBalyCBLA4e98r3jnYBOHtbycHT+NN3tBzGm7+3x1/NZq4CFYdvbvfv2IicZf3mSNQdci7+TsJZ9TkDLCK721UtW7pUkVl64xuR/g0TIYEJ45DXNzrp64x27vCIYcK/250lmETJgyCUo/bpK+HMxe7vNj74ztXf/puEWHw0mEUMOSjCyXE7y3+f9F9ski/6zdW4Pa5MTdxdeyaLWtt74g/t0ASkgBr4XTKsUlSolsPWhnyJe1yjl4lkaDgB5uVSdMsjbM7WN/n+FAuE7KizwoiH+X5cjlDHAbcgcf7hEPtouSDpqbJNYF+Nw+Onh621aE/y8dGNvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F+8nzL6V; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=yonghong.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F+8nzL6V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b7; helo=out-183.mta0.migadu.com; envelope-from=yonghong.song@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 78 seconds by postgrey-1.37 at boromir; Fri, 13 Feb 2026 10:53:59 AEDT
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBsZv3GQ6z2xlx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2026 10:53:58 +1100 (AEDT)
Message-ID: <a3dfdbc2-bd72-412d-83b4-f17d68949c6b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770940333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1xQI/Fr3XtpQFzHaYiW8tEPZj7GG6uqufZbmsGpsNuo=;
	b=F+8nzL6VuN/9C+H8xOTeUws+J2lN3fCcDtq/8xVHSnu/kueFQJ9rnkDiSzxP+YY/TlALnU
	pQAlBOf/PL9rAFc50w5Mj7MPm2IIGKC5ZmoUbOyJcDLxpuluuJhH7hatQfnjIRsQw27bC+
	zVXz3Rei2l2NR5xlhDhN7A5wKAxVptM=
Date: Thu, 12 Feb 2026 15:52:01 -0800
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
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 christophe.leroy@csgroup.eu, maddy@linux.ibm.com, mpe@ellerman.id.au
References: <20260212092558.370623-1-skb99@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260212092558.370623-1-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/12/26 1:25 AM, Saket Kumar Bhaskar wrote:
> get_preempt_count() is enabled to return preempt_count for powerpc,
> so that bpf_in_interrupt()/bpf_in_nmi()/bpf_in_serving_softirq()/
> bpf_in_task()/bpf_in_hardirq()/get_preempt_count() works for
> powerpc as well.
>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
> Changes since v1:
> * Updated the comments to include powerpc for the APIs.
>
> v1: https://lore.kernel.org/bpf/20260129054035.168078-1-skb99@linux.ibm.com/
> ---
>   tools/testing/selftests/bpf/bpf_experimental.h | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 4b7210c318dd..9df77e59d4f5 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -645,6 +645,8 @@ static inline int get_preempt_count(void)
>   			bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
>   #elif defined(bpf_target_arm64)
>   	return bpf_get_current_task_btf()->thread_info.preempt.count;
> +#elif defined(bpf_target_powerpc)
> +	return bpf_get_current_task_btf()->thread_info.preempt_count;
>   #endif

Maybe do
   #elif defined(bpf_target_arm64) || defined(bpf_target_powerpc)
?

>   	return 0;
>   }
> @@ -653,6 +655,7 @@ static inline int get_preempt_count(void)
>    *	Report whether it is in interrupt context. Only works on the following archs:
>    *	* x86
>    *	* arm64
> + *	* powerpc64
>    */
>   static inline int bpf_in_interrupt(void)
>   {
> @@ -672,6 +675,7 @@ static inline int bpf_in_interrupt(void)
>    *	Report whether it is in NMI context. Only works on the following archs:
>    *	* x86
>    *	* arm64
> + *	* powerpc64
>    */
>   static inline int bpf_in_nmi(void)
>   {
> @@ -682,6 +686,7 @@ static inline int bpf_in_nmi(void)
>    *	Report whether it is in hard IRQ context. Only works on the following archs:
>    *	* x86
>    *	* arm64
> + *	* powerpc64
>    */
>   static inline int bpf_in_hardirq(void)
>   {
> @@ -692,6 +697,7 @@ static inline int bpf_in_hardirq(void)
>    *	Report whether it is in softirq context. Only works on the following archs:
>    *	* x86
>    *	* arm64
> + *	* powerpc64
>    */
>   static inline int bpf_in_serving_softirq(void)
>   {
> @@ -710,6 +716,7 @@ static inline int bpf_in_serving_softirq(void)
>    *	Report whether it is in task context. Only works on the following archs:
>    *	* x86
>    *	* arm64
> + *	* powerpc64
>    */
>   static inline int bpf_in_task(void)
>   {


