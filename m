Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31B606A339
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Jlzf20Cp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRD8x46xzz2y2L;
	Sat, 14 Nov 2026 10:33:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794564175;
	cv=none; b=PwWprJQG8QsQ4jTWczQpvfnMUh+jVCYJPxxEELBRb3ECitl4Zxiu5qRb2y1Ps0l4USkM2rQ1QFWdD7MThp5sFiK6dTrYPBWyu72Oh5EYBkCDj8+5hQ46ERJNLa8sfQqPKYicfhgWsemo9PbyDjoQINrSV1JgI9mKMDwU2gU3Eq6wy9k/C7avPgbF4vyw2gfMWVc99EH0E/L7s8989/ld0eTxSHXXAOBNrsJIEBRb97CpRwhUtNOiecg9TKiHxx+y1IxzEWBiNxci59Fe1lfrE9tJITZchttbgsLiIY5mz8t3oeNhG0WqFFEljHdU1PbKCU3ELjLIn0hCVmHjidmVow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794564175; c=relaxed/relaxed;
	bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GUwJw8Smj2ICmYQLZorIqOFJF9X8PmbVuU/ECMtlD+seZ8+4tyGRdDBkC4SzluktEd/SzkdaxquuRVN8K9V/PxkafJeIUB/jonVzzVGx0V6ze4Bm3ShrleaJTgAu1dFF+1fIwubvE/h0wvksuWKjBLrrEtSjurecXBr8+IQXm2RR83BdIA2OfMOInNw3Ex8ljkZXL9Cwgcx/KzCme7jw4zwgHOKH7PpuskS+2G8tf3JC3thXNJDp/u1lbFAOjeDR9YJpaWBdPX9irg+SxVbNSBfMu8IvGHURS4OUPW0Xakemr9us0wTCknhCdhiiq3QLlSn5AxhE9oqn5Vj/sfyTKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Jlzf20Cp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Jlzf20Cp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQt9V581Gz30MZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:02:54 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so1439711a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564171; x=1795168971; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=Jlzf20CpqdukFljg6Znqq9A4JMmZgp6Tj/WBpnweI9XSbsOy4+FciRY1cOEMPfqLS9
         4+JcpZ+rZHIzchA6t+4rB/67u9Wd98UEG4nI7irMp2x3BqexdB5RmLbQI2AcvicR3Ded
         OZoHRig1/Q5K/47EL6cfal61gxTB3Wkv/LNADqI3XQ1jp2kvLirMjJI/Nx6WICvdoe8u
         +6+qGn+g6S27REZDVk+aicWECsLMXBVMkjUbF5uqJ2VSh1k8Yf2AfYuNTTytCuB7Nmco
         P7drLtr7uY3JljWd1Ch9W4pore7O6XouzlmVqT3yh6H9Dtkybj05ePMcYVBk92Z3N9Uf
         0n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564171; x=1795168971;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=2tIb7BPRcArEhtMp20PgfWmGsV4m1ZO3knhq6amZQq+OHaPaCeATVlauHAkKBTxEec
         Qwj6AwbR6BBmuPp9lO17zyof8Z9MFYZOgLUCK3dHfOwSJd1ZyXQiiNwb1RsOwqq4ZHtM
         eDVqOfs1gn8rke+E04zDZ5st4y5pjsfC8u5O7YYJraQH34gLVymghdLRNDy68gJLPhud
         h+Dc9e+OTu4FhxG/zgPki6h9Jy1z5hZoIzcMGqZT2gP1iSkD7ojj6+44v/Uy1Q7P529X
         vku2CA3lktQsIn75dKg77PK8eIo+2PvxYbyvO401wVwYTyGf9w/d9cu86CFNkP72o5BV
         fVBg==
X-Forwarded-Encrypted: i=1; AL+hErGJQp39dVJK/jA0K3Q8IWfOB3QV7GCBzon6XR11kZHZoskxtqfTJRZVeV5MBl0qHoAAKPc3Wu3pPZG14wc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9BeSDlgvvIQT4mrAZ+fS4X+77Sv/eghNwRGoRwQVGTutLUxMcc
	czsISad5DlOlKM65/eaKSYUoIDomKFzmurHAGFsNX40qvfLKbIVdIZTgS0W545JlH66i
X-Gm-Gg: AYBFou1sZe5aQmbjFAHMpDBTEaGA7JIi+LIt6RhjEXhOVYsj9Tdvr8Q6LEr1psD0Ffu
	pmoHFjRFFWpkLLrgD/2/P736Z37KSZuLoC/9v/L9a5Tz5QX4Wb77HC/PWmq2YlWX1vikQney8PN
	aDIcN2pnaYNk8qpS8Jp2dcSQ2Bpvt3iHaXiLMGrXmfuSY8d02Vw9xrtqsL9eIjCaXkU3iRupRrL
	bawyMi4UmhwuiRRlSk2bqt/kTHzHPSKuZ1gzzF270ZLkeWtAYQ7h9GAmKjs6qozoK255v+KzWHX
	9G6RvlsKFrRiDnYF3PmhRsZKg3iCcs1wP7dm7fjVa+JLefL4/Dd0tfJZAuKLdHMdnf9bCcbwd6L
	G7zuWYvrC+gmwKGhJUyX7CZ480axAdri8J2FE5GOwbbYFJwtewP1mJGtOEplvMaHOrDxnlJZa4Z
	HWJpaIdZ4RCO4q0rmhXdwRCQ+naSWZBqM63cYuhB0MSZnAxOWc1mQOE4HyLT8npMZaNI+JEK89c
	8njLqHGmmsUt9dElAcne4Wwm1K71OQCMkCq/U15jiVdIV/iXUx/n48aBNkvxsEjMxDj/9DWmKFB
	5bh+iFINLL0Lc+viwUn44NaVtgudYlatsGAJNlZ1XmCl8TQQ8bOo442RhDPY50E=
X-Received: by 2002:aa7:c842:0:b0:6b7:82cf:f69f with SMTP id 4fb4d7f45d1cf-6b7c0ceaefemr1298014a12.41.1794564171137;
        Fri, 13 Nov 2026 02:02:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c262338csm739270a12.33.2026.11.13.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:50 -0800 (PST)
Message-ID: <06b194053de4f4b65895248d1f2ba29d42a21b17.camel@amutable.com>
Subject: Re: [PATCH RFC 06/41] proc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:49 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
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
> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> =C2=A0fs/proc/root.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a..ca0e75081934 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/user_namespace.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pid_namespace.h>
> =C2=A0#include <linux/fs_parser.h>
> @@ -265,8 +266,6 @@ static int proc_fill_super(struct super_block *s,
> struct fs_context *fc)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	/* User space would break if executables or devices appear
> on proc */
> -	s->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> =C2=A0	s->s_blocksize =3D 1024;
> =C2=A0	s->s_blocksize_bits =3D 10;
> @@ -350,6 +349,7 @@ static int proc_init_fs_context(struct fs_context
> *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &proc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

