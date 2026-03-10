Return-Path: <linuxppc-dev+bounces-17962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E03EB1043
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:54:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVW3g6fctz3bjb;
	Tue, 10 Mar 2026 21:54:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773140079;
	cv=none; b=hGRiHzZHbYxwOHnBUxz7+BJJvOhucw8L1Kve9S6X1mPqx04YUp6GzLAcXACVuOLlsYNX9QQYvUTOrI0mFE+TmMfieT2j1DmMnGKRZkNJDSdKbqlpmiBSBUScG9hAml3AV2AeLH+1q/W/q+VDM0mWciV6OuNU+ShroLDvF8MFQ4vpDZB4336R42xWD6V6VajpP3XC2AExriS5Pf2p0PyFuIAoDuF5DNJoTFLVIp0Ft5qRLajseODkr+9PUS+V/9XD+Y8DQrKO01dxudtPYPPlJImCrc5kH7MWAlHxPP7Zseda9kvdHqYxCPmTH2xzp0ZlyPvx68Dao5QPK30mzoy6og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773140079; c=relaxed/relaxed;
	bh=6QO5ntvLPfA187p5PJo6IYgfO5zToQJ1YiDcNCynq1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNnaaxv7Uim+SIMPk5IueQQOE4AUJJSSHwOPS6R1muXthBk3Uh99QSaUAq7ANjYQwx/64nMMHLog5S9Q6jXEU4ubBsMzxmn9F9nef0B/EAEequWoT41k1D6kp3WfpiSgqLC5lf2tYbsvEJHazmCnA11GTGd8Pq4Cb1I4JXMwLfq5IJcdU4opS6+kZ5xOyR6FGzHRv9+vsOyib+RsfnTJWUjgYNQ3wtaprWz3gT9hPtEN73cOn/U1QrNGSJQvQVBzNJPSKiF0qr6Ig+KzmOwybKiRTwqnHkvbagzmPO0gRwjDvf9FUvutrJ5mkGLjVy7ACB+dBhM/bCuRVGONiAojRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CR7tzUL2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CR7tzUL2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVW3f580xz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:54:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E67A6436A6;
	Tue, 10 Mar 2026 10:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138C9C19423;
	Tue, 10 Mar 2026 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140076;
	bh=YojY7SADYsX10JqwwxWP40HZR1g0zM1hzeKHVmZjYF8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CR7tzUL2OdMLsgES5got4Zz3U9I2+dwE++YfXDFAEGgcAJGyaJlJvs0l92R++jI0j
	 PcybfXq3VR45+DI1T3iWZD6vWWiIR3cusqklYjrEqMSTM7xjqXo6rPGiViyf17QoUD
	 W7BwipJSE7iAB+q5FBK/QBxY0lL8G6EAZF1vbvyT0k3ksma2v8nyfXCyu/S4tsM5UK
	 ARWteUHLH1cJxDE3JTPsqK15aPX0SKo9Vy+c7g7XTsllU0iFiiczOr2baDzZH6+3Jl
	 LG28rjzkqmMe5hQeijfjP3TJh3icEt7Z9+q0U7eATlOSKCukwuJbOc+OHhtwUwQfnR
	 WVuWv+3OeSvuA==
Message-ID: <3f26916b-5a1f-40b0-9c47-8b53e066e08c@kernel.org>
Date: Tue, 10 Mar 2026 11:54:31 +0100
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
Subject: Re: [PATCH] selftests/powerpc: Suppress false positive
 -Wmaybe-uninitialized with GCC 15
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Greg Kurz <groug@kaod.org>, linux-kernel@vger.kernel.org
References: <20260310101519.67157-1-amachhiw@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260310101519.67157-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/03/2026 à 11:15, Amit Machhiwal a écrit :
> GCC 15 reports the below false positive '-Wmaybe-uninitialized' warning
> in vphn_unpack_associativity() when building the powerpc selftests.
> 
>    # make -C tools/testing/selftests TARGETS="powerpc"
>    [...]
>      CC       test-vphn
>    In file included from test-vphn.c:3:
>    In function ‘vphn_unpack_associativity’,
>        inlined from ‘test_one’ at test-vphn.c:371:2,
>        inlined from ‘test_vphn’ at test-vphn.c:399:9:
>    test-vphn.c:10:33: error: ‘be_packed’ may be used uninitialized [-Werror=maybe-uninitialized]
>       10 | #define be16_to_cpup(x)         bswap_16(*x)
>          |                                 ^~~~~~~~
>    vphn.c:42:27: note: in expansion of macro ‘be16_to_cpup’
>       42 |                 u16 new = be16_to_cpup(field++);
>          |                           ^~~~~~~~~~~~
>    In file included from test-vphn.c:19:
>    vphn.c: In function ‘test_vphn’:
>    vphn.c:27:16: note: ‘be_packed’ declared here
>       27 |         __be64 be_packed[VPHN_REGISTER_COUNT];
>          |                ^~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> When vphn_unpack_associativity() is called from hcall_vphn(), this error
> is not seen during compilation because GCC 15 seems to consider 'retbuf'
> always populated from the hypervisor which is eventually referred by
> 'be_packed'. However, GCC 15's dataflow analysis can’t prove the same
> before the first dereference when vphn_unpack_associativity() is called
> from test_one() with pre-initialized array of 'struct test'. This
> results in a false positive warning which is promoted to an error under
> '-Werror'. This problem is not seen when the compilation is performed
> with GCC 13 and 14.
> 
> Suppress the warning locally around the offending statement when
> building with GCC 15 using a diagnostic pragma. This keeps the build
> working while limiting the scope of the suppression to the specific
> statement that triggers the false positive. An issue [1] has also been
> created on GCC bugzilla.

Usually when we get this kind of warning this is because the code is too 
complex. We should try to make it more obvious instead of just hiding 
the warning.

Here the for loop is a bit misleading.

> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fbugzilla%2Fshow_bug.cgi%3Fid%3D124427&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C06a4d55b55f24c5cf00208de7e8e3676%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639087346428583316%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=xEfO94N6IfGYhmmapNFduv3OrMarxpjTpZR6B38uR1s%3D&reserved=0
> 
> Fixes: 58dae82843f5 ("selftests/powerpc: Add test for VPHN")
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/vphn.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/vphn.c b/arch/powerpc/platforms/pseries/vphn.c
> index 3f85ece3c872..9bc891143fec 100644
> --- a/arch/powerpc/platforms/pseries/vphn.c
> +++ b/arch/powerpc/platforms/pseries/vphn.c
> @@ -39,7 +39,22 @@ static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
>   		be_packed[i] = cpu_to_be64(packed[i]);
>   
>   	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
> +/*
> + * When this function is called from hcall_vphn(), GCC 15 seems to consider
> + * 'retbuf' always populated from the hypervisor which is eventually referred by
> + * 'be_packed'. However, GCC 15's dataflow analysis can’t prove the same before
> + * the first dereference when this function is called from test_one() with
> + * pre-initialized array of 'struct test'. This results in a false positive
> + * '-Wmaybe-uninitialized' warning which is promoted to an error under
> + * '-Werror'. This problem is not seen when the compilation is performed with
> + * older GCC versions.
> + */
> +#pragma GCC diagnostic push
> +#if defined(__GNUC__) && __GNUC__ >= 15
> +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
> +#endif
>   		u16 new = be16_to_cpup(field++);
> +#pragma GCC diagnostic pop
>   
>   		if (is_32bit) {
>   			/*
> 
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681


