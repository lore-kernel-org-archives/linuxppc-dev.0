Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C95606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CE4EL6tZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXylH5zDTz2xyj;
	Mon, 23 Nov 2026 18:49:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b132" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795420187;
	cv=pass; b=PJ4sPwkzgTGMN7JE2GHoS5DoM+Mm1L80S9cwiuE1pr98MoU6ktsLgndZ2yvT9YMHPwnJuzQtFvi0Nhme4ty4Kaflzt8MmfE5V9CXupod6xqQBfkFeDlgJCYcQ7nV4prYVyKfOm6I/cBMJ/zEK7Nw4eSLFcO4S5TvN3WEaKXI58rn97MeXoU53OlCVrMc1Hw4+jKAYun/8tgDxHO2JvHYEbgP0rZUCzR3IWaE7Sqve6FQv44bI7naKlN4EJmVXM52ty1A5UWAjvfujAF/e8XNUVgVC5Sm+SngzQXqOyRmlcOLHnbM9dXgQAeISGduiYwO2nNszb+U+rHgwfycYqbjdQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795420187; c=relaxed/relaxed;
	bh=8SFIGgJ3U+9xGIvUE0awoBO9S4vSUMNtx0j+SWo1DZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONp7AgCkZqr3UHwCpyaE50RB0hW+XVfZoxRjdoSAZyY0MQ5kKcagbZDUcdko+87W++GqsbDyOVTmz52YZ0edQ20AR8KhrETmzCSm80l4uhNgigcEO2798AjHL/rG7Q4UQ/SgFfk79rCzMgCLr2rRsNOuQ2mMrcMqYmiYTyCXXllTsYl2cxwNIQ5Sl81WL0eAlN5EvkjqjH8pgrCCwZ7fcQL35GXRLIIoDQ/i5eYlusSPPb5PtcB1UM/p2KI7fBNyF5zPf8De8xWanxYR8540frfjz6mLM8xIItQWqPy+c3FfM7PJMaQuFj85RsAr/kccuWfZF5UDFrlTVCxsidQpOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CE4EL6tZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CE4EL6tZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com; envelope-from=yadavgaurav386@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXylG2rxdz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 18:49:45 +1100 (AEDT)
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-67da69e7c31so2906275d50.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 23:49:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795420182; cv=none;
        d=google.com; s=arc-20260327;
        b=DSLP8oFeKw5oUlu/tLw0BWCnMLyFsami7d5Hk+IzZ/C0m/bb+OrWoNeJ0oUHig7E1m
         JZV+1FD6O+A5f3GtoKfZi0O9lWtyDiXkKGvRV+MVWkjCEehmWc4x3mZkrkDRshyHbRGq
         +1p0a7Vxu+gZ5n8/pPP2F4N9pdAB5n5660/LzBmULQ7KHznBOwGyayHFFht6fjxNrVeD
         lWRhP814H/T7VtabtlCV6ZV/G8Qhv0pTHC4Eo63UW38A9R125nowhziveyA12zFVr6zW
         lIdN2kIbn8jLU1oXp94bWQSrcxzK07IKtxGuXHJo+cNFZbPN1n/5ZvX+oqWd/rgP9s30
         TauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8SFIGgJ3U+9xGIvUE0awoBO9S4vSUMNtx0j+SWo1DZo=;
        fh=D0PO99RoSMUY6jIgk60+j+9euhDfDK2xPZJ36xxlgX4=;
        b=rqsb6p0zuMwUh9EYSXzYfgWIIlF8V6Ph+ZVPUYlEppL5CyQIYgU5vk38w5u7R1DB34
         XU7Ls4r5SttmyzcvwIFepge/evKZm8yfS4Lmo/JtSw/CIurfqE4rq2/UcnvDstxx5hCl
         Ffs7E/YvlZ8gSe7FQL3o5yyu84nLja0Q5aSHB4c3yCLjjvtaI985Z4erPJm5K2ebivsl
         jr4wiGY/W0VgVEDrpfl+FO6gpK+0uSPYylktAkMDzOx2LpeC3Un7cUcVOlyX3e4xFsNC
         DLe6DKffl18Qfh8aAFTs6qeQUr0zGxYddGSB1fZ/cQZTsr2SN3hDMUzZimpgVpAXpGtq
         Tung==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795420182; x=1796024982; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8SFIGgJ3U+9xGIvUE0awoBO9S4vSUMNtx0j+SWo1DZo=;
        b=CE4EL6tZMzuu3Zn0Fwa/Nvy8V1EWNFxzyzitSAvgNv6tJ0zL00M+oFHmAPqVO846A7
         LeK4imYj1j06VpN+vR8C3ij9XnFpDFlJhFZyLqRfVm86R0jNBnmFFFSIWUNLQOkOQL+o
         D7P7YqGqhyAhLob7j1ifW5TuW24WKMSr4Tp30F3pqOpHVl3C3NAI8zKJWsP3+NRudEDQ
         nKdrBQLxpWb1eJp+oRV9ITGtnKOC+VoypvyU60A1S48x7fHyiQfoKgjqZN16ZbMDxyaX
         CQ/D+NVqvcIfa8D0B9AKZMYOmZ6rrm7AHoOUEncDObK40wyZH5j+h0/TUd1u9saq8C3J
         lIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795420182; x=1796024982;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8SFIGgJ3U+9xGIvUE0awoBO9S4vSUMNtx0j+SWo1DZo=;
        b=PDyZt3iLtAnQe4f3rJsk6Z4wH8WRsIJrGNf+1s4JSpKg+iacVMsj7xULow6oiUZVG4
         rorVhYHoDaP8RWIDF9Af5dt53m2RaPuPlDYC71m5p1XrGFjtrJmttloMT/fjStEGAFVM
         3XzCNEc4ZG3S+oaNjaDgHNp9VQkbNx3aP367YJDvwLzm1NI1KVju9ldOWgGUA0vHm3P2
         nPIONVgYmxVfAMJoYoHeGgn6CzHGkGZ/tY09TprZ/JP4hGt9JqAdKy12bkqiiqxng2Oe
         lRAV5X7UJD4RHlW9DlOsBPHhoGxDAI6YZUpzhji+zr8GkjUCYBQ7Za2kRSs5DvBLSX4W
         76EQ==
X-Forwarded-Encrypted: i=1; AL+hErH1f29zrME8UrcUFBT2IywQKK0FBKYF4aKgWgzQC06D4uBwNDFgprFI1fNx41k0YqMYilYqhuhNxIztSNY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9F1mEj0Lv8nfb7FfNGSEmJjVvJGBMQifkYcr9fHzXWTCUsnkJ+
	8RBe4brrHmJd3klrS/tdGbdQrbfUggGWKUd7rFwCaTfiWwQgvalSQtx9rMZq+egaAyHYJ4hUxKA
	6txvVx+RgvZqcj1XFzdo4BgaaTX9wuGc=
X-Gm-Gg: AZFdTZcrAZcc5J/PpgV8NC045TEIpzYLuoJPpC3FSbc2FvUNHB6cYoHa6CYTj3ID1DL
	C1W7jvxgKtHLLTwLFHqwxyNf/WoZfEclcMRhbM+ddfXAmFu7yoQ7vjwNqaOY2Nz0m+1xOqr05Ge
	dNOzUx/AronFq0lrHcRShRJ3b3T1WfAG1wYRIFLzKs/0YXfC92HLJGpyaJJHxiW2zo9V6frMszr
	liAxa0tmzyyMMenJjTytg3j3vxNM6vom/xHWXAAMefzL9Zdh1uIGQi4kITBiecD4eo+q5gmXNND
	/SH9HWoQ3/HnyQfJ/hW6f3iWqa8M3aV2sh0pBErKrmojsFy9q+TJ3TeBSztwrr1rTzBjBbfZPVP
	lqXEPPnk0UiiQI0kzufeMg6WuFRtPCz7AukSk6M4OlIHjs/HZGvcTNYH4dG3xQ/FritpEcA==
X-Received: by 2002:a05:690e:47d8:10b0:67d:8ef8:30bf with SMTP id
 956f58d0204a3-67df441089fmr3009842d50.36.1795420182636; Sun, 22 Nov 2026
 23:49:42 -0800 (PST)
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
References: <20260807084050.25216-1-yadavgaurav386@gmail.com> <179532322375.92012.11986007993512084245.b4-ty@linux.ibm.com>
In-Reply-To: <179532322375.92012.11986007993512084245.b4-ty@linux.ibm.com>
From: Gaurav Yadav <yadavgaurav386@gmail.com>
Date: Mon, 23 Nov 2026 13:19:30 +0530
X-Gm-Features: Aa3M54quNxW2e3qe0v2krpY5JeAp2nV265GSJrPVh6iCQNce8pNUFbahmfbHdw0
Message-ID: <CANo8Lds=ysQE7sZ3rD+KbYnH=Lu5KbAZ2mBc-yBDE62ZrbfL_Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000356e2b0660ecd653"
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000356e2b0660ecd653
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot.

On Sun, Nov 22, 2026 at 10:25=E2=80=AFAM Madhavan Srinivasan <maddy@linux.i=
bm.com>
wrote:

> On Fri, 07 Aug 2026 14:10:50 +0530, Gaurav Yadav wrote:
> > Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
> > and remove the corresponding TODO comment.
> >
> > Using vcpu_err() provides vCPU-aware logging context, making it easier
> > to associate register dumps with specific vCPU instances in logs.
> >
> >
> > [...]
>
> Applied to powerpc/fixes.
>
> [1/1] KVM: PPC: BookE: Use vcpu_err() instead of printk() in
> kvmppc_dump_vcpu()
>
> https://git.kernel.org/powerpc/c/54efc2e1e9af9e3a14264db5686330e4fd477286
>
> cheers
>


--=20
With Regards
Gaurav Yadav
+919310150558

--000000000000356e2b0660ecd653
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks a lot.=C2=A0</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Nov 22, 2=
026 at 10:25=E2=80=AFAM Madhavan Srinivasan &lt;<a href=3D"mailto:maddy@lin=
ux.ibm.com">maddy@linux.ibm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Fri, 07 Aug 2026 14:10:50 +0530, Gaurav=
 Yadav wrote:<br>
&gt; Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()<b=
r>
&gt; and remove the corresponding TODO comment.<br>
&gt; <br>
&gt; Using vcpu_err() provides vCPU-aware logging context, making it easier=
<br>
&gt; to associate register dumps with specific vCPU instances in logs.<br>
&gt; <br>
&gt; <br>
&gt; [...]<br>
<br>
Applied to powerpc/fixes.<br>
<br>
[1/1] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vc=
pu()<br>
=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.kernel.org/powerpc/c/54efc2e1e9=
af9e3a14264db5686330e4fd477286" rel=3D"noreferrer" target=3D"_blank">https:=
//git.kernel.org/powerpc/c/54efc2e1e9af9e3a14264db5686330e4fd477286</a><br>
<br>
cheers<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><font size=3D"2"=
>With Regards</font><div><font size=3D"2">Gaurav Yadav</font></div><div><fo=
nt size=3D"2">+919310150558</font></div></div></div></div></div></div></div=
>

--000000000000356e2b0660ecd653--

