Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D4A6B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 23:53:01 +1100 (EST)
Date: Sat, 7 Nov 2009 12:33:20 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20091107123320.GE3228@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083423.18908.21177.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091107083423.18908.21177.stgit@angua>
Subject: Re: [alsa-devel] [PATCH 4/6] ASoC/mpc5200: add to_psc_dma_stream()
	helper
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 07, 2009 at 01:34:31AM -0700, Grant Likely wrote:

> +/* Utility for retrieving psc_dma_stream structure from a substream */
> +inline struct psc_dma_stream *
> +to_psc_dma_stream(struct snd_pcm_substream *substream, struct psc_dma *psc_dma)
> +{
> +	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		return &psc_dma->capture;
> +	return &psc_dma->playback;
> +}

Traditionally this'd be an if () else but it makes no difference either
way to the generated code.
