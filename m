Return-Path: <B50113@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0126.outbound.protection.outlook.com [65.55.169.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3AAE1A0E39
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 16:28:55 +1100 (AEDT)
Date: Thu, 22 Jan 2015 13:13:46 +0800
From: Zidan Wang <b50113@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel][PATCH 3/3] ASoC: fsl_sai: Add support for Right-J
 mode
Message-ID: <20150122051344.GA6907@b50113>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-4-git-send-email-zidan.wang@freescale.com>
 <20150121185319.GA4238@Alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150121185319.GA4238@Alpha>
Cc: alsa-devel@alsa-project.org, timur@tabi.org,
 Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2015 at 10:53:20AM -0800, Nicolin Chen wrote:
> On Tue, Jan 20, 2015 at 08:21:20PM +0800, Zidan Wang wrote:
> > Add Right-J mode and set TCR5 FBT bit to let data right justify.
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> 
> > -	if (sai->is_lsb_first)
> > +	if (sai->is_lsb_first && sai->is_right_j_mode)
> >  		val_cr5 |= FSL_SAI_CR5_FBT(0);
> 
> Are you sure that FBT(0) is correct for right justified mode?
> Because the original code is using FBT(0) for the lsb_first
> situation and it shouldn't be right justified mode as default.
>
I am not sure about that. 

I assume lsb_first as big endian data.

For 16 bit data format, the 2 bytes data will in high address of 4 bytes
fifo. So the FBT is 16 for left-j and 0 for right-j. But big endian is
bytes convert not bits convert. It makes me confuse. And send to
community for help.

> Nicolin
