Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E7C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:39:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D0920673
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxpWpY4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D0920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BGq30MxNzDqsy
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 02:39:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HxpWpY4j";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BGmM3n7yzDsSt
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 02:36:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HxpWpY4j"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43BGmM2wGhz8t62
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 02:36:51 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43BGmM2VRRz9s3l; Sat,  8 Dec 2018 02:36:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=flukshun@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HxpWpY4j"; 
 dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43BGmL57vXz9rxp
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2018 02:36:50 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id s5so4130183oth.7
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Dec 2018 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=qqvWUSSNvUq5vTn9GwmKE+bHK/cIVwLIR0TNFeIky6U=;
 b=HxpWpY4jOQGxwA++vEyyMvQJ6YXs/7MPTQewIhb46SSUOfYxzKLUbCXO1P6oCKiDOI
 4cWnWWW4AXYi6O5iuwC/ACoFTW0I3RQBbod9AkUzgDBtKEIPZqSLWqpvBUsvOVLX0bcU
 L4k2zl72Yu7i1aNusmZc7iNgIxzbuzUQn61E/Jdq4OzeNGPwnFbEzRrVZ1IP+PxkD+dr
 HHprTjO4ovYJirNKoTJI6qfjpTXwuDaaGqNZeBLaSeSZc9w05/ib8oN/tIcDxxoqwmv+
 Hs5T9xwc6G2wX1BgKGCI/EvVkfF1f7eBqkkiognDVKkA2TpI5EdNAXzKwMkKvvktNh0M
 CEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=qqvWUSSNvUq5vTn9GwmKE+bHK/cIVwLIR0TNFeIky6U=;
 b=QOGGEenQlcnjcYqUCujp2UIwB+Aez0iBUqtLAbSiMCchCs/j5ntsIXYburFHd34t5h
 mLf4S8KcHCPVQau/WWkH7078vONppDaNwHWdABgA1d9uyITNRQYG06fZNECR96uMv5lr
 thIUZFkXmglyXhDxKYqmNmoUd5lMkI7du5LVYwxWHKKMhelI7SnaqFJUe8jHYmanOfxW
 TEVoNBl0jhUat+QtjOhRYNZqc0mxHyo/J+aFBeDNqTIJxoq0AlH6V7gYkipK7aJlyZSh
 hk7teMw12MgAcfJiuvbatFhYPisJBBtP/HZOOVwF3KdUJNDBGOrKLe2tIlOYTt6dBaRl
 O36g==
X-Gm-Message-State: AA+aEWYAFaBuTMPvPwwObYx06GgA1yv48aBQENOiD9WQNMH+mKQvVZ/Y
 f5Garz2f4sYn8vnAVAB9ozk=
X-Google-Smtp-Source: AFSGD/UdwhRIxzR1tyuv5nQV4HjvTQ0xGrktZ5c2TCqb+4Imt+gitE+MYUp7l82qqABqSOGr8KPKmg==
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr1800727oto.77.1544197008349; 
 Fri, 07 Dec 2018 07:36:48 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f127sm1928610oia.19.2018.12.07.07.36.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 07:36:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <87pnudjz72.fsf@concordia.ellerman.id.au>
References: <20181206170646.3736-1-mdroth@linux.vnet.ibm.com>
 <87pnudjz72.fsf@concordia.ellerman.id.au>
Message-ID: <154419700199.27049.4999726632209685368@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH] bpf: fix overflow of bpf_jit_limit when PAGE_SIZE >= 64K
Date: Fri, 07 Dec 2018 09:36:41 -0600
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Sandipan Das <sandipan@linux.ibm.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Quoting Michael Ellerman (2018-12-07 06:31:13)
> Michael Roth <mdroth@linux.vnet.ibm.com> writes:
> =

> > Commit ede95a63b5 introduced a bpf_jit_limit tuneable to limit BPF
> > JIT allocations. At compile time it defaults to PAGE_SIZE * 40000,
> > and is adjusted again at init time if MODULES_VADDR is defined.
> >
> > For ppc64 kernels, MODULES_VADDR isn't defined, so we're stuck with
> =

> But maybe it should be, I don't know why we don't define it.
> =

> > the compile-time default at boot-time, which is 0x9c400000 when
> > using 64K page size. This overflows the signed 32-bit bpf_jit_limit
> > value:
> >
> >   root@ubuntu:/tmp# cat /proc/sys/net/core/bpf_jit_limit
> >   -1673527296
> >
> > and can cause various unexpected failures throughout the network
> > stack. In one case `strace dhclient eth0` reported:
> >
> >   setsockopt(5, SOL_SOCKET, SO_ATTACH_FILTER, {len=3D11, filter=3D0x105=
dd27f8}, 16) =3D -1 ENOTSUPP (Unknown error 524)
> >
> > and similar failures can be seen with tools like tcpdump. This doesn't
> > always reproduce however, and I'm not sure why. The more consistent
> > failure I've seen is an Ubuntu 18.04 KVM guest booted on a POWER9 host
> > would time out on systemd/netplan configuring a virtio-net NIC with no
> > noticeable errors in the logs.
> >
> > Fix this by limiting the compile-time default for bpf_jit_limit to
> > INT_MAX.
> =

> INT_MAX is a lot more than (4k * 40000), so I guess I'm not clear on
> whether we should be using PAGE_SIZE here at all. I guess each BPF
> program uses at least one page is the thinking?

That seems to be the case, at least, the max number of minimum-sized
allocations would be less on ppc64 since the allocations are always at
least PAGE_SIZE in size. The init-time default also limits to INT_MAX,
so it seemed consistent to do that here too.

> =

> Thanks for tracking this down. For some reason none of my ~10 test boxes
> have hit this, perhaps I don't have new enough userspace?

I'm not too sure, I would've thought things like the dhclient case in
the commit log would fail every time, but sometimes I need to reboot the
guest before I start seeing the behavior. Maybe there's something special
about when JIT allocations are actually done that can affect
reproducibility?

In my case at least the virtio-net networking timeout was consistent
enough for a bisect, but maybe it depends on the specific network
configuration (single NIC, basic DHCP through netplan/systemd in my case).

> =

> You don't mention why you needed to add BPF_MIN(), I assume because the
> kernel version of min() has gotten too complicated to work here?

I wasn't sure if it was safe here or not, so I tried looking at other
users and came across:

mm/vmalloc.c:777:#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't u=
se min() */

I'm not sure what the reasoning was (or whether it still applies), but I
figured it was safer to do the same here. Maybe Nick still recalls?

> =

> Daniel I assume you'll merge this via your tree?
> =

> cheers
> =

> > Fixes: ede95a63b5e8 ("bpf: add bpf_jit_limit knob to restrict unpriv al=
locations")
> > Cc: linuxppc-dev@ozlabs.org
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Sandipan Das <sandipan@linux.ibm.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  kernel/bpf/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index b1a3545d0ec8..55de4746cdfd 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -365,7 +365,8 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
> >  }
> >  =

> >  #ifdef CONFIG_BPF_JIT
> > -# define BPF_JIT_LIMIT_DEFAULT       (PAGE_SIZE * 40000)
> > +# define BPF_MIN(x, y) ((x) < (y) ? (x) : (y))
> > +# define BPF_JIT_LIMIT_DEFAULT       BPF_MIN((PAGE_SIZE * 40000), INT_=
MAX)
> >  =

> >  /* All BPF JIT sysctl knobs here. */
> >  int bpf_jit_enable   __read_mostly =3D IS_BUILTIN(CONFIG_BPF_JIT_ALWAY=
S_ON);
> > -- =

> > 2.17.1
>=20
