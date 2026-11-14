Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEFA606A331
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rT4coWWq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRqq44b74z3cNc;
	Sun, 15 Nov 2026 10:20:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794698416;
	cv=pass; b=fLAximjJBSmfX9TRwIdgyYMshP7u3JOKZbkBB3Zj7Tc7k8rzezNyKnHjGUOvthAD3qE9OkyprwkJ3q+EFvbzQMjKZplGIVboh+QkdoztLfs7FayHHgA51wcnhl7Mw1gI/Cnns4S9xC9Nqz4PEObYriHM47Zf9idodsMYETNO11v3P+w1vf8M0M56tHomBA5b7rRenK3jQ9rta/iLls8MFky5gAzCO6p7gYLuUYqd9Zumvz34jisdtUFJB6hIe+DOeYH0lmiSH4vV427LcvBycSN/Pw2MI9wz3mIfc8aWkCrR+fGSjZ0iEPBegc+dH6PtfKpI9XaLY2vZOCzZIYfvlw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794698416; c=relaxed/relaxed;
	bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaNt45ZhtrV/hx2gUDHqPHfxG5FZ3KENxXtuP3rOnYaj0ExAZzsdqS4unZwcPTcyE9+sgRZlH+A7hutvqpHwd2Mxlw6wcXLsy6/9Ce7XmN3YAdvS+yb7UpwlOsp3JNQriU1u1mU5mizVqiFjed5b+S/BtPXPrQYlxVHtkwnDESaYpWjgmJX7Qhl/z1FN6X+gao+iHmsjz2uoU2Gkau+d4KkxLEUY30/8Khr/mpIzGtxw2f6rRpBWuqeAAEja1F/nTUROW6X7wcpl/gdd4BseBx0F1zm5+m2ElyUugkS6GoLcAeRAnJ1QDkP5V0g/jfgiYMU0AyBK5Q0gKpC80WUfSA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rT4coWWq; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rT4coWWq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRqq245ftz3cB1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 10:20:13 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so4611877a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 15:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=IffQ6r9MvZeBmd8LHBKZF7+QM/ZJr/sKavCHIfBZqYxy7BH+/KeEDd8xomqsWvjmC8
         1DJo7vsBu2RX7XoV6foWhF5uIWGz8q6zlzQbAd9UgWH/+cLwkOeC9WwmyIQZUiT/SE42
         JEx3GwSWOb1frZcnbFqqUcJXE4kq+lQITPKaB7VWNZIf/hhxhAMC9hklzCX/UwDbfsWL
         8QBL9e5azSbx1fvcVsYq3ZFMgqWlDxUhyn0XzFsXQQroYWDyviryOZRMIZKXwDGweX5r
         J9pmIWMqKg+2OB/FnPILIdV2YyNr/2sWGcOMSVDIxAyMzzo5vZ2PwCvNKv+k/XTvgJaJ
         potQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=+23bWUk6T6Z8fqmMUWggi9fVRW+QC0Rddjdmf4pmyLU=;
        b=OCQxSS2Se5MEJ2q9q6kmCWGtuSIS632MH3h2GJ3N2+m/qKniZf+Fbm4yE2mKwKTL56
         YP2dYR/8fcQDgwAIwx9VALJwnBLRIOSc6B6o8K+PBhIAMI9TWwU5GwVXd019HnGogkvG
         nX5QktZcLrxvVnL/zdEs3gSAiMffsAKe61x40KD8nUH7y3DuB+b+FzzvXYXG7SpEf1iY
         RkGE8LpRAuugHwVlZCqRzLRSMiVrqTjKs9j6F5bzuyG4mGH4Ks/KL2MdujvEQE84kUjo
         NVF96UIbFKE5pE+WpCMOCKCLsYc7TS7gxR/uaGa2ASomnGl56XZ3y23rRYJ1H6P4pS+1
         tVcg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=rT4coWWq34O3z+FRdCatQtGsOhe0d02arptSLGaaPmXJC9uQ+mg6AKFMSzG+u/XUCt
         cGxumwzGx5LwnFTkD2kemPmr82dqQrZvKC0ynNgt0x87PTzRW6D4YzY7tF517mL/WybW
         hzXJl7QiEqjSSJwMLhtqpRF1gbjGzMdgVJ8Ay8gxjVlx2Qn5+CZadMgZTkhH38s/SLnf
         QwZBFLnR18n6XZJ+1sJsD0VETHhfvS74xdSGrZhliHAGWGCCVPSYEtgHVrU0LBs/u8Ya
         XPQZxgKVHoJSpn+KVUEj2YRj8QYuRheF0OusgSAYYi6ZRYc/r7wCuGCKcc3vBvreMqPt
         qN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=Q6tqOfcg5q3Ly7Hu+IC79XZ0LiU8aZ+7w2NPkADVk7WLOQjvofSAXgZ9Z4NpiJJIQJ
         /eCSZQWSYcPcg7Sa0A27bCwEQsrni9fJTC3G4RseLikbvw0mCVmCGAUAHI3sq+3WWCFw
         ehczXZZ0GDxfE10+izKR3Cu7gwLEVb6pou118j5nhN0WRC9MyEh7uH/06q/wdKhpuz5V
         fvha+QOD4FHrJdr62z2THaIeURcSwg0tgy50HUvmg9tASYcRs7bL+FODbJbLXuoTQxKN
         lWkOuDvi7N+SOF9KbG/hPscBkPjq1uZ5HEq9MhnjQM38lxgPfcWtqjZqQK8c/ke/ZvFG
         5odw==
X-Forwarded-Encrypted: i=1; AL+hErF1g1BhZSvMhDGT7XiiZQSw+ssWbJ2Udqt7aaaDGninp+cdfXkbq1I+N63shLamSuJCXG0HEioFvNEnuHs=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+C29BhSC4mZr0ragMJSO410mLnKR0J2g8tWN+yN0JTxrCrE8YV
	cvoZbg/bOnQvH+03Bul6OUEMNH04nP89LsH6r8vhfm6cPz8z0fABcMUJjZaFp+sPMRA8fqcVHZJ
	HrK8/HdrmFLEi0SxaEF50RQzKr0wfqaQ=
X-Gm-Gg: AYBFou0pLewJ2/e13mVpQzoaqSGMf8Weg9/uHONVj9ydOCkmjkT41eIYWYBuQPqauSP
	gM6UmPzJ+ODGi38M2POzQFMIm0ilXpqUzZoTdvCygaKxhZzmEioRda9LFDhrKc0co/Va+GLphfO
	1OF2qteXnHW0/PKk6t98p1BSKcqgu4k2EMdne0yY0KF0yUKdz2M+cjzZwBxtndxHAzI37ZYKfIq
	AVr4V1q5GOQ6JMEwxoeQE2AN1i8VAnomfRSph3Nw/BKW8JCnlC5Pd2Q/6cyZExlTllkHz0VJYOD
	BvS7Q6PsExwtwY+s+bIJtr2lrTDyGD0LWSBpJ1kzWkXnnFd3x9IitdcESEWBQmYvhPzHPQiFf7O
	pTyFk9W8HI6F1Gh9Sgm22l7SPtwHCh3O/V07AlyohsLBotMIEyE641R/QWU+zKkBkojQaLA==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
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
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.

