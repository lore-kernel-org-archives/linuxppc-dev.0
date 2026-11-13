Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A57C606A886
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ULl2vP3W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDCs0cJLz3cYq;
	Sat, 14 Nov 2026 10:36:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794565650;
	cv=none; b=iTf5AxJ2DBfZAlxUPcP4TiUBIuEo+fwVRDdRLYocKgj8zSYK26fZZIUogJmAlr8fNiKvIx67DoUhDW5ufd3iZu7cAWYNgyFjdDqxslqcqF4HhJwTgdxVm6wJi2WanxZXKgAm/ud8DBj3+5GTxRB0E4vHPfpKyS6kfQ0JZUE8H04HFcocLDpKrt8alur/qL8NV2SPWnWCjCEVIMjvQwaIr4vWROaCrivsiz8T0XBHvT+lKU0WhZTS3qxnNP8HKVYI7I4s5vClkrlW7DR+8k36T4DUmHkO0Mqjt1zinOai5pJnDxWPF27IyGvNxVMnJ3CijQWaJrnk0bGv+EeXkcYa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794565650; c=relaxed/relaxed;
	bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hQfbU0hdVA3QMIpzcLQZOYHNGDZ18FJir2dVAk44Cs7dKb4zKXiRD7LaqRPHTgMxlmlbSG/PCmLmq+9hlx3bPlX7xUosoPomUWWTteqRBXGQXx81cwmKHcbpTovzavI7cgjsNnZ2xnHUfbz2Ih5Hq9bML0TU2VkKP+V/dn97AxJUkc1NniN6Dp/DHqQwt/DXTBgktM5Ldj+jq6gzoBz6IMQzyA38PiRp5p3C4az1CQdonT0zAlqmFNpGd4iWNm8UjIHBzXFEIiQnKAAQoF+rMiguxS8tzkKATfYhkQ+AswVvkVVQDNMwNr++poJBCS6ov5ePkiPwoFP0h2pxpy6hvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ULl2vP3W; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ULl2vP3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtjs6M8rz3bfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:27:29 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so11937865e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565647; x=1795170447; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=ULl2vP3W4S/nr8wZZgiGmz5dHbT4r1Qh4yUUUpZvc4UfpYG04yJ3jztTQvI7zeBl8a
         tAZjPYqSpUhgbapZdwCxVkavMzdnmyIwBtNjmc1E4g1EgpLJYQt3jxwr0DcjiVYUrQ44
         6xPFXcW+MStA54THMAPotZ6t64dvU3xMCKM/U0tu1tHHsi+ozKJSShYBnGbdwyTJ9Cvb
         z695RRSgCg2ga+5Fw5LfOr/cC4zHO1ppUAQyTEkH01OQqYKkVfGU13MkGjziX/dfYO1G
         uGQRzxgbli24edX/I6Abqg5s8Vlr33YWiWaJTO1VHMSLsUS6z16C/WwMWXT5RfuZCmoO
         pufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565647; x=1795170447;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TXY31nY7nMCHyiOZTp7Dn0JSWYPda+tFg8CPAdTq7II=;
        b=BmgR/+JvXY1sKHT8gfp4AdoW5InWPaUSVxiKRYXzYRAgyaIgqahfMQQregKKU/Bwca
         yEyz6gHQ8vGSNUA9Pfc8Q4A7q5g+0T9mW1OOQAvQTBxn1Y81+1beo+Fv/cqiUowxHx5m
         vdj8GWpOOSW+6XluIjunvWR67BAtJElOQ0a3yfbb0wXLq/b3J+VYIVaqiGMQmhehGYhh
         l9n6nwiD7PVYRmyDTNQXr9jbVfSdq9rGyNIKG//Ys/VmMmKbSto6GTjpLo7q6clx210J
         d4iRTYOjLCEoaZUB2Rq2No+wQ9sQfRC4/e2//DOZwogPAqqvE892Kw6zuFDu8A4cdllR
         iUlw==
X-Forwarded-Encrypted: i=1; AL+hErFGYnt6PMOd3RlQG6nLRsJG1NovXNQxcl3Ggn3PUKeeYmLxiyJyDiISQfZJQ4+GmORss5M66+YzjVPMdEc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/7Q/f9YUb3+Iru7oSS/kVCFxqzWNwsLa+o6WYQ/UqXHP53+x1P
	JtT4BVjzE+z2rORal6v1pBolzIr07EmJSnilTkodlE7XSBZY5b9aRca6+eghcGLeESZN
X-Gm-Gg: AYBFou060QGGSr2TcvDLO3hseM+okZE5kEldJO0Wk0UeDYzGr5EukN+L9shUw82KPUI
	OEde6Muw50pyRxxGXPXLpRM0Qp8cB9/K585VarTCkVkSXOKdE5ogQnOlv8dCmhFf3eYRICIa5cu
	0xG41tx+cMmKz0xU8cXtB+49FEqufA70u5WD/QkxGZKyXb47N0D4aE60z1kl/YHXiDNMI/aAVQH
	eFRzi+ZUfwZ6cKh0yu7QLF1SZKtSaHEFDcAkO0SAEYL/LJPjeYq7peAcx2ha8B/jiGfAMrSw3kA
	6iqMyFWQ8ooq5eX86MnSfqzE3G3sMgF1hVkFCaZSnJ8CREuDVzyHMmSwiGi4gBIP+idQPNHz9OH
	3ccoUwpOVbpHX005Sghdg4K/AZzKXWvuIrSIjujxKn58NSdCYVqfVRl7A10DhD1+uGWQi30Qjf3
	6QMjw5FUJpwjcnoLTKESyunPCCMqNUGksHgv+oI4mTSY38SANSHTOeClkvDifeCew7w7qC748UT
	BUim459RJBhQ6TmcPA0kScS+/zeTn06uTYQboeCEF9iaYhr/k1EqmNCrmzVbahoUQnfXndDe8R3
	ZBOTWCCtpz9QrK9lF/5xQ+Kl5w1v+RbpA4nmPHj1wKsgO7s5JliauLhdZ0vyln0=
X-Received: by 2002:a05:6000:4707:b0:498:c419:3728 with SMTP id ffacd0b85a97d-49c713ae367mr4463557f8f.22.1794565646661;
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm5077482f8f.0.2026.11.13.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:27:26 -0800 (PST)
Message-ID: <0c109a58804a2d782e549af6ad13e89532d9f9d2.camel@amutable.com>
Subject: Re: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
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
Date: Fri, 13 Nov 2026 11:27:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> File-backed mounts take any regular file as the image and the same
> goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the
> mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/erofs/super.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index ce05557bd998..980d5fc2b576 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -158,7 +158,8 @@ static int erofs_init_device(struct erofs_buf
> *buf, struct super_block *sb,
> =C2=A0		if (!erofs_is_fileio_mode(sbi)) {
> =C2=A0			dif->dax_dev =3D
> fs_dax_get_by_bdev(file_bdev(file),
> =C2=A0					&dif->dax_part_off, NULL,
> NULL);
> -		} else if (!S_ISREG(file_inode(file)->i_mode)) {
> +		} else if (!S_ISREG(file_inode(file)->i_mode) ||
> +			=C2=A0=C2=A0 file_is_pseudo(file)) {
> =C2=A0			fput(file);
> =C2=A0			return -EINVAL;
> =C2=A0		}
> @@ -835,6 +836,9 @@ static int erofs_file_get_tree(struct fs_context
> *fc)
> =C2=A0{
> =C2=A0	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> =C2=A0
> +	if (file_is_pseudo(sbi->dif0.file))
> +		return invalfc(fc, "source is on a pseudo
> filesystem");
> +
> =C2=A0	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
> =C2=A0		return get_tree_nodev(fc, erofs_fc_fill_super);
> =C2=A0

