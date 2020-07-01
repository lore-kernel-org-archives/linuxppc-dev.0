Return-Path: <SRS0=cW2d=AM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE9FC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 13:34:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A7E20702
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwunnEyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A7E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49xhzD5JzRzDr0y
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 23:34:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::441;
 helo=mail-wr1-x441.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WwunnEyp; dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49xhvl0V6hzDqxs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2020 23:31:30 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id z13so23851135wrw.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2020 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=lq1WgfFmu61MO0/hvCR2LLZLBy3Uwi0n25/FVtw+Y/w=;
 b=WwunnEypi/tYVE2V155Ye9Rh/r/EYrbOmZ5Ze7uXWdwNLTMxsDt+qmLlvLGzUf/5wn
 MhBJOLsvSF5a4nAEjB89oHQzzesPsj/X5sUyOA6HIGjvfowcx4ONyiJJHWvh+3XFrqnW
 Kv8q3fGn2B2XZXcGKOiJh64bHNs/oX5yMAXtC5i+K/YezXsslIdWBt0u63pG8mxFuUb0
 gNSmzAQuFS++PNyNJzbGRvD9mqKCqjASXLBDWRfli/qSckBNiJBb/JluRE1l9aB9wAvw
 0UJv7QMdbnhhbROFzoqV8VgD3Dq9jXUi7ethv9LhVGDhMNZs9AIh5KN5OrQRR3YBili8
 lyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lq1WgfFmu61MO0/hvCR2LLZLBy3Uwi0n25/FVtw+Y/w=;
 b=ono6HE0a6yj0gbMA2ICVbyH/fToG4cpSi2Q9LCksPMhNN1ow2n83U1rsnnHh3PWDin
 ge6NVdAL/rQgKT9EjCgbziD/tLjD/AMltlhGVd67me2awHRs/VeLJnG/MusPK11myuQi
 HIb0DciitpQPlTeBXXujCA9A9aoThhcmF/rAvWpiByD3//85Lt6+Eki9rFfbqwZQLUWE
 4tUXxyU9xq2WPE54exdjMoSZEg6nN/ui0U6IOk0DCDkwNEJBaCUK43sWHaAR3gT1H8Hq
 7R4CNZ5yAJUdrOAQ5aAfgITO0Sct5WBJSplgYftiJipRU15GHSTUbPeQ5lozQNOTyyeq
 7lyA==
X-Gm-Message-State: AOAM5311ALCLZn9NUggi3r/m1j+nYIasrZOdDksPSmNdPgBzB/uHh0G/
 WspVhKXZWzD30UKn2lRqeTDrrQ==
X-Google-Smtp-Source: ABdhPJwhdkzScuksrLgsGHtd1S+LMC2f5NlZILsVEvoZFQRAUH3Vi/kjs90CM8WPKDtHvgXwrhb6kA==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr25800533wro.422.1593610286355; 
 Wed, 01 Jul 2020 06:31:26 -0700 (PDT)
Received: from dell ([2.27.35.144])
 by smtp.gmail.com with ESMTPSA id t15sm7332266wmj.14.2020.07.01.06.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:31:25 -0700 (PDT)
Date: Wed, 1 Jul 2020 14:31:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 30/30] misc: cxl: flash: Remove unused pointer
Message-ID: <20200701133123.GF1179328@dell>
References: <20200701083118.45744-1-lee.jones@linaro.org>
 <20200701083118.45744-31-lee.jones@linaro.org>
 <20200701131357.GA2298198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701131357.GA2298198@kroah.com>
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de,
 Andrew Donnellan <ajd@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 01 Jul 2020, Greg KH wrote:

> On Wed, Jul 01, 2020 at 09:31:18AM +0100, Lee Jones wrote:
> > The DRC index pointer us updated on an OPCODE_ADD, but never
> > actually read.  Remove the used pointer and shift up OPCODE_ADD
> > to group with OPCODE_DELETE which also provides a noop.
> > 
> > Fixes the following W=1 kernel build warning:
> > 
> >  drivers/misc/cxl/flash.c: In function ‘update_devicetree’:
> >  drivers/misc/cxl/flash.c:178:16: warning: variable ‘drc_index’ set but not used [-Wunused-but-set-variable]
> >  178 | __be32 *data, drc_index, phandle;
> >  | ^~~~~~~~~
> > 
> > Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> > Cc: Andrew Donnellan <ajd@linux.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/misc/cxl/flash.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
> > index cb9cca35a2263..24e3dfcc91a74 100644
> > --- a/drivers/misc/cxl/flash.c
> > +++ b/drivers/misc/cxl/flash.c
> > @@ -175,7 +175,7 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
> >  	struct update_nodes_workarea *unwa;
> >  	u32 action, node_count;
> >  	int token, rc, i;
> > -	__be32 *data, drc_index, phandle;
> > +	__be32 *data, phandle;
> >  	char *buf;
> >  
> >  	token = rtas_token("ibm,update-nodes");
> > @@ -206,15 +206,12 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
> >  
> >  				switch (action) {
> >  				case OPCODE_DELETE:
> > +				case OPCODE_ADD:
> >  					/* nothing to do */
> >  					break;
> >  				case OPCODE_UPDATE:
> >  					update_node(phandle, scope);
> >  					break;
> > -				case OPCODE_ADD:
> > -					/* nothing to do, just move pointer */
> > -					drc_index = *data++;
> > -					break;
> 
> I think this is not correct, as *data++ changes the value there, and so
> this changes the logic of the code.

Great spot.

Looks like I overlooked that the pointer itself is being incremented.

> Dropping this one from my queue.

Sounds good.

I'll fix-up and send this separately at a later date.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
