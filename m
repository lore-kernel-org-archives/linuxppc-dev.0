Return-Path: <SRS0=VNWk=56=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC526C2BA2B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 03:15:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DF52072A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 03:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1z2pTrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DF52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491VwJ0B2RzDqCs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 13:14:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=l1z2pTrK; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491VbM6wQ1zDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2020 13:00:15 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id t40so4630778pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2020 20:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bmrBJGYvPULTYsXID1n2ssFRwyCJcPGlCp+ffDZ2ue8=;
 b=l1z2pTrKK/Z24bQCWju9hYO5K6LvWpD5DCoSXiSBLwZQZhhqLNJWoTKQgkoRKDgqvS
 fGfrn44Syk3yqgAQT+0OHNxD38qhIvqRmOcHX2AIf/pJBV9I4jsBWyuIigF4kB57t1F5
 kkNWOJUdpFxyY8Z8j1+sJh7FDdYpGVtUV1tG0X0B1BFMhGwROxgCbFiuwXhyYrcC6NU+
 bquTjcpxjVMjaVjEnodWHqImGRm0YaH9oPuWfSFC4fMFcoSTo3Qd3dATP64+4irVrKYk
 Qr6a18t9b/XMXEruEs0P1w1FaiNO+ZI9ha7UQIbZWSfK0rRfKPOVy3b15IvbvjWy0LOA
 96ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bmrBJGYvPULTYsXID1n2ssFRwyCJcPGlCp+ffDZ2ue8=;
 b=e7PZoRiDPEs+w2W5kvkdwfhVqY/6VbAIGESUzyeBw2TIUayw1z9KKeHJ+eJ4LGXxUX
 8I76xGT/rCczi00STHPqVR5n1RVXOP/okSzi+z1tw09Z2lCYqaZS+tjKdi+6F9YA19d1
 XFKc21NLZY8XFrA1qeE7MFczafTF90e/0rYWjKuP7/JClYNeKrWeFSBpSTm29TmRvnNk
 RbtueS1mFLRR69HU5aRW74QYCzosjUEYnwSCwwAj7MvVq0G8elt8w3sx5BmgNw2NOec/
 cyPgyzM0fPhgiISGliHPXYME3yKiY9l0vfa7zoqBah+WKR1DMDBOjTPJxfD2X5fE6H4w
 P8uA==
X-Gm-Message-State: AGi0PubMON/cpXknnZ/JpHfR4PzB+KtTR32ex3HKcZqP4rof2LK4ya1m
 jvty/E8bL/lqP0jzmplyXps=
X-Google-Smtp-Source: APiQypKXuSLr1DLchZKjuBPOYZJBPpmlryaYyd6OhlIzheb4f5k8FxOq0gGgnslC+hA8mdo0s8KKyw==
X-Received: by 2002:a17:90a:6043:: with SMTP id
 h3mr6406198pjm.69.1586833209564; 
 Mon, 13 Apr 2020 20:00:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id c84sm1464971pfb.153.2020.04.13.20.00.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Apr 2020 20:00:09 -0700 (PDT)
Date: Mon, 13 Apr 2020 20:00:17 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v7 5/7] ASoC: fsl_asrc: Move common definition to
 fsl_asrc_common
Message-ID: <20200414030017.GA10719@Asurada-Nvidia.nvidia.com>
References: <cover.1586747728.git.shengjiu.wang@nxp.com>
 <6d2bed91bcdbc3f75a9d12ac4ebf6c34c9bb9c3f.1586747728.git.shengjiu.wang@nxp.com>
 <20200414020748.GB10195@Asurada-Nvidia.nvidia.com>
 <CAA+D8AN8OUtTftc_So-Z0_sjWt4RXq6fr4GpSy3Xh+YbkryfpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AN8OUtTftc_So-Z0_sjWt4RXq6fr4GpSy3Xh+YbkryfpQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 14, 2020 at 10:21:29AM +0800, Shengjiu Wang wrote:
> On Tue, Apr 14, 2020 at 10:09 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Tue, Apr 14, 2020 at 08:43:07AM +0800, Shengjiu Wang wrote:
> > > There is a new ASRC included in i.MX serial platform, there
> > > are some common definition can be shared with each other.
> > > So move the common definition to a separate header file.
> > >
> > > And add fsl_asrc_pair_priv and fsl_asrc_priv for
> > > the variable specific for the module, which can be used
> > > internally.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > +static size_t fsl_asrc_get_pair_priv_size(void)
> > > +{
> > > +     return sizeof(struct fsl_asrc_pair_priv);
> > > +}
> >
> > Perhaps we haven't understood completely each other's point.
> >
> > Yet, would the following change work?
> 
> Should work, almost same

Function call involving branch instruction may fail CPU's branch
prediction and hurt performance, depending on the CPU arch. If a
variable simply does the job, we should avoid doing that.

> or do you want me to use variable to replace function pointer?

Yes. And please add my ack once you change it as the reset LGTM:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
