Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A8BB1A0728
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 10:16:22 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8786C140161
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 10:16:21 +1000 (EST)
Message-ID: <1412208952.4285.239.camel@pasglop>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 02 Oct 2014 10:15:52 +1000
In-Reply-To: <1412201282.4285.232.camel@pasglop>
References: <1412129393.4285.195.camel@pasglop>
 <s5htx3o44tv.wl-tiwai@suse.de> <1412149289.4285.204.camel@pasglop>
 <s5hr3ys43ev.wl-tiwai@suse.de> <s5hoatw42f6.wl-tiwai@suse.de>
 <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
 <1412201282.4285.232.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Takashi Iwai <tiwai@suse.de>,
 Linux PCI <linux-pci@vger.kernel.org>, Brian King <brking@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Dave Airlie <airlied@linux.ie>,
 Yijing Wang <wangyijing@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 08:08 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2014-10-01 at 13:58 -0400, Alex Deucher wrote:
> > Patch looks good.  Audio DMAs are limited to 40 bits, same as the GPU
> > side.  I'm still waiting to hear back on the MSIs for audio, but they
> > probably follow the GPU side, so I expect they should be fixed on Sea
> > Islands as well.
> 
> In the audio driver we don't have the "family names", just a list of
> PCI IDs, do you happen to know which ones are unaffected ?

So I tried to be more discriminate but in the end, I had to give up, the
most recent ID we have in the driver seems to be Cap Verde/Pitcairn,
which isn't fixed. So either we are missing IDs or the new cards use the
same ID.

I think the consequences of being over-zealous here are nil on what
matters, ie, x86. AFAIK, x86 always uses 32-bit addresses for MSIs
anyway, so it's unaffected and ARM ... well, I doubt it will be. In
general, I don't think we have a big issue here by just flagging them
all.

I'll send an updated series with just the flag name changed as suggested
by Alex and the DMA bits updated as suggested by Takashi.

Cheers,
Ben.
