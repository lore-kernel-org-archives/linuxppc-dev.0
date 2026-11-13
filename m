Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8919606A330
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b1+NJ9jl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDCR4hK1z3bRp;
	Sat, 14 Nov 2026 10:35:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564962;
	cv=none; b=VmW5nq8Wc/PYtsTGH+WBf0keSfVmTLCwrGxBRQFFByX/QnuxRG6ml+ybU3y/UfH9V25IrwfsOD483Fuy7ktTf2qzMBthGV2ydoaEx7nFf04OnBifTP2yPKbuzCNDYE7WiDr2IeSNb3lajeg8L9cb6fBPtJcHgc15V5yNf321dkkvYokluwMm7ME3ylbdNB5ZALr51ohXXzOjazC1jjKjTdKfbPJZZx0e3xXmIbpwTQxJLzYRwmp1Cn9x21OJa4ulg9/z5ZQDd6nK/YCSQy975jnHqSN4HjihVY22Rx+rUUszeE9ZMxquUhttJN2xqQGKUL/hSxxz8sIGaW0hdxABRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564962; c=relaxed/relaxed;
	bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUZvcDfUx1p8y6BAfdbjcN/BBMNgg0Rbm+OElXvoPflbLMobqOGbWUtPUgVeetaaMjuKSfNfmXKF5Y6sLWH34fbuGMDfxdxEXmVr6jsR42DAgXmPO/UMWmNZ8j3pYPLkW5X6CvD5Vq6vdav9b+tHq/ct8cYrh/nDMsafDx1tpJj/ThsLZJo236pJ4pxFI/nDukFEPXVLkVQLePAppp1AGne+ouGxNKHJgDBpmtzcmemlkyQ85FCqRLLCkwJoL+1eLBoNFOKLmUIOC1Bg4R6glrHWL3+1HX5FyqsTaQv8pv2LGXLRqZrXIhMgrrxCJqwM43wzOEzddmKsmqmtQk307w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b1+NJ9jl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b1+NJ9jl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQtSd6SqCz3bbx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:16:01 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso156034566b.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564958; x=1795169758; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=b1+NJ9jlK9LpXcHE7bPhZJ1+TArHsVfU2ajFIan1yEmVePh3mRw3s35t9co0oc5LeI
         ZkEq6d+N+ovACa8azhbS7uInYpusPCL98XCgcVy5aI6Q61hmOf/A4VeJXxHmNd0xWq78
         2bZRtU/+x9rKdStm2bBtNRxawc+7xxr3jzoHh5Gy+b9ea5SSgifAKEyBTFO69ZwAwb1B
         sizb1xwy/qkF7+Ma0uQp9XXlrbvMO/mg6vp0JgWno0qXS6BzJJLUOix5dfyyTCWes0se
         Vfgxhg2rQnBLuzbHqe3kZU8RS/NdhQd8WSCxuECVOsoXV4kLJrSz6rjoPGVldWCoIDBL
         bF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564958; x=1795169758;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfCz/38ILdxPmJBY1NDzDaIsiECcLTMyKpoKPJStEV0=;
        b=vtBf16MdgglkHHQ5fXJSvuLH/tHOD/XleNl+F+Xt7VMSTvpWitPZjxBZsFK7w2pacq
         N4cUveCRkauXdeYvcCsuKfliO+/3B8gswQjGVv+48lQqRJS06HGn5RPMVkgvueojPyBo
         0jAtirFKVjsAoq1gRzEePInGMPN0lflE5P6gqYJCmE/R4EGEVe76hdIzFhdHJ/0IjyeP
         XNTePEa4xOiRNpmzW2Y+G9nydfm1UzFXQMkAW8v6AP7p2IMscAo5ImaD+2JLvwc7hgze
         H+y/r+sB8/Yge2pmClY1WG4PfFQaqrlC/d+aiHFZSrw4BJ6fvNmlGLFvWDKaPZXOp+WP
         CfwQ==
X-Forwarded-Encrypted: i=1; AL+hErHbVDiTM8dR5cdRpPygA4OJa2g0tIjh3ZNgFviK98tm/NjYK5haEzUcJBnTE6HRZD0dxkFoIRqb0/kXJWk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z90PQjnwzEGWjlERRY1JPsCmrMgKRUFOPejhs6mu08YP+bTArbk
	UiE2ctnThhAvNSlvbYz8TlhHo/hqVoEbYKYzUns9D8gUDoNkC5kod89fqoPgVTc2NANd
X-Gm-Gg: AYBFou16y6X8wTD7n7X+TDHEljq+679bSAPj1GKIZI/ZnJ2pK0Rpc5n/ZSJJeZW4Zla
	MdrvYBHIn4ULHIIPJinWUosI0YUD2ia8TzCNRA/nx5wBVBEcaupe0Wt2JpS3S7Gsfk2y8QYoUA5
	vM0oXpTmE726fH02wEXGnWW5IJJ4ZxMerkpejIEI0wb+hpNtLChFC/kiyoudWiR6tFrZVSFr1sY
	UBsvPIOBy3spRWxU+kZ8GYkdDNc8eUz9BB1iRZMRvaS6RXy/cvKgcVrZoJeMs+SEuYE2eR/5NA2
	MJwyZ4ro3UOT7KcrNV1RoS7i6u37dioXxmehOaZm2nRcC/XSzgcXQKwAzRpPrb6kLXKFA1XzIlY
	RIJGm/rtZ4embKxlbQ1c1I61SY4K/0+B8qX9XRXoy/9DorXmYrRysGoHoO0NnY52KbiRMLzL0LD
	nTXTSz4hzGfz27fCyHsQo9szk5zBWlNtst1cK4THlfUupfX91MzMbY51gKbWk/jBfq8Z3P0u62j
	GJQtIuqhzz6gpqe9WzdGlSRKVjJLZyRSRFcXcBcExBW/McYKziKkxX1Ue/k61yckO+Um0yNqNFs
	FuWfKMPP4muqltgfuUr3Tt3UWV9ph9hfsKWh/TlxsTvOaJUDEUeGLZR/I1fu3AI=
X-Received: by 2002:a17:906:f59c:b0:c42:102f:15f0 with SMTP id a640c23a62f3a-c509614d4c1mr171873666b.3.1794564958075;
        Fri, 13 Nov 2026 02:15:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7d1b7sm75606066b.74.2026.11.13.02.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:15:57 -0800 (PST)
Message-ID: <c5a694991af7e9182fd475a20bf4cfd73a13e395.camel@amutable.com>
Subject: Re: [PATCH RFC 34/41] loop: refuse files on pseudo filesystems as
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
Date: Fri, 13 Nov 2026 11:15:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-34-4c998976c6c7@kernel.org>
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
> Currently loop accepts any regular file that implements ->read_iter()
> as
> a backing file and any that also implements ->write_iter() as a
> writable
> one. That includes files on procfs, sysfs and other pseudo
> filesystems.
> For example, /proc/kcore attaches read-only as a loop device the size
> of
> the kernel's virtual address space, 64 PiB with 5-level paging. sysfs
> attributes attach read-write as 4096 byte loop devices. Writing a
> block
> to the loop device of /sys/kernel/mm/transparent_hugepage/enabled
> changes the THP setting.
>=20
> That's not just nonsensical, it can be abused. Loop calls -
> >read_iter()
> and ->write_iter() of the backing file directly from its worker which
> runs with kernel credentials. But pseudo files enforce part of their
> access rules at read and write time against current. Dozens of sysfs
> ->show() and ->store() methods call capable(). Behind a loop device
> all
> of these checks are done against the loop worker instead of the task
> that opened the file. And setting up a loop device requires no
> capabilities, only access to the device nodes. So on v7.4-rc1:
>=20
> - uid 0 without any capabilities can't write to
> /sys/kernel/reboot/mode
> =C2=A0 as mode_store() requires CAP_SYS_BOOT. Writing "warm" through a
> loop
> =C2=A0 device works.
>=20
> - uid 0 without any capabilities can't read the files in
> =C2=A0 /sys/firmware/dmi/entries/*/ as dmi_sysfs_attr_show() requires
> =C2=A0 CAP_SYS_ADMIN. Reading them through a loop device works.
>=20
> - An unprivileged container that was handed a loop device can't
> change
> =C2=A0 gro_flush_timeout of its own network devices as
> =C2=A0 gro_flush_timeout_store() requires CAP_NET_ADMIN in the initial
> user
> =C2=A0 namespace. Writing it through a loop device works.
>=20
> The same goes for hard_offline_page, the md and sd attributes, rfkill
> and others.
>=20
> Refuse files on pseudo filesystems as loop backing files. Note that
> file_is_pseudo() looks through overlayfs so stacking overlayfs on top
> of
> sysfs doesn't get around this.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index c96e35c3ef42..1482580a1979 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -537,6 +537,9 @@ static int loop_check_backing_file(struct file
> *file)
> =C2=A0	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (file_is_pseudo(file))
> +		return -EINVAL;
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

