Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BC606A8A8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WukFXrRW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTHzJ53glz2ynZ;
	Tue, 17 Nov 2026 19:32:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794904348;
	cv=none; b=U7cViyVwB9BnhfvMj+aKn2X9p1FAjqiAgiBjLvYHQDfKz0mQvZVs0iFbVpwHu1/YpRz4cU4Td0RE0FM6oOR8dbq0ZAg3WGQ84Y/yVXZEmHYxtkEe5xupBP+l7so8tciS/XgBRq0JfmYbhTiuRMx4GrmbJDJFmPSVFvSVtqsVxVDRdMdN+MmxBoqTPZ6p5wm4YTleBebSp6qB7KP/S+iRGGGZdEd7HnU+yXFdMbrLyUEmyI/r7/tDFfSvQ6x6wWETp2YI9+Zjn7YOuLyHgwHy9EIc6eXW/wckZ6VLQxKlZ4wNKDZKmE0AI0xC2pHu9Od9KvCXsE1diAVN4JKLa0p45g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794904348; c=relaxed/relaxed;
	bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPBxKSEKYZOCPUWFZm5j22R/UUYNfGC4v/Ui8xScTxnA1LPUl1Q3qtDtbFpPT9Kn8k5vDlSqGbwlr143frsEsKrgJFp8hZizthT7Jy3roWnB4DUKr1QeFFRlm6K2TqzvNnYgm/3IFpJzgW0/FbeTFKpKzpgbN8kdENkW6gHykodRLaHsBPI74m5Kv0bGZJ1hW4WGNs3BzWBNwIQULq3IayRDdVvRG5sFNv8Z2Y8D8ew1c+aYgfkryaRevLpLWeFroImsHYRhpj88WMYkbk/Fa4sOHrptWbWVcv3UsmSJl+6G5KlRuE8aJznJ0oFqg7XAO5likQtlm1nAnps6M4vSdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WukFXrRW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WukFXrRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTHzH31TVz2ylj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:32:26 +1100 (AEDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1762453f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904343; x=1795509143; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=WukFXrRW6eO0ufEScgpXNJcdFyJFRY/rlh/5Srp0sMfWECo/2SS9xq9xqcrj0F67i7
         lnRcoZEP+Hn9uUV+WdSkN44ZQv37AJhGJYHQLcmOm3vjNpCWwC3ddtLEaUU63nMHZgFR
         /+eStEHG38Y4qtsW2Ro/gpWG+DtzQ4hE3sb9PHlVvbuYZ2apqc7VoSP1Wa3Onejmppe6
         +fVhcDHsnGEkJayegXKICykrV0hkMq7mQLSXug0c3bknRdCft+ILyL4QOog3lXrTk2T3
         CoGmqpunt+10RaMvLZIgQNJNdGHPCj+yaMsHpj79s6ZxxBJVJYSivUkQPeOw8umbj492
         HQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904343; x=1795509143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iGZ2JImQ8AaSp09QdDpLN1PoylGc+Kk+7WphF44IQ4E=;
        b=I7HnZXW5RS/xFTVgdsvXsb2e7M7onMJRYZhse85m4UpdPv13+A6GttpD50cuW18foa
         FeOlhGhOMML0XdnEvKqxZb9U6Ww57CL6NkIkXD3PxnkEP9APeVZsvlK2KwGDFX/ttkNy
         mBG/92PbySdqByTGKP8kDTvHBI3Jiqek8KCIehvW6wR7uzlGXJMTQOIZvrADkb35sIgn
         AlBrP0zrfPoHn4D+DrNz5pwoiIWdEm94h3CFCdW2wKP2Wrv9GnAZEaziOetVA3y28fOg
         f9X89sHkcNLt8QI6vM3E67NZJvNg2s4XXr8p0ZJjQ2PHe7G3uGJtNXrNAdnsTZL6woZQ
         dG4g==
X-Forwarded-Encrypted: i=1; AL+hErG/MZls0LD1gF26AsMG5GCJfMvUAHOeXaJJporQV/QU40f4+W+whyGqinq2POivY17KYuD0hEU5egBNyKA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9KzuCQO6ppEQx+XcPp4huhEUSAHpdFtqVBwfBSfekKOvHUnAc9
	VjtPYccYjytkkc3OqlHLz0cYaxoMkDzjyGNjRDFEmEYaEOuhOqgv/3Ab1J4+5YBqiKOV
X-Gm-Gg: AZFdTZdy/WD4s7p5B3M4jm/o1b0Z4rXVgP6uqMlXqJf1K83OBHROmBAT9Nka6oND+Vj
	NBZ1Erg2qgj1qS/d3xTPdQkrV+bAhqfOJlGYG2vdXmZEWtx7tvDIrx4bqiubYdLvzZI+cFseAw3
	EBNGtMoK8DpRcsrA1/vqkf2WsZlcvqibD5055cHF0NQ9s0aAyh/ty4ypUCjOm3/+dNKO9W5ahrQ
	EZnjAOWzVH3UyTC8EkBM77X1UXzVOtSiBa38ZTwNVK+5pt9CA8YlegyA/28Ng5pY6X3Yg5TWzK4
	uQnFDgVA8vpWdVOZJvpk4aj96WQz73UZkFI6ezrO2/Mt0cmSGB/IWgntItnkG/wJo/S1q73jm7M
	m7au/WCPe6WI6Or6XJa3oUlpQFufzh2CYq/cmWf0gmspGM3dO0EztRxmskRqWQdPKuOCYwgu+Lj
	egkJmklb4zWAVHrit/GIHmLpxWYt8Rx+jpfNdcnVWYSXZYINnyFgSRVlhwwdGniOfC2ggqeuRh6
	kyCQN3X6T/K3hxG2R2IKRGgPd0hIBuGvFmJgm2UqJksVgmzqYjOsbGiyWajYPEXSF3c8j+ELh/y
	iiiWnTwxGryB6RaDhWTLZRDrMRy7K/oeJcvYLu7gR2i9U1Ts54BXZGNcK8tLc+cXjjJ2AzhAWb7
	7ndw98mTPcDAHBfvrcbf2CqWlwf+/KngLmpEcElK87X8GRfR3t/endEfN
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr27089117f8f.45.1794904343236;
        Tue, 17 Nov 2026 00:32:23 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm43646659f8f.44.2026.11.17.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:32:22 -0800 (PST)
Message-ID: <fd39200976086130cc82d59699a988fc3e0689cf.camel@amutable.com>
Subject: Re: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org
Date: Tue, 17 Nov 2026 09:32:20 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/openpromfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
> index fb8d84bdedfb2..6cd02d456bac9 100644
> --- a/fs/openpromfs/inode.c
> +++ b/fs/openpromfs/inode.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/seq_file.h>
> @@ -419,6 +420,7 @@ static const struct fs_context_operations
> openpromfs_context_ops =3D {
> =C2=A0
> =C2=A0static int openpromfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &openpromfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

