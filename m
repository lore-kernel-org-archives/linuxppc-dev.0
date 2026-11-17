Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E256606A895
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bSyHuWX/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTHtm6cHcz309w;
	Tue, 17 Nov 2026 19:28:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794904112;
	cv=none; b=blHMLJNr7Uk4K37fV3vi8cP/OVH/LZCKvbsY2KcBvOfWfDCtjnDVGHnuQGGf9sivUwZlKNRMHjjZY64oZgFUVizO+Ln8DF8UZvhVZU6wkSsHvFbSzq6C4BXen4w5LGgwT/vuFTXlPc70l/w8XuGvQg0M2sU6+2Sf+heiEARSdpP3Kk5BaqRh8pGwa6nJCqbYKveyexxRE34pmIM8kyUkvrE43Y7i0smlEZHyr9lhdISefIr6PX7HUOZgpAAE6TtQKDwivz8N5XFwTioqbCnNylTMzwnEydrRT0k+9tVUmzyZKcfrkuJmJIon4AyN/0qoBhPz+Lq3m4NV/DfVEsoccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794904112; c=relaxed/relaxed;
	bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdZRfMoqkPKukfYB8FUQkxXmgJ4mFOf9wMwLpVdee9xBf9ohYqItQgF7/+qglphEAcLZ5YOZoBiXE9lVxqJXGqy1UGjQHNY+IcoikXAsyQjH+mVeOChDXGdWDtXdnsWsUQIkuLtCl9N3CPHqOEfzsrV/PsVcpTILJhkIluiixgN2vAnJw6xjVRNnNuYQPj40SAzo54Xkis6PIWafbefZTlqSaRq+LaDxUp1UtdKB7CTcgVQs6W2+IOxx6+zt4by7egnnfNq3/s7MkdhEd9fSlIrLiKmq8TXIr6laj9WAS4v+Fx2nc72fWw2w5bIIPh8Gt2KCtag4jixBtEy5K6dEFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bSyHuWX/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bSyHuWX/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTHtl73l6z30C0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:28:31 +1100 (AEDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so12248085e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904108; x=1795508908; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=bSyHuWX/0TINQKXPn8SFY0401wXzBvOOUiWGduZBqoWo3yxlCO2E/GAz4G376FQpql
         UJ9VYxchb6H40XO7cPDHhZxwAOqapVCQoPCDM8GV3yJmbx1NMdyZct4/YBfDb/6vwrU9
         BY0mW/Z8ybhxwa0IwfuY6VCp3uwt8qcSo9DabJBj+wvBkfdqVqFsWqdIIyPtP9CbNA1/
         3E8SVx5FdsM2KT+M5/GpeLIKFRzLCWRdWPKXt1RUql1ypmK8sydEpqIKBB6tevEghd4S
         4KybsrKN3AMs6NxRmGN2X0mXjGHoF9xwy8drmywu1EX+LsHJILX2Hhecx6PvbKXHSTWp
         m1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904108; x=1795508908;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80nJ9mfJsz3UGKSZAnLQ0A7kD85nyx4H/r5vYSV/3QM=;
        b=O2Bw+As4DL6I538wh8f2vmlN2m3PKWlS1/cWneVMB09lWOk7l6PcBJZj1//lQmcuer
         1MHqm52NWnG0JKcKw73kFW82Bgaq7x4ML0kJQc4KlHrUc3RdIY+Wcha3N3km2Wzucn4V
         MaOaa9CU12hUUNykRWAJfMBXMIFgZnuSupf+iuUCjU6kM/63pRj9VzPOUKWZVC02Vbuj
         Y1VU7/4bwcIrWF4jYdo9LO8jUF2WvnOUBIvADdav6LdFM2gxyaLEeWdlJuVo1GeNLRuZ
         QxTalpBQJX2LNiZdsOUcejjGH+Ut2Azy2gAap2GI3Cez/r2CliGpFrwbmiQx3f350voh
         SyOw==
X-Forwarded-Encrypted: i=1; AL+hErGcqeBfBWZ/3+adhMWZlJ1tgpjbkZVihB5hA7cb7DkqjsJToFBPC+cQ7tJU+OX41LlYI0TezpnO673Xf0A=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/WI3jzgbMbrfXk6qYQcEExU2jk1wthGex+j4D8ixmgZXGVZ08L
	IPApzSix4aCSyXXfEb6wLi1c6L9JnBfPwOWyYCSxxhOl562fOyuniijgsEOJOhy5Igfx
X-Gm-Gg: AYBFou3mpMz8VRkCRtNqpisWMbo5PPv4sfy5hZ9ZnOgQ2JWaFNuuMcurI5uyr2LunnC
	tfRakNnRMjzkYrTHGi5uVpu9WCQ+U4Yldsw1CEVZ8En2E0xkh4IrRi0GsAkNfA3iaQbvgI6lRXb
	xk7D6PBCwuHoYdgDBHyyWqRo04KnJ+cRwyycfrTfGx3mkUWCJ8TCHPZsWFz9rzh9HMywbuqrmeo
	bMZMMND19mu0vGR+gUWG7ps3Wh0ibil24982ZZv+D/qB6Ad7fdd5gfjLfbFbdi5ahxjD2lJ5Cug
	4qGaVvr8y46wfb6WTno8Wv0gPwqr5+0x8z5XTIL2BPj0n+bj5AZQVI2nFhsasksL3iQIQf7MZqo
	PKqNYFOnn9Yzs6KrcToDVEEVgF4DBAJLrOo0aosB1jPYL5GUNB1IjG8ytQA9/pQiWTZTeMs4DGW
	A3t+x7OwKY8I7k68s21PUq34+ry4IZ+HBD06CzT1LfODl5iVP9UtSQw4jw4qaisaFrN38qiHqiJ
	Q+j8AlnQnmM9ZkT9eSjFYe9o2pM1jZp/QvkvX3pgUwjHOiA0qaiZC1mrMTbh5gpPZAP79SU+b7r
	uBZsOxvA79JnA+gSPKyD117Ns6cnvM4861vBkLH9wpZpJ9lURkrH/RYJ7ksXQT45Ual2xgBSVUk
	PBTHZmd/o8PnZukktOPHQn8vm01qgKLOZWBdPqbjrNh8ChNz1TG0hL5HH
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4bb55a5d634mr255399085e9.5.1794904108278;
        Tue, 17 Nov 2026 00:28:28 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78422d2dsm75197335e9.10.2026.11.17.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:27 -0800 (PST)
Message-ID: <afc070a816e3ae5eb3c9e2d62d4f25c59ee61df2.camel@amutable.com>
Subject: Re: [PATCH RFC v3 26/44] xenfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:26 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-26-8cbbea1cf34f@kernel.org>
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
> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/xen/xenfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
> index 37ea7c5c03469..aba7d038ed735 100644
> --- a/drivers/xen/xenfs/super.c
> +++ b/drivers/xen/xenfs/super.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0
> =C2=A0#include <xen/xen.h>
> @@ -80,6 +81,7 @@ static const struct fs_context_operations
> xenfs_context_ops =3D {
> =C2=A0
> =C2=A0static int xenfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &xenfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

