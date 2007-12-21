Return-Path: <rlrevell@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 08D45DDF0B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 16:28:41 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so130808rvf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 21:28:40 -0800 (PST)
Message-ID: <75b66ecd0712202128n2f13adf2ie9a344e0c19d69ad@mail.gmail.com>
Date: Fri, 21 Dec 2007 00:28:40 -0500
From: "Lee Revell" <rlrevell@joe-job.com>
Sender: rlrevell@gmail.com
To: "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <s5h4ped4gl3.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net> <476A7B23.2040905@freescale.com>
	<s5h4ped4gl3.wl%tiwai@suse.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Dec 20, 2007 8:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 20 Dec 2007 08:24:35 -0600,
> Timur Tabi wrote:
> >
> > >> +static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
> > >> +  struct snd_pcm *pcm)
> > >> +{
> > >> +  static u64 fsl_dma_dmamask = 0xffffffff;
> > >> +  int ret;
> > >> +
> > >> +  if (!card->dev->dma_mask)
> > >> +          card->dev->dma_mask = &fsl_dma_dmamask;
> > >
> > > I haven't read how your channel allocation works, but providing a
> > > pointer to a local static variable is a bit fishy no matter what.
> >
> > I just copied this code from another module.  All the ALSA drivers do this,
>
> All?  No, only a few...
> For PCI, usually pci_set_dma_mask() and pci_set_consistent_dma_mask()
> are used, of course.

Timur,

Nicely commented driver!  I wish they were all like this ;-)

Please use DMA_32BIT_MASK (see include/linux/dma-mapping.h) instead of
0xffffffff.  I've personally fixed a heisenbug in an ALSA driver
caused by incorrectly typed DMA mask...

Lee
