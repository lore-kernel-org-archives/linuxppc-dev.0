Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFFC01A01E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 20:03:30 +1000 (EST)
Date: Wed, 23 Jul 2014 17:52:32 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Reset FIFOs after disabling TE/RE
Message-ID: <20140723095229.GA25639@MrMyself>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
 <9ef07dc9cc98b19e3f81f8374617605bf0d9faeb.1405603108.git.nicoleotsuka@gmail.com>
 <20140718101810.GA15150@MrMyself>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140718101810.GA15150@MrMyself>
Cc: alsa-devel@alsa-project.org, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sir,

I found this two patches are merged into for-next branch, although I haven't
got the 'applied' email. 

Is that possible for you to drop this one? If not, I'll send another patch
to fix this.

Thank you,
Nicolin

On Fri, Jul 18, 2014 at 06:18:12PM +0800, Nicolin Chen wrote:
> Mark,
> 
> 	Please disregard this single patch. 
> 
> On Thu, Jul 17, 2014 at 09:21:37PM +0800, Nicolin Chen wrote:
> > SAI will not clear their FIFOs after disabling TE/RE. Therfore, the driver
> > should take care the task so as not to let useless data remain in the FIFO.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index c5a0e8a..b10dbd8 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -371,10 +371,13 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
> >  
> >  		/* Check if the opposite FRDE is also disabled */
> >  		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {
> > +			/* Disable both directions and reset their FIFOs */
> >  			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
> > -					   FSL_SAI_CSR_TERE, 0);
> > +					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
> > +					   FSL_SAI_CSR_FR);
> >  			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
> > -					   FSL_SAI_CSR_TERE, 0);
> > +					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
> > +					   FSL_SAI_CSR_FR);
> 
> 
> The FR should be set _after_ clear TERE, not at the same time because it
> still may have tiny possibility to remain data.
> 
> I'll send another version later for this patch.
> 
> The other patch for isr() should be still fine.
> 
> Thank you,
> Nicolin
> 
> >  		}
> >  		break;
> >  	default:
> > -- 
> > 1.8.4
> > 
