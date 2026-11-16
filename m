Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC22606A89A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mosomDII
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSw6h2dHSz2y7p;
	Tue, 17 Nov 2026 04:37:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794850652;
	cv=pass; b=W5E0gcqt7YHzK8VAeOVyVsCr8mIFwuxqOZhLtx0io/tO5LFfCVsskxtWkrs8Pjy6d8yTcjarU2jHk5n0EKThFmxdHEtPBrRIAEUmTTOiC38lE7ME58XMbUOhBOq9WCwM3mGtNeevC5QUqMUN3JZRyZlOeoebUyyFAck/mZC4fSqbs2zeQL4zWCSPpfA1j4U+W0eFqHZQUFzw18733bJNVLXt6wv7iiLpGQuAC76MoAHUmf+eZq16eM0Q0nPzflCCBw4JJnbLSvHMp35tevHKSlLWbzGsdRlTRHCqkiGv+i+bDVdXlJZOXR1L5JpDtOgLtkTIARFSrxGHsB7dgfRFwg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794850652; c=relaxed/relaxed;
	bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8bPWo30M77T3pdKVPUu3XRZFz/iGs7nGSXokYDVjn4i3v/FjzwfBJA5ykyiupqNu8KqGRmJLkKxDXUFm6c+cPV8yHiYVHeE6hHnHlgnb8nhofdAPUlCcTIRT+p8iE2GvdB3c5EjEzSGMAFzzUpadW7vnK1lVeCEh8P9qn8D7/6XN2XLLBa5UolFjU0lgt5nFUsJIwQufliDuRZ04wYv2qtaF1tQB7+gDCLzWQzyB5MDrSTiIh256yhu8TwEhChaVk8TKl1VHdb1b1HEIGZGeiwTfFbRhInu9TmRCR4VwFwBocvfoQoRiT9z7SDCZFv1tFRqYBLYoCzADWB5pFvepA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mosomDII; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mosomDII;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSw6g1DZbz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 04:37:30 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so218684a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 09:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850648; cv=none;
        d=google.com; s=arc-20260327;
        b=mExFY2nyDuChQanBBsmWAKSf5QgnZmSz2gHwX0f14iJmqkw/vSmt4STnE/KF9dkgsz
         xXJGTpeLGI/4rM61Mlw6dKjmvqYCBEomKoHaJfeGIWO7EAReo7TjO3/9p+sQZ0iJM026
         MAXAm7GlHKiwnNi7PL/WhVOit7RoEd1SOgVNqqmtKXBIry68/7aBMWgyBTpCrV7ZtCoq
         bz+MklY1b8wUcMpKwFC1IFElwR3ACA3s2+2586rPnYiiNc8nySYs/sDoDsvD1t+MyAkI
         sHc97zr9xfGKUtdslJJ6T6TY150qcJW7JEBjMsLxjDPLSz2Gayty9MmEPpq4dMx/c2wI
         6oaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        fh=qlgMtXzEHIwlzPcTz0j+CSse42xezJtOqLbxiZauzEQ=;
        b=S0zR3Le8n7U/9XChAYkI1vurKypDBK/xSmwgsI+TyHYlbwNY/wmHfu8bfYpBK6yrEW
         xiQwYv9ZSjVbEu2bD9ZsBns1XzESeuWf94V1IzmNAtI6fY0x64V3lEElFikX5NA02tzc
         3c+CUxTZ55XGj4hv5q+UNEumm5SkreDY8niCEvQdUD1rlIzUCpORMX196LRshtzHRr9X
         kg7qWZifmtTta9xpXY32L5WUDg+mLGwde8lQx133FoI6NuRl2T2YQXvvH/JZ+UVVIBJU
         R21r62IyXaUsrY2NsFiVGCcBYZwJCe4/cufhN5XiPV/HEjbpoMpTb5khF06K7Kx2hHkJ
         BJaA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850648; x=1795455448; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=mosomDIInlImNqRYaD8LhBgDExTqAmUCWbdonEDcqu7YwaZ0dZlegvtKdlRDWt/PyY
         vOHu0X7jPtSGW0uhO6xFw1xcKXc1mvsJXYSZNnMxtRMR6z5EOWhKhypaa8U4Eritz3Du
         jMCBPolxlgX+RTQqB4dP3jDtuvc1dqE2ivmrAw4B0J/uMi73Qhn+mS5/xg9clEVXbEvl
         DHOAdasvqxPrcdkPrXjzAUIJug/yWbqUmYhfU5lIQhdVO4/GoR0Qu56/tlISRYKRPRdZ
         uEUR7UB7wmA0SrCb+fWXdN6pf4g5thkALvsQB13p3LqTyR709cgYOEJSNfsdLtn6sT6F
         sRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850648; x=1795455448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=JhP9+MFqk5mQw5UfNZT8Q41frSLopAJt+zq02YackDlEF8yDhOGk4lnshlDLjOlGZo
         lvOESY5NPXp0/TpqsnXLFePoHFBQbKYAfEgm9zN81uoqfATKPRN3zMsxkL36VIMI3CGS
         ysVeOke9VK5XxVi8P/kfJDDRfB6ZF2hq2W8Xbhu9vJl/JJMKa7eeDVnLM8MlM7Av3KAM
         tlX4odltOqXFxoeaptB2Ab+Y5uxfCtHYvXV+Wzd4E1XeKUHP0VIEtKJSL42V1id27Z2b
         7kXMqXxG9yLEQHsa4n/0EnGdmiDSB13eN/PGuj2z0Gr2GE+I0f36eBvPIhQg0BXsU09O
         P7Yw==
X-Forwarded-Encrypted: i=1; AL+hErFlOrdn6bUQ1aJ9YhZ0ycddzZU9o8a1O1Q7AJiyGI5Gk+eF0BbiqDl+F8kHeuooYs3F6lM5TcJUHEmPrTQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9tuVM88SBh91ugq5yrNhjd8lgr6Ms/oN1ioMUbAy2bPvBvt1AP
	UcbLYUwbHpix87jeFL5csLckSCH+TSvWpJgKEmoc5E8dPr51HXJFCkKP88no4bgmnhjsNzUUdOi
	y9t0gLKYHHC2kuw00MGx7jhuy07JF6n0=
X-Gm-Gg: AYBFou0IhjIW9UD93GwSkJ5DslxTz43oPU30+haDNeKM1FNykb0OjOM/es2SOwN/rQs
	Pb7YMNVLxvEnX0/KTLoN5mM15lDl7lR4AaFaat8TXrBV/iEAYSic9e/yMAG5cEemb5jcphB1z6z
	z97jku0qBUi576PPyRiaDna/V6oV5NzhuDwe7C6TgrAXZiIsGkCRublsQM6S4/8Dxa4oDJqEIa6
	4uxGKKdZZsKR67gO+mEEB0b1sctI+bm9zsg7QqEuZBdf4IkS/Q+1PQxp1DrddaxFMybK8u4EgqU
	4xEUyj7fOZmfkm9l3N9Zgz7FQ1iTo8893dzkDV2XwIhqIXzPEGYndZ/ETwF+zTC2s8bdG6e/39p
	pHgYWCIj47zJ/Ll1sJcsXSor9fAjxELt0cpgoYrNbrWF/O4b4Dbjn4MYXBxz3CTnEOag4Jw==
X-Received: by 2002:a05:6402:1598:b0:6b5:7250:d621 with SMTP id
 4fb4d7f45d1cf-6b859ae1a00mr134291a12.15.1794850647426; Mon, 16 Nov 2026
 09:37:27 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:37:16 +0100
X-Gm-Features: AclHuK_sKnxFPAK3k65pZhjyZC94SJD4eZ9z2j_P12s3kyb9TMw6hurQcjyq55Q
Message-ID: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 39d4d57dec230..719c2569dfeaf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
>
> +               /* Pseudo filesystems don't hold data for metacopy files.=
 */
> +               if (i >=3D ctx->nr - ctx->nr_data &&
> +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> +                       pr_err("filesystem on %s not supported as data-on=
ly layer\n",
> +                              l->name);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +

How about we make this just a tad more restrictive:

                /* Pseudo filesystems don't belong in composefs setup */
                if (ctx->nr_data &&
                    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
                        pr_err("filesystem on %s not supported along
with data-only layers\n",
                               l->name);
                        return ERR_PTR(-EINVAL);
                }

I could send this as followup patch, but since this version is simpler
there is no real reason to have the intermediate "only ban datadir" step.

Only the commit message needs a little more flexing to justify this.

Thanks,
Amir.

