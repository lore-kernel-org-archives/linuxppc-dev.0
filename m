Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 8828EDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 16:26:08 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4147021wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 23:26:07 -0700 (PDT)
Date: Sat, 12 Jul 2008 00:26:04 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Message-ID: <20080712062604.GC23213@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
	<20080707105905.GA19240@rakim.wolfsonmicro.main>
	<9e4733910807070623u4c17b319p48e96a3022f3459b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807070623u4c17b319p48e96a3022f3459b@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 09:23:24AM -0400, Jon Smirl wrote:
> On 7/7/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > On Sun, Jul 06, 2008 at 01:56:48PM -0400, Jon Smirl wrote:
> >
> >  > The driver is assuming a capture stream exists. My codec is output only.
> >
> >
> > While the driver declares a capture stream the core doesn't require that
> >  both capture and playback be available - it will cope with a capture
> >  only or a playback only DAI (this is fairly common due to DAC only and
> >  ADC only parts).  Unless there's some other issue specific to this
> >  driver?
> 
> Yes, it GPFs allocating a a DMA buffer on the null capture stream pointer.

Where does it GPF?  When dereferencing pcm->streams[x].substream in
psc_i2s_pcm_new?
