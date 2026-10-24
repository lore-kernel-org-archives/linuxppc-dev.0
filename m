Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D43606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6YEiP/W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBsVC3cmJz2xnh;
	Sun, 25 Oct 2026 07:50:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792875043;
	cv=pass; b=H8WqRWhWJPG43YTlHBgIXJtQ5N7Omyt+iNtPdeS8LiFWsoFl3aA6M4D3umBhLAg7Bx97E/uUkG1PBaVBacPWL9iDOdQ3yAc2GW1RSl0aUUjhT5B9gZCCS+PXSMzUYmk1aSzt2M+A87PbtqnU1suM4QH68RQchBNdiOOSWll8I25vTvD4jlGf5Ihco2W9KqwPSidC1RX84Y/uWBJ+7yPCfTvmjt8A+rj6W4XAQ3+cV5ewawqdZYtfVLpUSXJlqmcqFrxkcEcoyr0RGUkYCk4PhhHih47Dmzde86YpwIsQQpNfaEnVYdCzFyhjQC1oksPz9SvsjYMc2EGWNMW31/LFlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792875043; c=relaxed/relaxed;
	bh=jsolgFrR76ayID/EQm/jOQITj8JUoTlcobi1Awhx3Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdxsK9DhU7RgYSsVVVF3COk/D11UJDieACGA9LFlf7jKH7ik/OMaW1Eth+nJre1VmlwTp6D2g9mo+9c6XcFpUV7k/lZvA+BMeboav/4DZiChf7/tVrhTezVmmJkXE0U9ob/ldz8Z3oOhX9IQq1HPxNlVy4Cp/1vc35vyDU6bu5emuYSKUwgHct58M/GgULPgsBv10x62ZUZKKOjBsBjx2LRi41VpCNm1GncnAfkk8qFnQNSDkUC8xwZkRBV0HRep2p+4awHsTG7uAknO6xzgM39pwJlme7DU934fVlS7sm1rUIEgUwtIBRNNyMh+FcL38TdrqgItqnt6u9XKkAqoRw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6YEiP/W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=qwe.aldo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6YEiP/W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=qwe.aldo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBsV94ZZfz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Oct 2026 07:50:41 +1100 (AEDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-8b10ac6ab7bso17836117b3.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 13:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875038; cv=none;
        d=google.com; s=arc-20260327;
        b=g/tak+SoS/SHiflVtdw0pRh0eLGHUOOOVSRf0hPK1V4WPvt3b4hsX9YYlDEAyDo7Pq
         rAjH/eIuxXdZItMk4En2lq81ARHk24cd3FDp1yXVXYQxdJAtdo8/p7mJiEO+5guaADBg
         rqeHaXE/92eRXLXtSmJL++K2wQvs3tLn/EApnWCvsrrJ/lw4hUZEdVCge3rYQsMJbAj8
         Zv+v5C/2CBFFgpC8PVGhvC9bakEevPmYgd3OvI/c2CSenz9KDbxTqkAy4hJ76p2UxOve
         GPVgUWSAf2q2+Ko5JowKLZs6UTGvA0c5Gqj96F0ENw/B4p2E83IXEYRkNp+SSw76Nl7H
         uc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jsolgFrR76ayID/EQm/jOQITj8JUoTlcobi1Awhx3Xs=;
        fh=bQoH/vLXKu9X4plPVW2mkbAhMrSp5n4v/kzqH+pIzTc=;
        b=ZfLi4OpMXf0+I+84OjJaVf4gcIbH2MBwFyyX6ivXEdt45HzSAu0l2zrtAKeJKbj0Nu
         0JS20VQupkkCrSAjiRF5eQGUatwDsQC6DvfexLJ0w3JrovzDgZCs0sGBQxz4wk6S9KYi
         gVqFYtwDeZi86D8k6sIXchvh8hxlywe47WGzSdTVT6LFO1SFlcCUUkyWiwhThHiAk69V
         qjri3grXGFTls8Pa8ctAg+ijuKnrsyHzw0z5MxrMpJgzfHh/15GjXMW1q4JNf81jHgO4
         HVprSOOCELenbOlD3RkLS5mvvS5gVBXb2bpui16cTGy3eSEbmNvX3z4JjuykE5u3mXSt
         IXmw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875038; x=1793479838; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jsolgFrR76ayID/EQm/jOQITj8JUoTlcobi1Awhx3Xs=;
        b=r6YEiP/WH9ych2gdcyCEOuh3dE2XUUn9lODt/lPXREEvbECjY5o2SJIyuvkj0QiRAI
         ly6MJwMLDIIIwBOPcg9c8Y/p4LYuUffUzntHqSwV0StyfoPqz3+lW9IoEvhP+DtZ8XOh
         49iz9MKkyJeG1DDzr+lw0dmB0EcKOEehH3x/jF78LyeU4cYbQPnj23krvcB1I2+rxeaJ
         USWS+xMH69HfPF+VK+qObZ2aClmkn6GNtxiIgCPa2yUG/JwaOEk5wnHcS//MtmUyjyR2
         pjcjKtqICpWIb6rHUSv826sjZ1IY/mPvhV4s7DP27kfzzthciGvGzBYVEHn2iKtFwjAJ
         Hw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875038; x=1793479838;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jsolgFrR76ayID/EQm/jOQITj8JUoTlcobi1Awhx3Xs=;
        b=vdw9ZiSuFnlbIDE85vfZ8nTxrXXlaXR4sGb1581MLjkyHljyFXDcSRrmBcLhMa+YpL
         bV85lrCaUUwNAvoMf734wdkGUKy+ccMUsBNVS++BEzy3QxAV0frd+xp1BoRlixtTtN9f
         nd6LqPOjyOB47BycUSUTOtM1H+YkdiJAwMOTMnxt2kRc99MpQLhGgmjmdaqVFmJiiKXJ
         4FlBTJo2fEtwYa8u9rHfNSyovfCn4UxW+zjZ9XzLSlBR62ELJQwCj+aWJYrO/XqQVNaR
         mi8gyYN3zMRTKWGnWRZFVdwgOn6R3NHgZVGvNc/0m6xinm6xSxWIAakxd076zGkQCaFr
         11jg==
X-Gm-Message-State: AFq9FYIjujy1fbtWyKt1cbOHYNM/R7wnaDr0znRYeKCASs3e/DSO/CB9
	jifIGVYClrHlGqCLZ/iw4HlVO3roPEqN+FZd7mVzNPXsG+CtY+PFfVz+9B8Sk6cjKTeHzftiHcl
	aZ1d0EazdDOSlxM4njS9brw9PqbKEdEw=
X-Gm-Gg: AYBFou1HcQGUkO5VF0KNrS5RzI3pF9OOHDw0U2yTow3EzMDJT2ciMczvhJ/2f+TU8nC
	nehAYaOxOMVd0gJKVdWukOT6zB/057RJ2Yk2YoRIR5uKB9AqDNlyNDMyGj5mWnXCgJY1C+5K2Bq
	wi93CUtBNEeWQfhgP/Q7sBHKnCTeDW8a9E7hXsraqEO97+CSuexrjB3seLFibfO+4HWfqqSKjD3
	zHZttNmOIi2epFMs991ZM4ktk8vaoT5ErgYOil1se7eTKD2wn+mo8cz823b1RS/pAXw5jcEnrwx
	+Gk3gBjXh2bu7GZeE5hcDCp6rQNqeNMZZ/qvDl6yTBo68bqVPuM7DP/qjOv9FFUTM1ymKagdvoY
	yHcsG59zkPKTo5AXVop3ceY6PJw1IpxXFaiU=
X-Received: by 2002:a05:690c:c181:b0:8b0:b1dd:c096 with SMTP id
 00721157ae682-8b166c26976mr17598897b3.45.1792875037925; Sat, 24 Oct 2026
 13:50:37 -0700 (PDT)
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
References: <20260923135301.2448228-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923135301.2448228-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:50:27 -0300
X-Gm-Features: AclHuK8MruqCFHl6cdHMlC9ZEpCL0wlCfX--B8RmO9DtrhAaHEQW8YqxHKFwWt0
Message-ID: <CAP48Hfsg+ndaHLNPa6dfgbjk9idMkY0PRjhoSh-hHCJwhZBC6Q@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: fsldma: kill the channel tasklet on remove
To: vkoul@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000c3244e065e9c3f27"
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c3244e065e9c3f27
Content-Type: text/plain; charset="UTF-8"

Hi,

Following up on this tasklet teardown fix sent September 23.

Is there any additional testing or any change needed for review?
I'm happy to work on it. Please let me know if another reviewer
would be better placed to look at this driver.

Thanks,
Aldo



On Wed, 23 Sep 2026 10:53:01 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:
> fsl_dma_chan_remove() frees the fsldma_chan structure without first
> quiescing the channel's tasklet. If an IRQ fires just before the
> remove and schedules the tasklet, dma_do_tasklet() runs against the
> freed channel struct, causing a use-after-free.
>
> Add tasklet_kill() before tearing the channel down.
>
> Fixes: d3f620b2c4fe ("fsldma: simplify IRQ probing and handling")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/dma/fsldma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d9..0e2f848 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_device
*fdev,
>
>  static void fsl_dma_chan_remove(struct fsldma_chan *chan)
>  {
> +     tasklet_kill(&chan->tasklet);
>       irq_dispose_mapping(chan->irq);
>       list_del(&chan->common.device_node);
>       iounmap(chan->regs);
> --
> 2.43.0

--000000000000c3244e065e9c3f27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<br>
<br>
Following up on this tasklet teardown fix sent September 23.<br>
<br>
Is there any additional testing or any change needed for review?<br>
I&#39;m happy to work on it. Please let me know if another reviewer<br>
would be better placed to look at this driver.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Wed, 23 Sep 2026 10:53:01 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; fsl_dma_chan_remove() frees the fsldma_chan structure without first<br=
>
&gt; quiescing the channel&#39;s tasklet. If an IRQ fires just before the<b=
r>
&gt; remove and schedules the tasklet, dma_do_tasklet() runs against the<br=
>
&gt; freed channel struct, causing a use-after-free.<br>
&gt; <br>
&gt; Add tasklet_kill() before tearing the channel down.<br>
&gt; <br>
&gt; Fixes: d3f620b2c4fe (&quot;fsldma: simplify IRQ probing and handling&q=
uot;)<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank" rel=3D=
"noreferrer">stable@vger.kernel.org</a><br>
&gt; Reported-by: Sashiko &lt;<a href=3D"mailto:sashiko-bot@kernel.org" tar=
get=3D"_blank" rel=3D"noreferrer">sashiko-bot@kernel.org</a>&gt;<br>
&gt; Signed-off-by: Aldo Ariel Panzardo &lt;<a href=3D"mailto:qwe.aldo@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/dma/fsldma.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c<br>
&gt; index 22d62d9..0e2f848 100644<br>
&gt; --- a/drivers/dma/fsldma.c<br>
&gt; +++ b/drivers/dma/fsldma.c<br>
&gt; @@ -1205,6 +1205,7 @@ static int fsl_dma_chan_probe(struct fsldma_devi=
ce *fdev,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void fsl_dma_chan_remove(struct fsldma_chan *chan)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tasklet_kill(&amp;chan-&gt;tasklet);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_dispose_mapping(chan-&gt;irq);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0list_del(&amp;chan-&gt;common.device_node);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(chan-&gt;regs);<br>
&gt; -- <br>
&gt; 2.43.0

--000000000000c3244e065e9c3f27--

