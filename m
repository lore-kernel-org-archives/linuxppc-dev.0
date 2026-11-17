Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE5B606A8B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lPdFuJO+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTHtL6X6Kz2yjN;
	Tue, 17 Nov 2026 19:28:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794904090;
	cv=none; b=UjOVCRL6LHmsBZ9tFrfW1+a44jAZz+M2savQK70cNrtsZ5uy83wXM9B8vGTFrK3mw8+Z8Wiy89jaWxovCTskuSfLWIQOeb2FdH0ZrpVpteKAq2hJcOm0//h62+1x/dno6pGzS7q3cmFo3fbn1l/Tlt+uzmOPxExterMsVhfk4z8zOAyFbhhHBzg/sf5mOGkjTv4IAELsBF6vHjsrhI6dKF8Z289zz6p9g57hpt6NPqgXh0WXRuyOTITI14H35NeYdC+hus92T13pxlFd2x7uCfEE/ccRsTr0GNPYSF7MZGjVa1RPQeXf4emjvo707e3n0mQEAYRscDs7RRPPcu5O8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794904090; c=relaxed/relaxed;
	bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DnY7i+x51VyIWAPZK5SP1j5+2caRFfgUlMEGQr9idDqai8FS4Nt9AEbx6YTiakZcVg8f4cIHAYKQESFMHRPoAyU4NEzM83nsry1dCrXUjawmat6Q1eTkfWTG6jLqQQCBLdsPRBQNHw+Gbor39I+f6d5q1C60EPE+jjteXtWs51nn8mwpllkrcqDlsNLymloGdWZkLcuJxh1I3w2DRYd72LAMB9H9Mg/NOs1X3vTkUV816YndcZ/MbDLGIsbtlICLXJScpsWadGMJiC6O18bHA+Uc3pQ2sI3wPXHimCfbuepx+SeOeAM7w7elc8FBkraaYcoHigtoZUU6KfG2fGNFxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lPdFuJO+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lPdFuJO+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTHtK6FW1z2yD8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:28:09 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4bb61185057so19298025e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904086; x=1795508886; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=lPdFuJO+DGh3071aTCrz/IEv07Vt7xHuofQXalMQL06k9Gdg+7gCAQ3+9jXEGwknr2
         3BKF+ATLL3zsMUdfh5XhBsB+lBZozqdNP/mu4CKGidww3Tr5FRBfxmgmaChsrffwVh5g
         57MxNsVnOyMlaWjS82KhO3j5cTuhyr7VadRIYP+lo6vozj9Dp54E/F6ZlP1CqqmDEPRt
         sH8nqOZpnckoeIHtpcsppTMXVq0MCIvy0ZxuRKt6MVOeSDZT7wqj39XCILXBDrzHxgJN
         KXshL7ABzxJqkgXDvA1/04prK0+F84ZfvqjZbUguIWNgaivCkn2EPqxIkl7/StYHKg5b
         DtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904086; x=1795508886;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=KqC6BLWGF/oixQSArePt/LXUp/m/ejOU7Nnn/ULC/zSfEWmTw2vy/YnZWpHbJZJszb
         wRkHpKoG4Ao6z8LxSbyILX9thW0FQjf6wuCVLgS77nl70QXgAmLGe7BfEUCQyaNLcbJc
         tTdOhH3VrbZSlhP0FFUR0/1YgELZlB3D1WpT0fglATPugkSCkx8IpVDLXEd3Go0To2+v
         dPt8ipQfEa8suALe1GLxUO4AG1eDnjAuIG7h07ofNZyddJd1TRvsX+xB229M65F9p+2L
         ptj5I0fClrRi9X+cmpoZMBuuVrGEUiQ72SHkOr0ibwraFLtN8u4Wv1dg11cJ9DmikzA7
         RLzA==
X-Forwarded-Encrypted: i=1; AL+hErHOxKNARW6KY+7JswbBZqy0WmONRzU7mRxR14hRS+VJrko6yUmsXJF/2pDhjZ1BTNSI+poo+xI+7OutN9k=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+1rPqjHr1Llaf7QdgvcWVBoGjpYJ0g+xadRiVMRAs+uoIo1Rb7
	1Rrl2G3aKyVz+LFkxNkaLqeKFG50HYES+1K5zJQQRlbrfE1UH5rVZkaL6UdE7XGp9WD0
X-Gm-Gg: AYBFou2VL2cHEXwp6D9vRnBjYTm0XW7EkF0+abSmIUEjt3UUAHDq8GHvKK3M0XK7i//
	6UhqgH3O5s9/awq7paK1n0dHw9u+JcgImoDkx6QEj52vt6ZL08LK1xrB0EPf7HQhn6RgORqIlFX
	4QDA1McUWF72UxJ5scQ9SV9Pv3JIX6bXlq9yVvjEW7PME5rWx3TmegpJQdpWBAsb3reD+SP/CWo
	NLsa339x/0pFGHdUXkG7qw/Hap9nCyaWNHv9gs5JQnK5xCx4VpiaAo9+xE47Db3wRosuVUqCFnu
	lVm5YjIXtSqpWdDBN0GEZwyoWATPrFqCZlWk5eJZcdKvXVcllg55ub2HpgrTqD5e4JzRRbHedRo
	7unkETf/wOfktiofTqTdkzuAOKuCKc+7npXf1k+jzRgs1JdZOq6fGcGYGbqQ7iLfcyjfiJ4dbhA
	NCFFJCPo1tWrGqtA/Q9gmNbiPW6pbau6ILjydL8oqwP4uiHtebyK0ICJhyl7zjnvFkRDRFmfTnR
	rElU2PLfC/gVkGASBJwXAFPnYF2a06CcPkuQq2eAW3l/LHjXkBH9jDI3gvUREtqB6KGJCt3DMCe
	zlTUVkMoQltFOcD7Iinsz66VTkXv5NUJH+iw7HeEnFU8Vlh6B7ZekEA1L06vh0uK7nzf7lvXU30
	sXQ1Y1GQjntWEaz0oulqkSsFcM6TfUxdKqm/6+6u278uL2nK0ZeWGPi82
X-Received: by 2002:a05:600c:512:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb55a5aa47mr209766355e9.19.1794904086313;
        Tue, 17 Nov 2026 00:28:06 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm74782845e9.8.2026.11.17.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:05 -0800 (PST)
Message-ID: <fa0ce0f7ecdbe91cc6773bcbe86be137d2129944.camel@amutable.com>
Subject: Re: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, Chuck Lever	 <cel@kernel.org>, Chris Down
 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:04 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/nfsd/nfsctl.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f32311f2d7cf9..ce2666deddbd9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0
> =C2=A0#include <linux/sunrpc/cache.h>
> =C2=A0#include <linux/sunrpc/svcsock.h>
> @@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &nfsd_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

