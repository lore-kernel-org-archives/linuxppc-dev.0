Return-Path: <linuxppc-dev+bounces-27644-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88D7C982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 00:17:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmCqP0GPXz2yb9;
	Fri, 18 Sep 2026 10:17:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:33::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789690625;
	cv=pass; b=F/Lk9GgefrWpV6qzep+9gnxYF03YisipNTpXVS4ru6c+NrfQtwiQ2qSZ7yl8peLy+fRFmOizmrKQJ+CBnBSSdb0k1/lbuDYB89oR50yDNwj8X1Er5OuNEhv2bdIo1rIYDACk/8prw1Fyv2c0wsyOrF+XbzGODFguAC3MXiG5buqTuKsT0k1Gs1Fiex1jKQRuXUFZyjSI3JPI2ct3kdtygMJJQlIcrMqhapMgwnI3dnA4Gr0t1xc6XwQkw8WaJTkWQQeEHnmyE7U4qHJtpJp26d0JJR4zcAAxes205s1BOjpDkmYkHg92Ktnfs4LtD1qByV+SAfIdriPsYjBF62Ypiw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789690625; c=relaxed/relaxed;
	bh=ThLt5oXN6ToF4YKkt6FpXYxeDHP+cqmJLsZgthH2NCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpSmGZBrYNN0f9ScEONF05QG2XOPRyirRa3NiT2A03eetE5Xu9Ldk3YCRbEqlwebH6y5iwevfBSh+Y3npUqnGAdnyObl3+QvblGfMPTWAa22Mz4qi+zGFlDVmrWCyYWGy+U6dBGRMsy5E4GoqvVoBWVBGjiH53IYVgfg3b0l9Ggiw5FPxozxWr32bIFdgLFtJf7MOe4IitQxKM55nOLxg/MKy9BxLV+ToJZMmvlpNOpEjOQPBUsRKBhEorsnu0A+va/95kmuWkWQQ/7vpYMp+SJq8je/aqaX6TC4Nv9Ah2bguokzf0z3JLNWg7YS7CjMRFcBJfZUVh918+MrpDMI+A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X9adxFaG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X9adxFaG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com [IPv6:2a00:1450:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmCqM6h3Yz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 10:17:02 +1000 (AEST)
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a985fba28bso174691a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 17:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789690619; cv=none;
        d=google.com; s=arc-20260327;
        b=E6rTiGDzti5gVl6pahPbCYdaKF8dVjmZX/uFvJEID6VchI1LeN1E5g6jktrxyGSPY1
         Z+Eebhgihe6c0feBCgKt/h2fuMZ70i58pKYWOz9C2rSPb/kBw3y5R3oouSZTTl9J8bhk
         LwmK3roqrRWd6Tpr84oe7JpZX9oIGdtevwzPof2ChvSLHvGB3IUU4+vnch5Kn8e9aOki
         AB1nqK45gyQqIFAd7GEqiZfpUj+0tbb3XhvZGJqfjnqVP8+141eaknyxdCrB2qismIz8
         Viq/QlPWBqwl5pSGjcEnvFGHw+B5ptj0X/Rqb7TuZPOo47sod9t2VNVQi1SePW1A5HTQ
         i31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThLt5oXN6ToF4YKkt6FpXYxeDHP+cqmJLsZgthH2NCI=;
        fh=E2VorYSG7yb16+cxVsyRVMAaCgAP3Ft8r6adLIV4UB0=;
        b=cxBk9yx4wL1Or4yZ0dA0CU2jRyMCA2OQjcun6SdCX6m6UwTbI3yCi16wIfHxgXhjNn
         ctRfWhBEe3zc7TjcZ2KajoDC79w5NHV3hJkH5GyCePedybzAkggrYmXeOu2vQUwOIxrG
         DJz5tpzyXqVGPD1pDLMUxGptZmiZ5sq1nsNmU7pmOWfWDZEyPivJMPN9Z8b7elJjDBP8
         PLJlTl/rmx88hwKODiDJZt5PyCR91BSAXWwVVsQY8RveVPckZw3R9Nwtc9Jpbmrm4dmO
         TfueWLqQSe4zDbXrEyNGzQ18feFnD7eCOfu5HJo/LF57U993pO5DvJD/cUXTxXY1SLDc
         sAtQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789690619; x=1790295419; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThLt5oXN6ToF4YKkt6FpXYxeDHP+cqmJLsZgthH2NCI=;
        b=X9adxFaGXD24U5hZ0IXYZ4skfSsLLXkbXF6ZYY4H/ayuMf1Bk1sCQfL5hSkoq2wmjf
         qAwRKs87fF41aPbueuZSLBh+2ADIYUGgqgwTNSZ2v4ONZqa3yu/Fk3ulZopG7P14KlcO
         Bd5nm1lEWLN1EcebU8JQ5SQrh7RW7aZwr8eqvdVerAOvQfI0fLRg+X0Xz0dQAdp5W6+z
         lbIRDy1ke8hFin3wtNyMcVjQp3esiktx/mOQSxpmikBz+7OVRxvmpb5OtjSiM3+iXo+u
         qmYXPK0BsRxeDHODoaAFs90ApWK2y/dT63ftq0Fl3X4DZzDfAR9RrJLaFLeHGPvhneKX
         zj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789690619; x=1790295419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThLt5oXN6ToF4YKkt6FpXYxeDHP+cqmJLsZgthH2NCI=;
        b=eNM4d6W8y9OjTml89Or+p7yMeoUVgYPYjidF7gvaGF4pXbSpR6w76IrPgaFZ+/Bbvl
         EzD7I8KdbefmwxEeLnobi7Zy9HjSZOMu2+gKwhKJovD5Yj2xfwTiYRkM0He/+G0eCOEl
         a5dDCP76Z8+PJbAQRuMYcV/fqb9T2SKemMvuZZhKXi3gEBi/whGj+4fyHJyEksUPCzAi
         uHdVb9VHNwkTutKwadUZnERGx7m9YCGhWRZBhtCbti15NkFwsVd5RaS6+40WbM+c0muL
         7m1CndyLp6EekKhQyoP5Kw8L/1wx3WnKz5gKbjyl258dCUEcghZxBrCxNAE0VLNIbZ7F
         uQCw==
X-Forwarded-Encrypted: i=1; AKwUvBx/S6YppBfc49Dly/ZbHAW+/k6QzbkvzvvfSki9+KHcyj8mw5kiC3i3H6NNmKVQIGEd+IuDwDHFPzEHtVE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kR8+HkUKXZ1kruDv3a8/9+TDtyckaln76OShn2MlMXF4qn3Inu
	U2+KRvFjuecMRmts/71Z8MjFeJ19v7KTAc+qh9I5bzIjeJNJQkDDduzcUJgmlIzsig3rW16snY3
	mTacElsO+M4WyHrt0WMLcu66L/myWnHyqFwNT
X-Gm-Gg: AYBFou3MAuTmkHlxnGA9EgK+SmfE3gBoCQEYCW9PZgIZNqRJ7Sz1ERmzqHNxdICHA+8
	iJ9sOnA+LG12JPt8CIvNpbDqqx6zHZS+CrgZ++I/FxlwNHHuNotaD+/kIgdYqxupw45VqQomx1e
	HPEIPgmh/hK1Aw4ZwU4OFF71FfbFmIxo8FY/CZ4o4INddC4xZ5u0o9HrqAjF3K5WQIpvkBJgVQi
	KJ2bilXqOo8A2HtUmSjPHkGso5OMQyFcxGLMJPr3hsEwER3t2d1AWyk+A+Pojhd8lxpr4ve6IER
	eY7OOg9sQONYuzk5lM9WeWxGFUZ9arUblfVlD58R6kBWfPBIbaTKk9XSa/xMq9xFHrh2rZl4BNd
	gl+UC01jjWD9Mcxa0L70W5YM80B1IwGbvJ637oPuU7KNcQzdNcHuSriqw72ivbfl70hg/gVMzfS
	G1ZJh5FDE30VjIjExrvTaXSbG+Xn3zhV/Dpvv6uh7Pw0CO4I2Zt1SA00iF8QuJG83gPw==
X-Received: by 2002:a17:907:3e0f:b0:c27:420b:7c90 with SMTP id
 a640c23a62f3a-c2a1588651fmr79357066b.48.1789690618982; Thu, 17 Sep 2026
 17:16:58 -0700 (PDT)
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
References: <20260916224156.276511-1-rosenp@gmail.com> <aqtdmOzJSIawqKQq@SMW015318>
In-Reply-To: <aqtdmOzJSIawqKQq@SMW015318>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 17 Sep 2026 17:16:47 -0700
X-Gm-Features: AcwNN1WrOby4AFhx7As-4Zrve5ehCpdMlOHPijGBhqbyP_ojiIATGZuFFmx1ZbY
Message-ID: <CAKxU2N-gitgedS9ZJQ7wNV9Dma9PUwM+0NMY5yfVk2PvXOYASQ@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: bestcomm: use platform machinery to get irq
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>, 
	"moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 8:25=E2=80=AFPM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Wed, Sep 16, 2026 at 03:41:56PM -0700, Rosen Penev wrote:
> > platform_get_irq() avoids having to explicitly map and dispose of an ir=
q
> > by having the platform_device machinery take care of it.
> >
> > This requires replacing the device_node with a platform_device in the
> > bcom_eng struct so that platform_get_irq() can use it.
> >
> > Conveniently, this also allows getting rid of of_node_get and
> > of_node_put as the platform_device machinery also handles that.
> >
> > Replace the open-coded resource lookup, request_mem_region, ioremap and
> > the manual iounmap/release_mem_region cleanup in probe/remove with the
> > managed devm_platform_get_and_ioremap_resource() helper. This removes t=
he
>
> update commit message, no devm_platform_get_and_ioremap_resource() in pat=
ch.
>
> > now-unused error-unmap/release paths and simplifies the driver.
> >
> > Adjust the goto labels in bcom_task_alloc to match what is being freed.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: resend.
>
> If resend, don't pump version.
>
> Frank
> >  drivers/dma/bestcomm/bestcomm.c            | 47 ++++++++--------------
> >  include/linux/fsl/bestcomm/bestcomm_priv.h |  2 +-
> >  2 files changed, 18 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bes=
tcomm.c
> > index 241a91936fe8..1006030ff167 100644
> > --- a/drivers/dma/bestcomm/bestcomm.c
> > +++ b/drivers/dma/bestcomm/bestcomm.c
> > @@ -47,6 +47,7 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_s=
ize)
> >  {
> >       int i, tasknum =3D -1;
> >       struct bcom_task *tsk;
> > +     int irq;
> >
> >       /* Don't try to do anything if bestcomm init failed */
> >       if (!bcom_eng)
> > @@ -67,30 +68,32 @@ bcom_task_alloc(int bd_count, int bd_size, int priv=
_size)
> >       if (tasknum < 0)
> >               return NULL;
> >
> > +     irq =3D platform_get_irq(bcom_eng->pdev, tasknum);
> > +     if (irq < 0)
> > +             goto err1;
> > +
> >       /* Allocate our structure */
> >       tsk =3D kzalloc(sizeof(struct bcom_task) + priv_size, GFP_KERNEL)=
;
> >       if (!tsk)
> > -             goto error;
> > +             goto err1;
> >
> >       tsk->tasknum =3D tasknum;
> >       if (priv_size)
> >               tsk->priv =3D (void*)tsk + sizeof(struct bcom_task);
> >
> >       /* Get IRQ of that task */
> > -     tsk->irq =3D irq_of_parse_and_map(bcom_eng->ofnode, tsk->tasknum)=
;
> > -     if (!tsk->irq)
> > -             goto error;
> > +     tsk->irq =3D irq;
> >
> >       /* Init the BDs, if needed */
> >       if (bd_count) {
> >               tsk->cookie =3D kmalloc_array(bd_count, sizeof(void *),
> >                                           GFP_KERNEL);
> >               if (!tsk->cookie)
> > -                     goto error;
> > +                     goto err2;
> >
> >               tsk->bd =3D bcom_sram_alloc(bd_count * bd_size, 4, &tsk->=
bd_pa);
> >               if (!tsk->bd)
> > -                     goto error;
> > +                     goto err3;
> >               memset_io(tsk->bd, 0x00, bd_count * bd_size);
> >
> >               tsk->num_bd =3D bd_count;
> > @@ -99,17 +102,12 @@ bcom_task_alloc(int bd_count, int bd_size, int pri=
v_size)
> >
> >       return tsk;
> >
> > -error:
> > -     if (tsk) {
> > -             if (tsk->irq)
> > -                     irq_dispose_mapping(tsk->irq);
> > -             bcom_sram_free(tsk->bd);
> > -             kfree(tsk->cookie);
> > -             kfree(tsk);
> > -     }
> > -
> > +err3:
> > +     kfree(tsk->cookie);
> > +err2:
> > +     kfree(tsk);
> > +err1:
> >       bcom_eng->tdt[tasknum].stop =3D 0;
> > -
>
> avoid unnecesary change.
There's nothing unnecessary about this. irq_dispose_mapping goes away.
bcom_sram_free is a mistake here. It's not reachable after
bcom_sram_alloc. This is much clearer to look at.

Moving bcom_sram_free removal to its own commit is pointless churn.
>
> >       return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(bcom_task_alloc);
> > @@ -125,7 +123,6 @@ bcom_task_free(struct bcom_task *tsk)
> >       bcom_eng->tdt[tsk->tasknum].stop  =3D 0;
> >
> >       /* Free everything */
> > -     irq_dispose_mapping(tsk->irq);
> >       bcom_sram_free(tsk->bd);
> >       kfree(tsk->cookie);
> >       kfree(tsk);
> > @@ -377,16 +374,12 @@ static int mpc52xx_bcom_probe(struct platform_dev=
ice *op)
> >       if (IS_ERR(regs))
> >               return PTR_ERR(regs);
> >
> > -     /* Get the bestcomm node */
> > -     of_node_get(op->dev.of_node);
> > -
> >       /* Prepare SRAM */
> >       ofn_sram =3D of_find_matching_node(NULL, mpc52xx_sram_ids);
> >       if (!ofn_sram) {
> >               printk(KERN_ERR DRIVER_NAME ": "
> >                       "No SRAM found in device tree\n");
> > -             rv =3D -ENODEV;
> > -             goto error_ofput;
> > +             return -ENODEV;
> >       }
> >       rv =3D bcom_sram_init(ofn_sram, DRIVER_NAME);
> >       of_node_put(ofn_sram);
> > @@ -394,7 +387,7 @@ static int mpc52xx_bcom_probe(struct platform_devic=
e *op)
> >       if (rv) {
> >               printk(KERN_ERR DRIVER_NAME ": "
> >                       "Error in SRAM init\n");
> > -             goto error_ofput;
> > +             return rv;
> >       }
> >
> >       /* Get a clean struct */
> > @@ -405,8 +398,7 @@ static int mpc52xx_bcom_probe(struct platform_devic=
e *op)
> >       }
> >
> >       /* Save the node */
> > -     bcom_eng->ofnode =3D op->dev.of_node;
> > -
> > +     bcom_eng->pdev =3D op;
> >       bcom_eng->regs =3D regs;
> >       bcom_eng->regs_base =3D res_bcom->start;
> >
> > @@ -426,8 +418,6 @@ static int mpc52xx_bcom_probe(struct platform_devic=
e *op)
> >       kfree(bcom_eng);
> >       bcom_eng =3D NULL;
> >       bcom_sram_cleanup();
> > -error_ofput:
> > -     of_node_put(op->dev.of_node);
> >
> >       printk(KERN_ERR "DMA: MPC52xx BestComm init failed !\n");
> >
> > @@ -443,9 +433,6 @@ static void mpc52xx_bcom_remove(struct platform_dev=
ice *op)
> >       /* Cleanup SRAM */
> >       bcom_sram_cleanup();
> >
> > -     /* Release the node */
> > -     of_node_put(bcom_eng->ofnode);
> > -
> >       /* Release memory */
> >       kfree(bcom_eng);
> >       bcom_eng =3D NULL;
> > diff --git a/include/linux/fsl/bestcomm/bestcomm_priv.h b/include/linux=
/fsl/bestcomm/bestcomm_priv.h
> > index 3b52f3ffbdf8..cddde7c74cb5 100644
> > --- a/include/linux/fsl/bestcomm/bestcomm_priv.h
> > +++ b/include/linux/fsl/bestcomm/bestcomm_priv.h
> > @@ -66,7 +66,7 @@ struct bcom_tdt {
> >   * This holds all info needed globaly to handle the engine
> >   */
> >  struct bcom_engine {
> > -     struct device_node              *ofnode;
> > +     struct platform_device          *pdev;
> >       struct mpc52xx_sdma __iomem     *regs;
> >       phys_addr_t                      regs_base;
> >
> > --
> > 2.55.0
> >

