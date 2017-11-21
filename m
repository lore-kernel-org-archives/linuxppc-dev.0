Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygng168QQzDrRj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 12:14:21 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id u70so8624793pfa.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 17:14:21 -0800 (PST)
Date: Mon, 20 Nov 2017 17:14:17 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: call _fsl_ssi_set_dai_fmt()
 just once in AC'97 mode
Message-ID: <20171121011416.GD14136@Asurada-Nvidia>
References: <81ad2e7e-e070-c38e-b318-9607b4558ee7@maciej.szmigiero.name>
 <20171121000042.GB14136@Asurada-Nvidia>
 <da7bf2c5-5a4d-d2cc-823d-3f8cdfccd51c@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da7bf2c5-5a4d-d2cc-823d-3f8cdfccd51c@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 21, 2017 at 01:32:09AM +0100, Maciej S. Szmigiero wrote:
> On 21.11.2017 01:00, Nicolin Chen wrote:
> > On Mon, Nov 20, 2017 at 11:13:45PM +0100, Maciej S. Szmigiero wrote:
> (..)
> >> We need to make sure, however, that only proper channel slots are enabled
> >> at playback start time since some AC'97 CODECs (like VT1613) were observed
> >> requesting via SLOTREQ (and so enabling at SSI) spurious ones just after
> >> an AC'97 link is started but before the CODEC is configured by its driver.
> > 
> > I don't really understand this part. Why do we need to *make sure*
> > and set SACCDIS and SACCEN again since they're initialized already> 
> > Could you please elaborate a bit more?
> 
> SACCDIS and SACCEN aren't just normal registers.
> They are a way to disable or enable bits in SACCST register - writing
> a '1' bit at some position in SACCDIS unsets the relevant bit in SACCST,
> writing a '1' bit at some position in SACCEN sets the relevant bit in
> SACCST.
> 
> But a bit in SACCST can also be set (and so an AC'97 channel slot
> enabled) if a CODEC sets the relevant bit in its SLOTREQ request (it is
> enough if this bit was set in SLOTREQ just once, bits in SACCST are
> 'sticky').

This makes sense now. It could be mentioned a bit in the commit log
as well.

> If an extra slot gets enabled that's a disaster for playback because some
> of normal left or right channel samples are instead redirected to this
> extra slot.
> 
> Unfortunately, the VT1613 codec on UDOO board (which is the only user of
> fsl_ssi driver in the AC'97 mode) is a bit broken and likes to (sometimes)
> set extra bits in its SLOTREQ request - I've confirmed this on two boards
> bought a few months apart directly from UDOO shop.
> 
> A workaround implemented in fsl-asoc-card of setting an appropriate
> CODEC register so that slots 3/4 (the normal stereo playback slots) are
> used for S/PDIF seems to mostly fix this issue but since this codec is so
> untrustworthy then:

If this move is also a workaround, probably it'd be better to have
an fsl_ssi_ac97_xxx_war() function with some comments/descriptions,
and include it in the config(). Since it doesn't hurt to set these
registers again, I am personally fine with that. But it needs to be
clear -- otherwise, people may try to remove it later with a change
like: Removing redundant SACCEN/SACCDIS settings since they're done
during probe().
