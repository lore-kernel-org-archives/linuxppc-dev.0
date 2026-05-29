Return-Path: <linuxppc-dev+bounces-21744-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D548CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 15:39:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRnbm5VH2z2yQH;
	Sat, 30 May 2026 01:39:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::433" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780069188;
	cv=pass; b=NgwF+J0X11IKnVKNNeG8v6BhG3/FgzID+iDQWccmWKZoDHWv4x8gBHuZ4BBmp47XoBoyCn3JGpr85UBJ48cLA4BnpZHb4xfEPdasXtC8DF8jd9XE0vz5ozvL3m4aocTKd29mmHWwM+es5rRabfO2TLitKVOEQ9VRqwty+cw0d8FLGE4wuiZefezDe9EZhg7OC8g9+yGbIKayCE7/4aQfjwWcgw8H0V/Xuq4H0Qs5ObQj6wszqjzatZpW2p1tVLwTzu6PmWAkTIzrciTwFfJFZL0n/WIQVpm4L50rFK+zO3HU/2UH9yrBzWlBDMrOVLfTVX/9K2hWpaLL7I83DTD6sg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780069188; c=relaxed/relaxed;
	bh=nIb/GwmU+y0EhXCbTieEdrNbvIsxoSpd8dmJJmG5Lk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOD3azlZVq9LP1R7zk4yALLSkYo+EX+mK50hqXb9gT3Semx+XJBcsF83aiWkhzxsOIBZAdgqWlzZuzPlld3qVg+qD/MOVaGAH4KtJB3XG9xM6Cotf312cOXoHRnQSm44z7rVgX8d1c+ipZC2h3z0fX5A7h5N2rKQ1wszshNHIK5LAQ8QTpkTkawkhvzWM6+w9zbvuPTS1qbrSZ8OyG+8CKwfPJY4VVjQiID9VMQoLG0FgaxkSx0zAkbaK5iqc8c9c/BtEc1/E4e+Zfhn6qLboSZliAO0HUY+CWKDByQwmYiiY6CcwU1kCMOQpggOMK6jI/dAgjQd5UxDTibmZ6kl3A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TNVJ3Xbb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=TNVJ3Xbb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRnbl30Lhz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 01:39:46 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so6329491b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 08:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780069184; cv=none;
        d=google.com; s=arc-20240605;
        b=gyZ0NUO8Dli9SYNX72qcq48Bj7bXd+bF72KO/7BxavjwpQ5tqKuY8Eq1/F+ff0idOx
         yXYs/1XpT1CeU9BFsZaMyzy2x9hRKIKoAnon4kcImlosrTxt7lMuz+LUO9YdGsgBaLqH
         GiOrQjoRv9fC9UjZPd7h3wpQMYtp1ejBkyXZ2J2MM1Utbc7WvvGQ3zsKRVBcMoXrA/YF
         gR5cMW21EjAuJKVxXT9XqULHvVI7HZovT4blnNysdE7VKVciv8q6A/2oA2CyZKgnWcfG
         P3uM53yMSCcVilFG+phL77Xmi77IdgLU/fA8G8vrxaWW+4DqT4uftuJeIewZu3ehYsjX
         Rz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nIb/GwmU+y0EhXCbTieEdrNbvIsxoSpd8dmJJmG5Lk4=;
        fh=tg2eu4sC2dn2doTr9wP28AT4XYYCmwjpES9rVPy3lPU=;
        b=T/LYrYZBmrpATvqh3PjLK9ZPqS4FjN9K+3tIAqF4yEI9rQQ3MKyttZ5HF/Pno+qrdB
         V1hhiA2KMh4PIHuQ+SV8HskLI1woyOQXjn7GfYXPtUBEILTfuMZILFRkWWQcNJYqEtdw
         6JJOJnBfDKyWfmJQob9ZaPP6JawBvI3W1Kjr0o74vw3JMRsZbN5P1hIZs6/LbsOV6Q+Z
         5OcxtMCAP+/qGaeyo5RBzBHkzOi8cbkwR0CLKz5V6lB39jjq8YI5zmvQjGvFy21OzbPH
         lWzQ2Gv8rlBclrVcFTlESreHT9yk1o9Qdu1IDx6NCHoDFDTfoWEZJqQ5971rkIqRrC7E
         ASyQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780069184; x=1780673984; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIb/GwmU+y0EhXCbTieEdrNbvIsxoSpd8dmJJmG5Lk4=;
        b=TNVJ3XbbTnMWsk40V6gCeFBMNjFtoG9kcpkPSxtEfDS0T4xuUHJMR2VN5NzlhwZd49
         AGj4yeEfRwsS7dVRjyGDYn3ouISgbK9ulJyGtO8V/ymQKCXXtyLCz2Z8CBL3zzXpEnRW
         MoPicR7Px6pWXCt4VxlB62ijuSz57e6gcKXNJ9U0JOfyIiSjjcT4D2CLpwTK6e60ZBya
         rVUPv9RodrqA+kXIGaFWxxnN3uEf4jCZ7pRIac9k/NAmNCls1GGfab37RiKjudHi1chh
         /Kqm2GvNOTxjWJjw2XW4MX8Iz2iqEWBVvAjDxUHQ07nuhYa+kg1A3ZAADMA9BUKVwQY1
         wRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780069184; x=1780673984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIb/GwmU+y0EhXCbTieEdrNbvIsxoSpd8dmJJmG5Lk4=;
        b=eyPgHYT477YDNCccXmT67FbWCtXMaBdUO1yvXdHgzJ2CubfR9LhBhJL6H+6SaUOr31
         4hDDDJCMAGHlVj0fv2VR55e7Asyb3Qc9r4rwsblQP0hdtPVF3BIX7drng8wrBWqBU/N4
         Ggx4weF1YPSMRwxl4aq71/5MyyXd1NuQO9mLqrfCJTymnTMOIWkRoC8hTy0ukXe6WrzG
         Na5r92uum7pO02KrA2jPhHwFLuKa42mk7Mhqd555Ubc2qmB1HPVjRAu5drcv2WuCoR8o
         LGiQ5B+o62CjL41tHNCi9PucE9AksklhXbp2MypHm0o69IGRfl5XK3Va9EUgs1K41dk7
         5xug==
X-Forwarded-Encrypted: i=1; AFNElJ/3snUTF9iRzOCCt4RfitngVs5hcvna/kTFLOC3IpbgDTwcbHxTZmmTzP8M0XijX78yVPzVrKawQLwanSQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxDFrbCo73Dm6lJbFUBtoKRZfvKuCgs7rm09D7c2tgm1RoxEPXn
	RqukmYRlTS3pHyNHfl4uI/+wKe6iWN27SVmjMsoueZJ4ZwgHxSdxymEg9R4GXPZduzcPHacDnjb
	7iTyvu5hXtuxdWlwlkdk6q9i9LMiJZXi0crvN43M1
X-Gm-Gg: Acq92OFVmD4QWyE6RaNW7gqg9n7OFtK4SCwWXNgrK9IgeW0+jD5WZz9zSRH7seYsTJK
	uTbMxjlEEi1DzMh6GacDvRZ8Bk/VDRcdFo+56JgwYzhrPDoOBMCc9xa5XZdEggArSYk9nySs+w3
	/bNx9hxQqqSq2jGPjj6VhKeil6xHSvbJljsR7GaKdScrVD9PF8gGo+ACzVuTez2kGvd8FBEBLux
	YItLLLPvFlYQTwq/M3mtbFLHwtvup7LLsxXWXl4mPTMN+1ABSe/NbfAT/3N0z7JdTSvkEQPadZo
	ICQiCxX5fpseM1fnGw==
X-Received: by 2002:a05:6a00:2185:b0:838:af72:fb44 with SMTP id
 d2e1a72fcca58-8422532f1cfmr64099b3a.2.1780069184036; Fri, 29 May 2026
 08:39:44 -0700 (PDT)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
 <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com>
In-Reply-To: <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 11:39:32 -0400
X-Gm-Features: AVHnY4IzRc07289jCk2kgYhnu1tZXPLygS01KXfUrZO6SGSOP8SqZsviqJqaXDU
Message-ID: <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Stephen Smalley <stephen.smalley.work@gmail.com>, rppt@kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, selinux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Ritesh Harjani <riteshh@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, May 29, 2026 at 11:02=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, May 29, 2026 at 9:40=E2=80=AFAM Venkat Rao Bagalkote
> > <venkat88@linux.ibm.com> wrote:
> > >
> > >
> > > On 29/05/26 12:20 pm, Venkat Rao Bagalkote wrote:
> > > > Greetings!!!
> > > >
> > > > Kernel 7.1.0-rc5-next-20260528 crashes randomly on IBM Power11
> > > > hardware. Attached is the config file.
> > > >
> > > > **System:**
> > > > - Hardware: IBM 9080-HEX Power11, pSeries
> > > > - Broken: 7.1.0-rc5-next-20260528
> > > > - Config: 64K pages, Radix MMU
> > > >
> > > >
> > > > **Problem:**
> > > > Different crash at each reboot.
> > > >
> > > >
> > > > **Example Crash 1:**
> > > >
> > > > [    4.678016] BUG: Unable to handle kernel data access at
> > > > 0xbffffffefec10628
> > > > [    4.678112] NIP [c008000004e3c74c]
> > > > xfs_dir2_block_lookup_int+0xd4/0x300 [xfs]
> > > > [    4.678281] [c000000005eaf7d0] [c008000004e3c6d4]
> > > > xfs_dir2_block_lookup_int+0x5c/0x300 [xfs]
> > > > [    4.678363] [c000000005eaf850] [c008000004e3d56c]
> > > > xfs_dir2_block_lookup+0x44/0x1e0 [xfs]
> > > >
> > > >
> > > > **Example Crash 2:**
> > > >
> > > > [    6.327116] BUG: Unable to handle kernel data access at
> > > > 0x762f736563697695
> > > > [    6.327242] NIP [c00000000073cf34] __refill_obj_stock+0x74/0x2c0
> > > > [    6.327261] [c0000013ffdbfd10] [c0000000007418b8]
> > > > obj_cgroup_uncharge+0x48/0x70
> > > > [    6.327271] [c0000013ffdbfd50] [c00000000062fffc]
> > > > free_percpu.part.0+0x12c/0x630
> > > >
> > > >
> > >
> > > Git bisect is pointing to 54067bacb49c selinux: hooks: use __getname(=
)
> > > to allocate path buffer as the first bad commit.
> > >
> > >
> > > # git bisect good
> > > 54067bacb49caeada82b20b6bd706dca0cb99ffc is the first bad commit
> > > commit 54067bacb49caeada82b20b6bd706dca0cb99ffc
> > > Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Date:   Wed May 20 11:18:56 2026 +0300
> > >
> > >      selinux: hooks: use __getname() to allocate path buffer
> > >
> > >      selinux_genfs_get_sid() allocates memory for a path with
> > > __get_free_page()
> > >      although there is a dedicated helper for allocation of file path=
s:
> > >      __getname().
> > >
> > >      Replace __get_free_page() for allocation of a path buffer with
> > > __getname().
> > >
> > >      Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > >      Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > >   security/selinux/hooks.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)

...

> > > > If you happen to fix this, please add below tag.
> > > >
> > > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >
> > IMHO that commit should be reverted:
> > __getname()/__putname() exist for a different purpose IIUC.
> > __getname() does a kmalloc(PATH_MAX...), whereas we are then calling
> > dentry_path_raw(..., PAGE_SIZE) immediately afterward.
> > This assumes that PATH_MAX =3D=3D PAGE_SIZE.
>
> Alternatively, I suppose we could just update the dentry_path_raw()
> call to also pass PATH_MAX, but
> I don't see why we want to use __getname/__putname() instead of just
> direct kmalloc/kfree here so
> the size of the buffer is immediately evident to the reader.

It's reverted, see the posting below:

https://lore.kernel.org/selinux/20260529153608.30853-2-paul@paul-moore.com

I think there is still value in using __getname()/__putname() here as
opposed to a simple kmalloc()/kfree() pairing, but either way we need
to adjust the buffer length in selinux_genfs_get_sid() accordingly to
use PATH_MAX instead of PAGE_SIZE.

--=20
paul-moore.com

