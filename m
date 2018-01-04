Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCJ8q4K5PzDqvS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 06:42:03 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id u19so1182940pfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 11:42:03 -0800 (PST)
Date: Thu, 4 Jan 2018 11:42:14 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v1 03/15] ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
Message-ID: <20180104194213.GC27975@Asurada-Nvidia>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-4-git-send-email-nicoleotsuka@gmail.com>
 <7509f512-1c7f-2fd2-e127-510106e2d9d5@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7509f512-1c7f-2fd2-e127-510106e2d9d5@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 01, 2018 at 10:29:24PM +0100, Maciej S. Szmigiero wrote:

> > @@ -445,16 +445,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
> >  	bool tx = &ssi->regvals[TX] == vals;

> > +	/* Check if the opposite stream is active */
> > +	aactive = ssi->streams & BIT(!tx);
> 
> I don't think that hardcoding an implicit assumption here that RX == 0,
> TX == 1 is a good thing.
> If in the future, for any reason, somebody changes values of these macros
> this code will silently break.
> 
> I would instead change this line into something like
> "aactive = ssi->streams & (tx ? BIT(RX) : BIT(TX));" or similar.

You have a point. I could add a "bool dir" to make it clear. Thanks.
