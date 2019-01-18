Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B31C07EBF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 19:49:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04BB2087E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 19:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXG6OU5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04BB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hBNn3vQxzDrDJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 06:49:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cXG6OU5J"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hBKQ1G0KzDrB8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 06:46:49 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id v28so6517396pgk.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Kn29sLFMXx3G4CrCmatwvsd8auD+1fo4FY1+dUUayIU=;
 b=cXG6OU5JZ/QRmjJr9jZVLwtZ9mb7Rh6d0Mtsy0dWY30fWn4Jh9BLVNoe2XQI5Ol8IJ
 Bm5ZBual3CWro+n989N/Uyxbjwzd27o0TMSLXB90NOZMp6eW82XV63/2mm8sCxNSrmDV
 S8HVD7v/ohZOKU8BNIkDqTJch7JNm6Hv8on/lpjylgz8x3hQYmRm3rgSsHetDytjzXH0
 +6uYeqqpCnq03DPajvc8W5neWTxCZO6xiehvHp1btYXUwk+OW4RwGDWMp71qofpTsSR6
 SZgxBXB4tDYG6jb9ykvuocDSFhT04SC3Y4LJgDC5zK8ms9OQX3bsf8pruqUIgm68LDid
 MK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Kn29sLFMXx3G4CrCmatwvsd8auD+1fo4FY1+dUUayIU=;
 b=FMCrOn7X1aFsd/JY/6zKKXEYG2HXBh1mZkjNe4hSqMaKfeIq7Ef17hxPZ1R+eBQSf5
 YWXOoGXF8NENuamLpMiZxL1FC3V90v7SRS7mXEk4CG5EZk+x1xxpyEfwqTuEeb3/OH1T
 l0GpZmOprf+2cDoiiyutmejRVHgKmNfs5BdQ5b8ohJHK0qh/f0n5Y8siJK8TDOg2E010
 35mmHQ/xauOxSyvhIEuiF/n9sJsI/9euLeJp3rhKbGEU9/Fk4MEUQVCiCjiE62KFRulG
 XQD2+OC9V/3Wl0JUQk3IJ3J2ahDihnq0rWRrQsyF3+Qb7hdQH/RbrHaIlD2xx22zF2Yj
 ZEQQ==
X-Gm-Message-State: AJcUukc8umrW902uYhtqJEdD/4mPh75XP+QGggOx+p18O9kT+SRveJHG
 CM+Zn2Xs6akajEXU3iIp2IM=
X-Google-Smtp-Source: ALg8bN6FVGRXVHCjPt/Qc84uE8i8UK0i5tZePHv+jOGKl+goE1w8A/klpO+Z2N5EkzkBzyk2ogr3FQ==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr8606380pgg.429.1547840807517; 
 Fri, 18 Jan 2019 11:46:47 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id n186sm7010514pfn.137.2019.01.18.11.46.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 18 Jan 2019 11:46:47 -0800 (PST)
Date: Fri, 18 Jan 2019 11:46:42 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus> <1547817384.11482.33.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547817384.11482.33.camel@nxp.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jan 18, 2019 at 01:16:24PM +0000, Viorel Suman wrote:
> > > 1. Moved "dais" node from machine driver DTS node to device driver
> > > DTS node
> > >   as suggested by Rob.
> > That was not what I suggested. You still have a virtual node which
> > looks to me to be unnecessary.
> 
> To me removing virtual node implies that AUDMIX machine driver (imx-
> audmix.c + virtual node) shall be removed and machine driver code
> merged into device driver (fsl_audmix.c + device node) - please let me
> know if my understanding is wrong.

We could use a non-DT configuration right? From the driver logic,
DT just registers a device corresponding to the machine driver so
that it can probe(). We could register one in fsl_audmix instead.
Please refer to how fsl_ssi registers the sound card device. The
machine driver can get audmix_np from the parent device pointer,
and I think that's all you need.

Or maybe someone else would provide a better way. But it'd work.
