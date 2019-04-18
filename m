Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D80C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:18:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8235214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pM313Ela"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8235214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lTRX1xtRzDqT4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 05:18:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pM313Ela"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lTPp62TCzDqSF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 05:17:18 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id y6so1611038plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9IOoh+ojDuOZjVJx3eBsChtB80YQzisCQ5BSvwFzh/E=;
 b=pM313ElaIaqfLREkQdN71i43sENBBL14DMtrQ401ZHsZrlUFjq17dH5XS2k76YBGM9
 eh1lo7tRwf3QImePjxUFYK0Ldvn1fgzSwMJDGypDP1Ng3zoal4gh4fY+XHSYkNNNgcI5
 s03YG1Rb1gS/VEt+CyozsQ5gWWqaUf5K+WbdRUuL5ZPlqu9y51cwMo7OP6bjeQ4jIoHL
 pANxsPi+UzOO6CCPpbDYlGA+1oGiLsie/QU2b8XajhBE1iKY45y3MfNPvnisVvbAClEX
 h5ul4fLk5AK/IY8GdYdKISm97xYphKVeCXDWfGWjKCvEErKVtuoEJj/7tOuzIWTHBVvx
 LYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9IOoh+ojDuOZjVJx3eBsChtB80YQzisCQ5BSvwFzh/E=;
 b=LP8e9kKCkul9T3nlCGVjwsuINnpdTTKfpitFYKoy3hcdSqh/h0KadwSuLZfqnr+nMR
 QWobl1hK7R2E6Ze3EnkPDQDIvR8Hh0jt1V7gF1iWBdiDk9MuvJ5UvQXnY2pu7FPVPnz+
 eaLwdIy3uzwgzg16oaK3I6M3N7jYqvH/Yyj2OWghRez2pYenXIx08p9vo8K6oxdyk5cU
 o+GOYnfsgwf71xt48Cd8jSfcAbOz0CBepRqKUKVl6t/BS4cl/iHuEhcMa3tpRFBMfYRW
 RsY25Hlj+wlyAJWfXBE0gRSLGiBRZSwQSseg3PuYTgxqGJ2Wl799CHq6XMtH2SlazVFA
 kAGA==
X-Gm-Message-State: APjAAAWnkpgDoNwPQXJBg0kAsKWOXDxBygPkAiJBd3L9blzu7q78+HXY
 QaHBykPfC7UAlAPA9Z/dI+Y=
X-Google-Smtp-Source: APXvYqxYBLCdan6vFoVsKEPBO+mBYiuomX4BdL/gbjarMJpuAQotjUwCG0p8kWR90D39M8W89YntYg==
X-Received: by 2002:a17:902:28e9:: with SMTP id
 f96mr74984901plb.190.1555615035057; 
 Thu, 18 Apr 2019 12:17:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id o67sm3397539pga.55.2019.04.18.12.17.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Apr 2019 12:17:14 -0700 (PDT)
Date: Thu, 18 Apr 2019 12:17:09 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190418191708.GA14885@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB6479228E9CAE2A432D904BC7E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6479228E9CAE2A432D904BC7E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 18, 2019 at 09:37:06AM +0000, S.j. Wang wrote:
> > > > And this is according to IMX6DQRM:
> > > >     Limited support for the case when output sampling rates is
> > > >     between 8kHz and 30kHz. The limitation is the supported ratio
> > > >     (Fsin/Fsout) range as between 1/24 to 8
> > > >
> > > > This should cover your 8.125 condition already, even if having an
> > > > outrate range between [8KHz, 30KHz] check, since an outrate above
> > > > 30KHz will not have an inrate bigger than 8.125 times of it, given
> > > > the maximum input rate is 192KHz.
> > > >
> > > > So I think that we can just drop that 8.125 condition from your
> > > > change and there's no need to error out any more.
> > > >
> > > No, if outrate=8kHz,  inrate > 88.2kHz, these cases are not supported.
> > > This is not covered by
> > >
> > >         if ((outrate > 8000 && outrate < 30000) &&
> > >             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > 
> > Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz) in the
> > code. Then I think the fix should be at both lines:
> > 
> > -         if ((outrate > 8000 && outrate < 30000) &&
> > -             (outrate/inrate > 24 || inrate/outrate > 8)) {
> > +         if ((outrate >= 8000 && outrate =< 30000) &&
> > +             (outrate > 24 * inrate || inrate > 8 * outrate)) {
> > 
> > Overall, I think we should fix this instead of adding an extra one, since it is
> > very likely saying the same thing.
> 
> Actually if outrate < 8kHz, there will be issue too.

Here is the thing, the RM doesn't explicitly state that ASRC can
support a lower output sample rate than 8KHz. And I actually had
a concern when reviewing your PATCH-2, as the table of supported
output sample rate no longer matches RM.

If you've verified a lower output sample rate working solid with
the process_option function, that means our driver can go beyond
the limitation mentioned in the RM, then I believe [8KHz, 32KHz]
should be updated too -- that says we can do:
-	if ((outrate > 8000 && outrate < 30000) &&
-	    (outrate/inrate > 24 || inrate/outrate > 8)) {
+	if ((outrate >= 5512 && outrate =< 30000) &&
+	    (outrate > 24 * inrate || inrate > 8 * outrate)) {

Actually "ourate > 24 * inrate" is kind of pointless for range
[5KHz, 32KHz] but we can keep it since it matches RM.
