Return-Path: <festevam@gmail.com>
Received: from mail-io0-x234.google.com (mail-io0-x234.google.com
 [IPv6:2607:f8b0:4001:c06::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D7EF1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 08:34:17 +1100 (AEDT)
Received: by mail-io0-x234.google.com with SMTP id d63so156029373ioj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Feb 2016 13:34:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56AFCE8D.70804@maciej.szmigiero.name>
References: <569D3800.2040801@maciej.szmigiero.name>
 <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
 <56AF4A9F.4060401@maciej.szmigiero.name>
 <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
 <56AF4ED0.7030801@maciej.szmigiero.name>
 <56AF8E9E.5000100@maciej.szmigiero.name>
 <20160201211017.GG4455@sirena.org.uk>
 <56AFCE8D.70804@maciej.szmigiero.name>
Date: Mon, 1 Feb 2016 19:34:15 -0200
Message-ID: <CAOMZO5Bsy8DLNBKR77JFcihrrZp5mxN6BOJmte5uCXkwOfbzcg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Mark Brown <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 1, 2016 at 7:30 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> So can regcache initialization be changed to use register by register read
> in case raw read fails?
>
> Since other option for drivers like SSI which are memory mapped and
> don't offer ability to reset their register values to default would be to
> explicitly write driver hardcoded defaults also by doing
> register by register write on probe time.

Yes, I had to do the same for sgtl5000:
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/sound/soc/codecs/sgtl5000.c?id=af8ee11209e749c75eabf32b2a4ca631f396acf8

Would this approach work here too?
