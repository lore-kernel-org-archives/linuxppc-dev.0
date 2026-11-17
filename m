Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB4606A8AC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kNjLRT3/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTHqZ5j7Cz2xcB;
	Tue, 17 Nov 2026 19:25:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794903946;
	cv=none; b=fS/BbVhjF/+M53gi/dXmHx6U0udMPlAeqvlKvdMovQTJdLPRMOeqh8iEJHhDKgevmR+IohyLpmgt8g4GA48VwI9HPgiPMFm0KLOwwErzTNeZvilO0+Soj3QSaqSOCguafdtbaV96/gmybs5ep18gfHKTbdziPEBt/xtSCTfJKITAX5LUQaIpWjtoOj8yFf7PDBOl0rwnVeb3v7rj5WTW4+yoSg5Sz1r4GIUIstsVNnvERaJ7Zx4Djwigf2ffPt2Nxgh2lKsR5p/KL1RMRMTtzwk9y+aYYg+58cGQukt1XcAv6IWZFdggTCWbM50XQ1ESbl48qTKV+Qayi+oyHYPq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794903946; c=relaxed/relaxed;
	bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaLuNEe/uhwANvMhxcZHtfkKtbKf6zQouYl8O1Mh5VbCi734f2+5dJ1ac4VWpICy3TEuDr8x8Z5pm6uI7W6KOtovdBa+qbyCQJphmp2zKkR6aIBv8KfoMPXBkE/db2WBj7z6oAdy1gEG+A0yRj8vcX2f5+NSoxSiEYiCrV/3uZAN6ilcutOY6MPGLzp1pW8rFwXj6mqgCkl4wKBLvWccyQJHrxDtyhOcrF3HaG4xznk1lG0N9u3z821Cj5J59S/fKfHSPyVLLXCLndtRum75HJX39YUkUqiosisWB7gxCaajGOjJUQcoxlS6/3yzLFVzw0/uFu0tQdqppqvbk98yEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kNjLRT3/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kNjLRT3/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTHqY6WYZz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:25:45 +1100 (AEDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-491d1f66968so668438f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794903942; x=1795508742; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=kNjLRT3/W6p8DyBVnG1JwFNrftGBG5CiGfRtobrMoVQ2KTxwJe5AsPr+4VzNW5/cyo
         2AuQO1Ccqfvg53v4BZmuu8tetxFehR225Fm7e4F3dxgzFKrnS6qtuA38hteR0HHehQoy
         1EuEg7cYRTW3nJ8G9qp5IrNxmzAqMqnVJDOi+YsyrgtwwNt3F94VKxNox3f4EdWwHAw6
         Dn/EZ5Av1RLxEYz1bvzLPcIPiI1XyecOz05SOa/H08eEU2UILssSisQVck3G6JX5VJVT
         uGaJJzR3BqOZ3zG7qkxZduEgcVEuxDD02c9pswgV6NOsHuw/Q0XXG5YJtXoN4/hAGRC8
         yIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903942; x=1795508742;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGlayfD5Z/El6cdpm6ie0HDMH84kD107OWGXScU9uXE=;
        b=biqdYZFYY1ZNLL8JD19qV/USfXwTbG9bUcZ7a1Q87kpLRn3VpLfum1pkv6po/82gnb
         GSC1vMlx39ZH6PH/tW1/y5/NAAxqZysx1uOlMlx1CS3dwMWr7Euismbud1UKGTOCThOP
         RNLtht9OZ+wXP/EBBKMIuuqCNdnzNaK4lGS7BPYOijd06tkrB6SOaWkx9mpNVkCARnXj
         bpmc0ZqtLTypv7JBWKsmgv650t0D+Hpmyl3G5eROlTkEGo9L4b7bPY/jHKfUeuMB/YFG
         qlqTW9ZJyxNRoUZnc/WMmSixxjOnXyvVXeAcoM09YelX+cdtY63La4Png6kKz8ZGQ3Iy
         14Jg==
X-Forwarded-Encrypted: i=1; AL+hErHekz/3hDpYtQjzv4qFtNJUopUbIShIeX9dxdWop6gaRD2X5nvXZWdeQspfN2qC6saNKtKVjEsyh5qAYgQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/mOE5GvYay6zjLAePTTDHnLG/b2K9CxEhKzULL6C7XFKuStZe3
	BJkJW/ecvgiBR0lV0tJBg+1PptBu6my7GVuQ00OaSbbm1GabFkV4AAfxI+zh0cC19Cr4
X-Gm-Gg: AZFdTZcjnL1wB1Ko1bEAUQ5IiRdzpF3Zj9ZJ53j1ENdYE0b2naC2t7AYGvyNQUwo3cc
	4lWuel9t3sCCgk5A+7fhn7GwvnzRAf0+egm8UOeW4Zv6TGSzo1lrBDS+O3ywbp3IjFJHP4a97GV
	pqGs0AYwyZtHiY3cGKKS5reOpNDd1g+Xnzo1Cp73iV4O4N98ntWi11pNifmy7Zd7hCfX8asj5+N
	SJwHHZKnExQ0QwEBigL8Jh43JSneS1KBGDUeCfgA5RHf7cMbPkgtPOYcPelritkTXshv4R5+PCg
	tPK89ekCw1KIbnIC1WzCpvnwYq69EFYyHEWlobxnDVA/8gLUe8V09RsRKwSwkatQdFu/qUkLUG4
	Y+wHrDyDpwPc+AOFmSeaLi5AvUlgYmeCQk1UtKCopaFI1COEKixmWgRRbNkE2djb+G/ksd/l6lI
	Wbbhxd1JQlYPaf6t3ZzPc7R6BID7c75/0De0j/Lf3YO4bOTXc2aNgCIVzu0E0N/z3+crezaRPI9
	AHf6HGS1jgFmskjZbWyIunleWCnLtKN24NZYjcITiMrawLOE2T+AaNnYVvv5+V1MrzwiVB83nkN
	lFeN3/DKo5fNYyMdUIiV+pK07/wwaw8qf43DWtS9yH6QARkdh0MXZty8OZyaidcT8VwJQbSL2j0
	u4LX/09wICGU/vFw3Y7JEApd2qobBaLVN5PJ4kGIT9lb4xqkq+fw9omfudZ98Wyl8ksnLrJRU45
	xWjA==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr25238543f8f.13.1794903938925;
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm26907832f8f.28.2026.11.17.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:25:38 -0800 (PST)
Message-ID: <a9124bf1c858cef3e8ac06b1b2396dcb0e19e2a5.camel@amutable.com>
Subject: Re: [PATCH RFC v3 02/44] nvmet: check that the file backend
 supports ->{read,write}_iter
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
Date: Tue, 17 Nov 2026 09:25:36 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-2-8cbbea1cf34f@kernel.org>
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
> The file backend calls ->read_iter() and ->write_iter() of the
> backing
> file directly but never checks that they exist. Everything that isn't
> a
> block device ends up in the file backend. So a namespace pointing to
> a
> file without them calls a NULL pointer on its first I/O. Only
> buffered_io=3D1 gets that far as the O_DIRECT open fails for such
> files.
>=20
> Refuse them when the namespace is enabled the same way zloop does
> since
> commit 0c10f8a1a7ae ("zloop: check that the zone backing file support
> ->{read,write}_iter").
>=20
> Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0drivers/nvme/target/io-cmd-file.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/nvme/target/io-cmd-file.c
> b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932ee..dfa8aa46188c8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -47,6 +47,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> +	if (!ns->file->f_op->read_iter || !ns->file->f_op-
> >write_iter) {
> +		ret =3D -EINVAL;
> +		goto err;
> +	}
> +
> =C2=A0	nvmet_file_ns_revalidate(ns);
> =C2=A0
> =C2=A0	/*

