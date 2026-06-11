Return-Path: <linuxppc-dev+bounces-22511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87238CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 16:30:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbp6g72fkz2y8h;
	Fri, 12 Jun 2026 02:30:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781195451;
	cv=pass; b=ZIpJx01c/hu/CDjRI6P4tuCLm9PGqFRqiVp6KZw4huqWPAAi8jIYDp73gPsKr0MbaDaInzPf+SgTATuI3Wk+S5ssmQx9OwVH0g38y5oljOlU5WW4WwNmhnxIkGeVieThmWlhy76lLr0ZOc/6KefnmZnfZJtWqjqqOY+92JAYyRfssq+vzlMlvht1BG2gIr9UCPu1HSZ4kvGdyXi6kcX04BM4nVS3tf4x3seiWD1jMH6nB03CZ4yaYfd0Tst5Ufg1XXuIV3Znb1N7liCFlQheWKNs1rih0dJddMehCPuo0yjdPEAbiruXnwmWtQa4vCCDBmtuqMWuzoF2Ch58nZ6Ong==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781195451; c=relaxed/relaxed;
	bh=iheKOWFdtwPumeqiSxQOmmhC5dJ1TWCtS8vJVMwePJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W07jRHwk2Vf4NlCNiMjwXSJa4CcGwnbXH6E1KkPyui4CfRhiOOqM4MiUM05ErCyE1zRB+3eUwKn7YU5eJdakYyZycJwkwazsTMAP84pTA2lF2iwia/NGk+Alu8aM/sLj0qJMWeRx/cpFeKXIEpqksYxgmpa0EM7xKNUmv4b7yddYxoFSgQvB1/+cvcgIyisuXA0gN0FI66eWU2/psjGvoSmoJfXxm9ZFwv3wOnFt+jwufyNv2vHlONU8qbeR5/MYQn0LtiViJsCWRV2IgZKLRSffq6RWJm0enLRWlmb7dHM4c8pTyP3y0DPV5ahtMLzwoI6drHhpIv3q0Xg8NOP2Zw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4vStlFv; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4vStlFv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbp6d67Kjz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 02:30:49 +1000 (AEST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so38019a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 09:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781195446; cv=none;
        d=google.com; s=arc-20240605;
        b=M5FjIoP3/hh0ZjvHXtDzZ47wes5ey60npau1M9YcXw+2hNmV4mAw/2X36oLtgPzp/X
         3f+GCL7odn7b7H08I9557cJ6w+uqJ1GZq4lPVvb4lkaAgGwoZ+oeGSrR9AJy3++XOogT
         3xOp2MMz4VdzUBvJ2DNbWDQ8bF0BO/yOqjGAb2TjJ64BMnWACWFk9G/gd+8vyvrEmr+f
         c8T44OJx6krNSuNCrBZNJrCHM3sWZHdkVYzUICXGrB5bYCgQJDOBMT9nGPRhe1uriP78
         MGS2UoN+stkiZ4lvW7Skgmtzq5CpIIo0nP+IxVo9KpsnKeYJd7lXjt00hqW+nkhr41gp
         ZPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iheKOWFdtwPumeqiSxQOmmhC5dJ1TWCtS8vJVMwePJg=;
        fh=MT2ImugU7EMFKcZijz36XFauF4neLSqp0wgrMhyt+ac=;
        b=GrYvJ83Y1oQzlwOvsgBXB+nYlYsj1kVPxd93insw+PEdMp1ZKexgsZmSIW7VkLgCVQ
         yA4aDAplsHquVAX6KcB4J4zQw3eE8lIOGLHtpFUBW4m5u+76gOZNGxwYMlxFpWJTkhSo
         WcRw8B77c6kzWw2YxC6W+DuU/hiKUVlm/DOHfRmRrPCJ8eGvfv9sSSEFcFij6PeH+6UA
         hLKPXpUTQAyyCz1a44m4kIFXXhrnR7gf3luBh2Sv10k6z+jjq3uaOePw5GlzNnLon4XB
         jgV2XGlnSFXewuspIiadPV9MYoKAmxyCNAi8EWrpAZcm2THiT55nKj0MC2Ov4CmQeELQ
         xejw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195446; x=1781800246; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iheKOWFdtwPumeqiSxQOmmhC5dJ1TWCtS8vJVMwePJg=;
        b=Z4vStlFvgqLoIZk5xeLi+h6ChcYaJeiUEzXi9kaJ/nN8KoXuio3ylkmT0adlh+mbH9
         qE/lkbs7ZmrELDm75hMY9BLUowYINoumsF+UXqL1wYS810JoxU3uC9IJyrj0o4O6Dg28
         Sfwi5du1Toq5Z6oJWVC9tVF1cgW2v1a9KBWh5JMZgUJQhmxJTOBy4xJOgtkQV5+XXLdn
         csTZLz3af9DzE5FvPkIWrgjTk9N6LaeoIMspAH/KDMzUm5lZ86H9Bz/T7+1Oh3IgSw8B
         /4XeEUSQj98kV7zfLib8G9tZt9tBno+FncEARnbSedMcKbNB0g6o/R5T5Q+tstynNCmU
         ULSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195446; x=1781800246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iheKOWFdtwPumeqiSxQOmmhC5dJ1TWCtS8vJVMwePJg=;
        b=TuJq0E/Lp6COhLduP/WOiZ0U9Tad4e/aC1fUhgNDCgjkxhpudIdLLnMsas11L8DCKY
         GS9/rnIqtfilIof3EOX50UpvhGHD+hyikfkN1LfgRw+thI9xKDpJP7Y0FizoaTiRBdSq
         EAnoZDKcvgRw1AURNvT8KJC/NIjAbKVCbyDhHMvkUzQZAvle2nXJELMMGnkfDcsXs4qI
         i/+25v8i0ZdtpZtt58fC1rvj9i8tvxewfOfFwq0XNexTjYIzYRTd4a0U8tf7jyalRusZ
         Fg2g5cKO/Z93dtZ+XKhvv17XjvrzeykJ8KzapxNgDo+Ri1GewQx/P1XnAOHQd76AZRnM
         Wt1w==
X-Forwarded-Encrypted: i=1; AFNElJ8J6kHWbR4AzK5qIP7TrzG6svyYyVEbEsX6TTeAX4z+r8JhdEd6/0W/L4X8wQbdT7YW9ck6+NOGoEWogBk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy9XwGzvLEJONWvAYg3T2+i7GvXUL8lJr4CBxA17SdlBXcnvQXJ
	9RPa2y7DvJJUvNiMBg8q8H5CrwVfL0ArR0unb9InNSX94IvcexUl+iAXwWjJnjwf7ORW/pVGh7E
	rk+sI1WzC1aEoVfEOf96HVBG9ZoIeRxo=
X-Gm-Gg: Acq92OHQXTTPASMhW4+b07hb6+MrjKQzBCAHXB3Zpj7VT5ouiEok3Bw6H18Min5llX7
	fxCiRftgWYj+/f6JkFfLSy/wfXJFfAWtRc+/1diBNjfdJsE7C2BEaNF6ehlv/IH4Kk1YUGxO+3I
	/obvPomTN+oS/ErrbDPko/oT7xb4nHpewSTvBkUtISkUG5TESsEqvTluzGbqBcz9FfGYphbGR4b
	46snCMjFXNNKwPT37+rr5eFU5a3jXoVZk61wcP9Ld5I9g6RvpKf475saDCpDGK0OX9DS+RtnsxO
	qLFCoqJRBBW83gA90SNfLeN7rUcEEGGM4njE6DEE+/oz/xhrMCIES3Gw53GJayVhGfHAk6TPd6y
	5ohOJPZeeuabCDURFNIrMqHSFVRrnM2OObZmC8+pJSlzCaaZPrNR71zzSfND6DZauodU=
X-Received: by 2002:a05:6402:1948:b0:687:819:545a with SMTP id
 4fb4d7f45d1cf-6930e438b2emr1819681a12.25.1781195446025; Thu, 11 Jun 2026
 09:30:46 -0700 (PDT)
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
References: <20260611035245.13439-1-rosenp@gmail.com> <20260611035245.13439-3-rosenp@gmail.com>
 <airSHmdtCg5yWn0X@lizhi-Precision-Tower-5810>
In-Reply-To: <airSHmdtCg5yWn0X@lizhi-Precision-Tower-5810>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 11 Jun 2026 09:30:34 -0700
X-Gm-Features: AVVi8CeqeKhQJh1oE_uJdumUn9r0WFmAfFwWPafkU5F8prKElzOIcB4MnkuaMOg
Message-ID: <CAKxU2N9bMeuOKBDOXB=bFFkiNTZh-ZQFE6CSC5FZ_p6ygo9zZw@mail.gmail.com>
Subject: Re: [PATCHv4 02/15] dmaengine: fsldma: drop desc_lock before invoking
 client callback
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:20=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Wed, Jun 10, 2026 at 08:52:32PM -0700, Rosen Penev wrote:
> > fsldma_run_tx_complete_actions() calls dmaengine_desc_get_callback_invo=
ke()
> > while still holding chan->desc_lock.  If the client submits a new
> > transaction from their completion callback, fsl_dma_tx_submit()
> > tries to acquire the same non-recursive spinlock, causing a
> > self-deadlock.
> >
> > Fix by extracting the callback info under the lock, removing the
> > descriptor from ld_running, dropping the lock, then invoking the
> > callback and running dependencies outside the lock.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/dma/fsldma.c | 108 ++++++++++++++++++++++---------------------
> >  1 file changed, 55 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > index 0e2f84862261..455d21d738de 100644
> > --- a/drivers/dma/fsldma.c
> > +++ b/drivers/dma/fsldma.c
> > @@ -496,16 +496,19 @@ static void fsldma_clean_completed_descriptor(str=
uct fsldma_chan *chan)
> >  }
> >
> >  /**
> > - * fsldma_run_tx_complete_actions - cleanup a single link descriptor
> > + * fsldma_run_tx_complete_actions - unmap and extract callback from a =
descriptor
> >   * @chan: Freescale DMA channel
> > - * @desc: descriptor to cleanup and free
> > + * @desc: descriptor to process
> >   * @cookie: Freescale DMA transaction identifier
> > + * @cb: returned callback information
> >   *
> > - * This function is used on a descriptor which has been executed by th=
e DMA
> > - * controller. It will run any callbacks, submit any dependencies.
> > + * Unmap the descriptor if it has been submitted and extract its callb=
ack
> > + * into @cb.  The caller must invoke the callback and run dependencies
> > + * after releasing chan->desc_lock.
> >   */
> >  static dma_cookie_t fsldma_run_tx_complete_actions(struct fsldma_chan =
*chan,
> > -             struct fsl_desc_sw *desc, dma_cookie_t cookie)
> > +             struct fsl_desc_sw *desc, dma_cookie_t cookie,
> > +             struct dmaengine_desc_callback *cb)
> >  {
> >       struct dma_async_tx_descriptor *txd =3D &desc->async_tx;
> >       dma_cookie_t ret =3D cookie;
> > @@ -514,49 +517,14 @@ static dma_cookie_t fsldma_run_tx_complete_action=
s(struct fsldma_chan *chan,
> >
> >       if (txd->cookie > 0) {
> >               ret =3D txd->cookie;
> > -
> >               dma_descriptor_unmap(txd);
> > -             /* Run the link descriptor callback function */
> > -             dmaengine_desc_get_callback_invoke(txd, NULL);
> >       }
> >
> > -     /* Run any dependencies */
> > -     dma_run_dependencies(txd);
> > +     dmaengine_desc_get_callback(txd, cb);
> >
> >       return ret;
> >  }
> >
> > -/**
> > - * fsldma_clean_running_descriptor - move the completed descriptor fro=
m
> > - * ld_running to ld_completed
> > - * @chan: Freescale DMA channel
> > - * @desc: the descriptor which is completed
> > - *
> > - * Free the descriptor directly if acked by async_tx api, or move it t=
o
> > - * queue ld_completed.
> > - */
> > -static void fsldma_clean_running_descriptor(struct fsldma_chan *chan,
> > -             struct fsl_desc_sw *desc)
> > -{
> > -     /* Remove from the list of transactions */
> > -     list_del(&desc->node);
> > -
> > -     /*
> > -      * the client is allowed to attach dependent operations
> > -      * until 'ack' is set
> > -      */
> > -     if (!async_tx_test_ack(&desc->async_tx)) {
> > -             /*
> > -              * Move this descriptor to the list of descriptors which =
is
> > -              * completed, but still awaiting the 'ack' bit to be set.
> > -              */
> > -             list_add_tail(&desc->node, &chan->ld_completed);
> > -             return;
> > -     }
> > -
> > -     dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
> > -}
> > -
> >  /**
> >   * fsl_chan_xfer_ld_queue - transfer any pending transactions
> >   * @chan : Freescale DMA channel
> > @@ -635,22 +603,23 @@ static void fsl_chan_xfer_ld_queue(struct fsldma_=
chan *chan)
> >   */
> >  static void fsldma_cleanup_descriptors(struct fsldma_chan *chan)
> >  {
> > -     struct fsl_desc_sw *desc, *_desc;
> > +     struct fsl_desc_sw *desc;
> >       dma_cookie_t cookie =3D 0;
> >       dma_addr_t curr_phys =3D get_cdar(chan);
> >       int seen_current =3D 0;
> >
> >       fsldma_clean_completed_descriptor(chan);
> >
> > -     /* Run the callback for each descriptor, in order */
> > -     list_for_each_entry_safe(desc, _desc, &chan->ld_running, node) {
> > -             /*
> > -              * do not advance past the current descriptor loaded into=
 the
> > -              * hardware channel, subsequent descriptors are either in
> > -              * process or have not been submitted
> > -              */
> > -             if (seen_current)
> > -                     break;
> > +     /*
> > +      * Take descriptors one at a time from the front of the running
> > +      * queue.  We re-read the list each iteration so that we don't
> > +      * chase a stale next pointer across the lock-drop below.
> > +      */
> > +     while (!seen_current && !list_empty(&chan->ld_running)) {
> > +             struct dmaengine_desc_callback cb;
> > +
> > +             desc =3D list_first_entry(&chan->ld_running,
> > +                                     struct fsl_desc_sw, node);
> >
> >               /*
> >                * stop the search if we reach the current descriptor and=
 the
> > @@ -662,9 +631,42 @@ static void fsldma_cleanup_descriptors(struct fsld=
ma_chan *chan)
> >                               break;
> >               }
> >
> > -             cookie =3D fsldma_run_tx_complete_actions(chan, desc, coo=
kie);
> > +             cookie =3D fsldma_run_tx_complete_actions(chan, desc, coo=
kie, &cb);
> >
> > -             fsldma_clean_running_descriptor(chan, desc);
> > +             /*
> > +              * Remove from the running list before dropping the lock =
so
> > +              * that terminate_all cannot free this descriptor while w=
e
> > +              * call into the client below.
> > +              */
> > +             list_del(&desc->node);
> > +
> > +             /*
> > +              * Prevent dma_run_dependencies() from calling
> > +              * fsl_chan_xfer_ld_queue() while we are not holding the
> > +              * lock.  That would splice pending descriptors into
> > +              * ld_running before they have been completed by hardware=
.
> > +              * fsl_chan_xfer_ld_queue at the end of this function wil=
l
> > +              * re-evaluate the situation.
> > +              */
> > +             chan->idle =3D false;
> > +
> > +             /*
> > +              * Drop the lock before invoking the client callback, sin=
ce
> > +              * the DMAengine API explicitly allows clients to submit =
new
> > +              * transactions from their completion callback.  Otherwis=
e
> > +              * we self-deadlock on chan->desc_lock.
> > +              */
> > +             spin_unlock(&chan->desc_lock);
> > +             dmaengine_desc_callback_invoke(&cb, NULL);
> > +             dma_run_dependencies(&desc->async_tx);
> > +             spin_lock(&chan->desc_lock);
>
> Not sure if you have hardware to test it. This change is quite big. Gener=
ally,
> keep desc_lock and move these complete queue,  defer to tasklet or workqu=
eue
> run callback in in complete queue by hold complete queue's lock.
I do not. And because it is quite big, I will drop it.
>
> > +
> > +             chan->idle =3D true;
> > +
> > +             if (!async_tx_test_ack(&desc->async_tx))
> > +                     list_add_tail(&desc->node, &chan->ld_completed);
> > +             else
> > +                     dma_pool_free(chan->desc_pool, desc, desc->async_=
tx.phys);
>
> desc already removed from list, needn't hold desc_lock, you can move it
> just before spin_lock()
>
> You should use difference lock for ld_completed.
>
> Frank
>
> >       }
> >
> >       /*
> > --
> > 2.54.0
> >

