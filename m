Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x236.google.com (mail-pg0-x236.google.com
 [IPv6:2607:f8b0:400e:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKYV73bm9zDr6n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 11:03:42 +1100 (AEDT)
Received: by mail-pg0-x236.google.com with SMTP id s9so5380373pgq.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 16:03:42 -0800 (PST)
Date: Sun, 14 Jan 2018 16:03:38 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v2 04/16] ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
Message-ID: <20180115000337.GB2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-5-git-send-email-nicoleotsuka@gmail.com>
 <6dd7d3e8-4673-c56d-c0ce-80df1f537f9b@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6dd7d3e8-4673-c56d-c0ce-80df1f537f9b@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 14, 2018 at 11:34:37PM +0100, Maciej S. Szmigiero wrote:

> > +	/* Check if the opposite stream is active */
> > +	aactive = ssi->streams & BIT(!dir);
> 				     ^
> Here an implicit assumption that either RX == 0, TX == 1 or
> RX == 1, TX == 0 still remains.

I would try to get rid of this !dir. However the regvals is
defined as regvals[2] so this assumption (either RX == 0 or
TX == 0) doesn't look wrong to me. I would prefer to add a
comment to limit a potential modification to RX and TX.
