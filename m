Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04AE61A0551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 09:00:58 +1000 (AEST)
Received: by pdea3 with SMTP id a3so100977810pde.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 16:00:55 -0700 (PDT)
Date: Tue, 26 May 2015 16:00:49 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_spdif: Don't try to round-up for
 clock divisor calculation
Message-ID: <20150526230048.GA2752@Asurada-GSX>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk>
 <20150525151127.GA8184@Asurada>
 <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
 <20150525152424.GA8164@Asurada> <20150526110246.GA13725@shlinux2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150526110246.GA13725@shlinux2>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 26, 2015 at 07:02:48PM +0800, Zidan Wang wrote:
> On Mon, May 25, 2015 at 08:24:25AM -0700, Nicolin Chen wrote:
> > On Mon, May 25, 2015 at 12:13:45PM -0300, Fabio Estevam wrote:
> > > Hi Nicolin,
> > > 
> > > On Mon, May 25, 2015 at 12:11 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > 
> > > > Hi Mark,
> > > >
> > > > Is that possible for you to provisionally revert this patch?
> > > > I wanted to wait for the test result from Fabio or Zidan in
> > > > the Cc list because I don't have a test environment for SPDIF
> > > > even though this change seems to make sense.
> > > 
> > > I currently don't have access to a SPDIF receiver to test it.
> > 
> > Okay, let's wait for Zidan then. We only need to test the
> > playback route of supporting sample rates.

> I don't have the board which supported by community to test spdif out. So i used the imx7 board

i.MX6 ARM2, the one with the square green base board, should work,
although you may add some device nodes in dts to make it work.

> and test it with internal branch.
> I found that (txclk_df + 1) is better than txclk_df.
> I suspect the patch for clk_round_rate() is not in our branch. Could you please tell me which
> patch is for clk_round_rate? I want to cherry-pick it to our branch and test it.

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/clk/clk-divider.c

Here is commit logs for the clock driver. You can check git-log of
your local one and cherry-pick those incremental patches. Another
clue is that after updating the clock driver to the latest version,
SSI master mode in your local branch would become abnormal since
it's still using pm + 2 to round the calculation.

Thanks a lot
Nicolin
