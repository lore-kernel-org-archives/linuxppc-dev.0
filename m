Return-Path: <SRS0=DN5o=RY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30567C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 06:30:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BF5218AE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 06:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="LfuvBGwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BF5218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PxkL2QJGzDq63
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 17:30:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PxhT6jN1zDq63
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 17:29:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="LfuvBGwt"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 44PxhS22X6z9sRf; Thu, 21 Mar 2019 17:29:12 +1100 (AEDT)
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 44PxhR3YlXz9sRQ;
 Thu, 21 Mar 2019 17:29:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1553149752;
 bh=9AUmukr7QM9mrGN4JnbxUe7M4ctd4H6ODkVVSHaqqPM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=LfuvBGwtNkKzSvc1D+YVcRAfR9SqBYE8ZAVDxz1dkM3DW7KUXc1urinWg4dJvMCU9
 0OExP76F13fm7xuUShzM4yOYJMsXmyCC+7bEwBooG8axkMX8R/3Q/u5EB/6qKJI7du
 0i+UD4kFEqBZ6YamuWoWUAo+ZwE5LiegZ8tUvn25tlWLwRdrxtjuG7FYwIitU3jwrX
 ZREddEP42/f4Rgodqvmbj1QXmqf6eZSki/7qtRngSU4t86okTfApm91YtQKQh5JyoA
 xZa7pIs6zgp1+s4vokicvypt4YNvhWIeQakSk8ruiNjbW2xtskthJ3KXYEIS7kWTy+
 u5f9l4oMrM7bw==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 5E1592A0A1A; Thu, 21 Mar 2019 17:29:11 +1100 (AEDT)
Message-ID: <1385fa307b4d21e18879b4bf962e2ce240363a15.camel@neuling.org>
Subject: Re: [PATCH] powerpc/security: Fix spectre_v2 reporting
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Thu, 21 Mar 2019 17:29:11 +1100
In-Reply-To: <20190321042433.20454-1-mpe@ellerman.id.au>
References: <20190321042433.20454-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: diana.craciun@nxp.com, msuchanek@suse.de, andrew.donnellan@au1.ibm.com,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-03-21 at 15:24 +1100, Michael Ellerman wrote:
> When I updated the spectre_v2 reporting to handle software count cache
> flush I got the logic wrong when there's no software count cache
> enabled at all.
>=20
> The result is that on systems with the software count cache flush
> disabled we print:
>=20
>   Mitigation: Indirect branch cache disabled, Software count cache flush
>=20
> Which correctly indicates that the count cache is disabled, but
> incorrectly says the software count cache flush is enabled.
>=20
> The root of the problem is that we are trying to handle all
> combinations of options. But we know now that we only expect to see
> the software count cache flush enabled if the other options are false.
>=20
> So split the two cases, which simplifies the logic and fixes the bug.
> We were also missing a space before "(hardware accelerated)".
>=20
> The result is we see one of:
>=20
>   Mitigation: Indirect branch serialisation (kernel only)
>   Mitigation: Indirect branch cache disabled
>   Mitigation: Software count cache flush
>   Mitigation: Software count cache flush (hardware accelerated)
>=20
> Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache f=
lush")
> Cc: stable@vger.kernel.org # v4.19+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

LGTM

Reviewed-by: Michael Neuling <mikey@neuling.org>

> ---
>  arch/powerpc/kernel/security.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/securit=
y.c
> index 9b8631533e02..b33bafb8fcea 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -190,29 +190,22 @@ ssize_t cpu_show_spectre_v2(struct device *dev, str=
uct device_attribute *attr, c
>  	bcs =3D security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
>  	ccd =3D security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
> =20
> -	if (bcs || ccd || count_cache_flush_type !=3D COUNT_CACHE_FLUSH_NONE) {
> -		bool comma =3D false;
> +	if (bcs || ccd) {
>  		seq_buf_printf(&s, "Mitigation: ");
> =20
> -		if (bcs) {
> +		if (bcs)
>  			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
> -			comma =3D true;
> -		}
> =20
> -		if (ccd) {
> -			if (comma)
> -				seq_buf_printf(&s, ", ");
> -			seq_buf_printf(&s, "Indirect branch cache disabled");
> -			comma =3D true;
> -		}
> -
> -		if (comma)
> +		if (bcs && ccd)
>  			seq_buf_printf(&s, ", ");
> =20
> -		seq_buf_printf(&s, "Software count cache flush");
> +		if (ccd)
> +			seq_buf_printf(&s, "Indirect branch cache disabled");
> +	} else if (count_cache_flush_type !=3D COUNT_CACHE_FLUSH_NONE) {
> +		seq_buf_printf(&s, "Mitigation: Software count cache flush");
> =20
>  		if (count_cache_flush_type =3D=3D COUNT_CACHE_FLUSH_HW)
> -			seq_buf_printf(&s, "(hardware accelerated)");
> +			seq_buf_printf(&s, " (hardware accelerated)");
>  	} else if (btb_flush_enabled) {
>  		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
>  	} else {

