Return-Path: <SRS0=byMz=YS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D5CA9EA0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 06:57:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40F220867
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 06:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD7VplAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40F220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46zvzt14kkzDqZN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Oct 2019 17:56:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430;
 helo=mail-pf1-x430.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MD7VplAM"; 
 dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46zvxR4MgwzDqf9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2019 17:54:51 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id 205so939039pfw.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Oct 2019 23:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=m+VkYOgB7cCdSZGNDZmPasUQ1M1DmEk9SPAL9l8GP1A=;
 b=MD7VplAMSnE6eBcOxhBncJ1w7gZgL2vajru9wAqudsdqaQdHSjaosigKCexVhSgoKE
 Nq9j/jeyMN+LeTVVmmAoP0z/DFE4hUYz9NCVTZMKqbSqX+i3ZAtgwb7gGHg+p4X7+TEo
 3kiESUbManeemJ3xCExgKIBZWb6+cHq4shtvyoPft8qTN7pMtV8ZWbnQUD2XM4XdY7Rv
 loSwM9UinPzIrmZwAFqKpGadpFiLSvlbq7vDyppqk/Uv5sf04RsliKidoTQAgdRVtUfz
 RAZdpGYb6zsW5Uu31WIZHN9C6A5UeFjipvLod8tVE4H1EvCHExEQKbX315/EAQDHfeGM
 9Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=m+VkYOgB7cCdSZGNDZmPasUQ1M1DmEk9SPAL9l8GP1A=;
 b=uKKjYyUyIyu7droh7O7M89ln99Gg9UAGbC0eETBAjWJEXJaz8CvATx9gkXxuwllQTy
 r1I6Z/68eEiAaEPavyYzwe86/g7zDE7Y8oBVaf6sEd+7AgBE+OSyLJtC9F76w7kMoTiL
 COZ0ccbjxb2AFSk1zNzXm+jW3sv48BG2Elbrs0xCcMQnxUMK2NBDXqYcWIcdokwf6Tz4
 VCruK0kRyN806mIxDUVu5conL8vKYWDPEXeZdy2myUtsB9BAa4bbLDgXD1Ob9JBD6xV1
 8lbwqZ1JNhcP4JPCOEVFMUpx4BYol+rsJCXwnJoo37KOvo6AhCn0ocR8mMUgmJfSdgrv
 zJ8g==
X-Gm-Message-State: APjAAAUEbMQOhyoVdt4fZ98Qtms2yL10UidVLoAxALi2vBDyupb/icOA
 KTf6CaVmJH0WOHirfb02m+4=
X-Google-Smtp-Source: APXvYqwQ2i3psJ0yIsvpXC4E8x2YWCDuJQPZ1N62DtBq1Tv3B55wCjarX0d9MG67laCjyfLsu1WfCA==
X-Received: by 2002:a17:90a:fe04:: with SMTP id
 ck4mr2048608pjb.90.1571986487460; 
 Thu, 24 Oct 2019 23:54:47 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 d14sm1800708pfh.36.2019.10.24.23.54.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 23:54:47 -0700 (PDT)
Date: Thu, 24 Oct 2019 23:54:34 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: refine the setting of internal clock
 divider
Message-ID: <20191025065433.GA4632@Asurada>
References: <VE1PR04MB6479AC63FFE5D57B4E2C33D2E3650@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479AC63FFE5D57B4E2C33D2E3650@VE1PR04MB6479.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "perex@perex.cz" <perex@perex.cz>, "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 25, 2019 at 05:33:17AM +0000, S.j. Wang wrote:
> > > > > +             pair_err("The divider can't be used for non ideal mode\n");
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     /* Divider range is [1, 1024] */
> > > > > +     div[IN] = min_t(u32, 1024, div[IN]);
> > > > > +     div[OUT] = min_t(u32, 1024, div[OUT]);
> > > >
> > > > Hmm, this looks like we want to allow ideal ratio cases and p2p
> > > > cases to operate any way, even if the divider wasn't within the
> > > > range to get the in/out rates from the output clock?
> > >
> > > Yes. We still allow the p2p = true,  ideal = false.  Note that p2p is
> > > not Equal to ideal.
> > 
> > Got it.
> > 
> > Overall, I feel it's better to have a naming to state the purpose of using
> > ideal configurations without the IDEAL_RATIO_RATE setup.
> >         bool use_ideal_rate;
> > And we can put into the asrc_config structure if there's no major problem.
> > 
> 
> Asrc_config may exposed to user, I don't think user need to care about
> The using of ideal rate or not. 

Given that M2M could use output rate instead of ideal ratio rate
as well, it could be a configuration from my point of view. Yet,
we may just add it as a function parameter like you did, for now
to ease the situation, until we have such a need someday.

> 
> > So the condition check for the calculation would be:
> > +       if (ideal && config->use_ideal_rate)
> > +               rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
> > +       else
> > +               rem[OUT] = do_div(clk_rate, outrate);
> > +       div[OUT] = clk_rate;
> > 
> > And for that if (!ideal && div[IN]....rem[OUT]), I feel it would be clear to
> > have them separately, as the existing "div[IN] == 0"
> > and "div[OUT] == 0" checks, so that we can tell users which side of the
> > divider is out of range and what the sample rate and clock rate are.
> > 
> Do you mean need to combine this judgement with "div[IN] == 0"
> Or "div[OUT] == 0"?

Not necessarily. Could put in the else path so its error message
would be more ideal ratio configuration specific.

Thanks
