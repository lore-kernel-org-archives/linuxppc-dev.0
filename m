Return-Path: <linuxppc-dev+bounces-19424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64C2FB5179
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 06:28:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqbr31l7tz2ygm;
	Tue, 07 Apr 2026 16:28:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::429" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775543331;
	cv=pass; b=hIxiOJjYVeKiML2BdejmNBJHpXc7UgCQ/roHS6YsDG8rCvErqDzs5Lp6KhQaDyVqvA5jjFAXJysOJbZ9T05q7DeuCcj5F5Z2vZEoxu8bewQjVc70ADd3HU/ta5Puh9CgRkPyijZl7tPPeWMQRXB8Apk64pvbJlURRltMq9vJVT8Le8tOhuZpDLmNvfRmwTlhMZfsnQ8e4xLZeoCNrf23iGZMotXsIsVK/OxqKLltvhFEMZEtaafnX4+1mQgiZVmDxFVw4IKhdVNil/XivOBAPr6mUQ8/dlaZd548yF3OhzTe1op89PqVnE+9YCvBDo4y6FsObdRIThGevJmzw/5QcA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775543331; c=relaxed/relaxed;
	bh=q5+1fYpXPccswEyejK/XRVeDvgDNzZfWpFzjApqgCPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsVMcVgUzhtMdM3EdDnHaTIstm8n7QBE+8US0/g+h5LKn4W2OBpX3+Q9yzzc/j4yBRNGPFeaovN8FNPSp9NxghVVc+GnJ6bqQDf5Eq/PTiHrE0vMn+RSYCVpt71TOUJ6dSfmWLFRmi0oEGOyE/PgBlZ6MHuRvq9RkeRUumWwAbKuad00WiPknFR264f1iNxwBHkMmux0bqJ7m9MEFCBRNbrgVHZigQ5v2hpV350Qca63s6O9OT8Pyl9OO351XQ8It5gvTrn5CN5h1L7/RJH28e6soTU0OWbjI5li7uLbBpwXCbqYVKY7bWFjBQTf0YnjxETnV3oYAi5yeu87I2VzbA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rI2HEYqC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=litaliano00.contact@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rI2HEYqC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=litaliano00.contact@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqbr20Q8hz2ygf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 16:28:49 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so2721972f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 23:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775543321; cv=none;
        d=google.com; s=arc-20240605;
        b=cVRJXZ7q634YUomHjr6imc9xFFfHiLRj5Uz+a36UBbTziWcA1FBSK5TIZFWyTm3uJL
         xJZvR4FLsHQQtbSVQsUBhWPHns42iSrjy7Syj83EERS7SInt4npN8HtCn9LOJ+kmlNUC
         Vi1tAcOgDUudMzqZO8GkxBSm7XjvdBwf83O5AX4+zcH1Fcqq1yHtEF+67M1FLfBM7xIZ
         nD9C6AzYHJeE4XkOUvlTh+i5HK/i/TI5vL2jCq9O3ubgLhD88Vah2BTIE+G6oBsg7LdO
         SEu55rnCaRxnQgK9/G6b1HhuCGXjprlfKDF63LaQDoqR3+MPG2nYwId5Kt/Lg/Np2UJ1
         Lh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q5+1fYpXPccswEyejK/XRVeDvgDNzZfWpFzjApqgCPU=;
        fh=YxadHPNqUA8ICgxwVgfeKx/ckJVaJGSQiAaUbGCTMRU=;
        b=ZimiD8oJT8dR+dfAYmHC+zgT5aGg1o0TMxi7Y+zD4J4IPdSQSJhDfv4Qrxwn60w+pk
         pIGxUzxNN9mwVRRa/Jum4AAJVAHPVDTIfsBiz8lDYAOser7Zu0t8c3N5Dzu8SrTcC4Yc
         f6gYLSTREH/Rp75ySQ1uSXQ1wy0ljXsb/cwxFj/u6R1b1aw0OOGu0xlIja8Cnfvx4aVA
         ltuhQpmnGwHiukznHMgLvAIww/QufmreH4NmLq9LDzBiII2elM+e9sPZZuUcLJXRAmUV
         A8iSdeMZQSAH8uxxPVFTH2Vu/MoorD02LRO77vzKHLTtpBcTO8zG7j+/cKq4plZqFPqA
         X0LQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775543321; x=1776148121; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5+1fYpXPccswEyejK/XRVeDvgDNzZfWpFzjApqgCPU=;
        b=rI2HEYqCmh8JLpP9cxwMMD64nNcg7P1+jRvEvppBUOkbr0TStkYNXg32LIAvwYM5YK
         2ezL9pgcAi9bKqa45ipo4EEMxS5Y1MErV93s3FXL3qDSc4I+CsYXFabjFXpWsY0mP255
         aA8ybBrJYYc5uvc+H8fZ/Rx30VL8Vb8avieRQWV49kWv5h4JIlH6qRdDw8fM37R8h7lJ
         kufkB8QLP4tkTIE9huoj/iHd0un6YjsTDs1K88qDhE0jw+6ut7Cb4sDzGLofZ4biKKCd
         4bEJ3a4IjPgaspzbHi5IAJop3DGvJ2TzINXj46ehE+YO7ji5j8VMwrydYb8j9nc2koQP
         c9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775543321; x=1776148121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5+1fYpXPccswEyejK/XRVeDvgDNzZfWpFzjApqgCPU=;
        b=tNStrIiYK4Ej8Yq7rLehN0Lq49NlWH8zUFGnKZcNElquSE8XicOlu2sR2gNUUlC6vG
         RcJigLVh+cbLjeYb7LWkU2wua6Of24kYKnr61dAOyB5hu4ympvkx7gfuGlZ7RCSVgHJW
         TW73HOkuwDBEPP4RejIR7WWxQiVmxcZr7MniYfFnOIurd/BqmHvCrpL8ue6i494yy0gG
         Hr1PukgvGIWrHSu7YcgheY/R7tP9kknYNVlkM5gfLi2p+2SAROQz457fq0TJZjBR7LUb
         4AASDXef1koqS8DGXQCzZU70dSm60esxWPiCCAWYq7MH9m0nhBbdBaoPvwwC++0vVWZq
         DJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCUv9Gj5u/nHZeN/YWp7CskhgDIVbG67iUCv87+jKhuXPs2UVWLFabU9XraEaMTwyXnYQRnwrBX7oueakqY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YweDsRRHm4/MpmBT2A+l92Gdh7ZO3+fn/Y3FfudbgQxvS3mr+n1
	4ZpRimxNs+dEI966zAAdkO/bJdx3yvEQz8uMKB/Xhw76EccrM22v/CUQ0uC5bdelc5NXLru7y+R
	0pYP9SeBCHpc8OJneqO+qwrtewSZNTKM=
X-Gm-Gg: AeBDievNA6GOmkdEurCBkVfQkcW7SkXg3mTaH9zFudb9lC20zlaB7hmSKLZLaCWe9MX
	TBYjHUrv3K1scIK83ACyQrtSAOV3OSch8AE1LgeY3jSDyrVh9G8J3oVMBFaujD7SJ7u/TPfFHVm
	4967dNjwr5WaAedHqHpnNyvvczFvk1cC4ZShQjV7skslngc3p8Cnwrg06SXlC0X3zV6opnj8tdj
	uo2ZmrGP/wllyYldFFhOCVqKgawsaujK+G05/k32TJytSTkSHAxq/zGoBDJCw0B9GPxHkNGuDJZ
	1GXoM+wBr2rDR5EjTg==
X-Received: by 2002:a05:6000:1202:b0:43d:301c:ecbb with SMTP id
 ffacd0b85a97d-43d301ced27mr13314124f8f.14.1775543320514; Mon, 06 Apr 2026
 23:28:40 -0700 (PDT)
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
References: <20260406061542.22354-1-litaliano00.contact@gmail.com> <wlyjl8h1.ritesh.list@gmail.com>
In-Reply-To: <wlyjl8h1.ritesh.list@gmail.com>
From: litaliano00 <litaliano00.contact@gmail.com>
Date: Tue, 7 Apr 2026 08:28:29 +0200
X-Gm-Features: AQROBzBV5nTco62Z4kS7TjAA3iXD2sEY8ZiId4r0VShskqcAS2YJBZ9R9pdoAUk
Message-ID: <CAK-CEVMv78c_4Mc=NGKArD__1LVThb1gfaRHAmknEw0+_9d8kw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fadump: Add timeout to RTAS busy-wait loops
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000e7150d064ed8e429"

--000000000000e7150d064ed8e429
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ritesh,

No, I haven't encountered a specific hang on live hardware in production.

This was a proactive fix that originated from an audit of the RTAS call
sites. I noticed the explicit `/* TODO: Add upper time limit for the delay
*/` comments in rtas-fadump.c that had not yet been implemented.

When cross-referencing this with other parts of the pSeries code (such as
the bounded busy-wait pattern used in rtas-rtc.c), it seemed that adding a
timeout is the standard defensive programming approach for these hypervisor
calls.

Since these fadump registration and teardown paths happen during critical
boot and state transition phases, a misbehaving hypervisor or firmware
anomaly could lead to a hard-to-debug, silent system stall. I implemented
the 60-second timeout to resolve the pending TODOs and ensure the kernel
remains resilient in those specific edge cases.

Thanks,
Adriano

On Tue, Apr 7, 2026 at 6:07=E2=80=AFAM Ritesh Harjani <ritesh.list@gmail.co=
m> wrote:

> Adriano Vero <litaliano00.contact@gmail.com> writes:
>
> > The ibm,configure-kernel-dump RTAS call sites in
> > rtas_fadump_register(), rtas_fadump_unregister(), and
> > rtas_fadump_invalidate() polled indefinitely while firmware returned
> > a busy status. A misbehaving or hung firmware could stall these paths
> > forever, blocking fadump registration at boot or preventing clean
> > teardown.
>
> Was there an issue which you encountered? Can you share the details of
> the same please?
>
>
> >
> > Track the accumulated delay in a total_wait counter and bail out with
> > -ETIMEDOUT if it reaches RTAS_FADUMP_MAX_WAIT_MS (60 seconds) before
> > firmware signals completion. This follows the bounded busy-wait pattern
> > used in rtas-rtc.c.
> >
> > Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
>

--000000000000e7150d064ed8e429
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Ritesh,<br><br>No, I haven&#39;t encountered a specific=
 hang on live hardware in production. <br><br>This was a proactive fix that=
 originated from an audit of the RTAS call sites. I noticed the explicit `/=
* TODO: Add upper time limit for the delay */` comments in rtas-fadump.c th=
at had not yet been implemented. <br><br>When cross-referencing this with o=
ther parts of the pSeries code (such as the bounded busy-wait pattern used =
in rtas-rtc.c), it seemed that adding a timeout is the standard defensive p=
rogramming approach for these hypervisor calls. <br><br>Since these fadump =
registration and teardown paths happen during critical boot and state trans=
ition phases, a misbehaving hypervisor or firmware anomaly could lead to a =
hard-to-debug, silent system stall. I implemented the 60-second timeout to =
resolve the pending TODOs and ensure the kernel remains resilient in those =
specific edge cases.<br><br>Thanks,<br><div>Adriano</div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Apr 7, 2026 at 6:07=E2=80=AFAM Ritesh Harjani &lt;<a href=3D"ma=
ilto:ritesh.list@gmail.com">ritesh.list@gmail.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Adriano Vero &lt;<a href=
=3D"mailto:litaliano00.contact@gmail.com" target=3D"_blank">litaliano00.con=
tact@gmail.com</a>&gt; writes:<br>
<br>
&gt; The ibm,configure-kernel-dump RTAS call sites in<br>
&gt; rtas_fadump_register(), rtas_fadump_unregister(), and<br>
&gt; rtas_fadump_invalidate() polled indefinitely while firmware returned<b=
r>
&gt; a busy status. A misbehaving or hung firmware could stall these paths<=
br>
&gt; forever, blocking fadump registration at boot or preventing clean<br>
&gt; teardown.<br>
<br>
Was there an issue which you encountered? Can you share the details of<br>
the same please?<br>
<br>
<br>
&gt;<br>
&gt; Track the accumulated delay in a total_wait counter and bail out with<=
br>
&gt; -ETIMEDOUT if it reaches RTAS_FADUMP_MAX_WAIT_MS (60 seconds) before<b=
r>
&gt; firmware signals completion. This follows the bounded busy-wait patter=
n<br>
&gt; used in rtas-rtc.c.<br>
&gt;<br>
&gt; Signed-off-by: Adriano Vero &lt;<a href=3D"mailto:litaliano00.contact@=
gmail.com" target=3D"_blank">litaliano00.contact@gmail.com</a>&gt;<br>
</blockquote></div>

--000000000000e7150d064ed8e429--

