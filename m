Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B7431A00BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 09:00:31 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so128174333pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 14:00:29 -0800 (PST)
Date: Fri, 20 Nov 2015 14:00:16 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, pawel.moll@arm.com,
 mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, timur@tabi.org, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, shawnguo@kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH V2 3/3] ASoC: fsl_asrc: spba clock is needed by asrc device
Message-ID: <20151120220015.GA10156@Asurada>
References: <cover.1447997800.git.shengjiu.wang@freescale.com>
 <7b40da78c965d4152c15794ec527c75198c9e2f9.1447997800.git.shengjiu.wang@freescale.com>
 <20151120142946.GA6949@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151120142946.GA6949@rob-hp-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2015 at 08:29:46AM -0600, Rob Herring wrote:
> On Fri, Nov 20, 2015 at 02:17:53PM +0800, Shengjiu Wang wrote:
> > ASRC need to enable the spba clock, when sdma is using share peripheral
> > script. In this case, there is two spba master port is used, if don't
> > enable the clock, the spba bus will have arbitration issue, which may
> > cause read/write wrong data from/to ASRC registers
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl,asrc.txt |  2 ++
> >  sound/soc/fsl/fsl_asrc.c                             | 10 ++++++++++
> >  sound/soc/fsl/fsl_asrc.h                             |  1 +
> >  3 files changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > index b93362a..d8eeee3 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> > @@ -25,6 +25,8 @@ Required properties:
> >  	"mem"		  Peripheral access clock to access registers.
> >  	"ipg"		  Peripheral clock to driver module.
> >  	"asrck_<0-f>"	  Clock sources for input and output clock.
> > +	"spba"		  The spba clock is needed when two spba master port
> > +			  is used.
> 
> I'm assuming the same comments on patch 1 apply to all 3.

Yes. I should have mentioned that.

Nicolin
