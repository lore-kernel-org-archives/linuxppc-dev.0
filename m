Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B99ED1A0220
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 09:56:00 +1100 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 14A4A140076
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2014 09:55:59 +1100 (EST)
Message-ID: <1413413732.11213.27.camel@pasglop>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 Oct 2014 09:55:32 +1100
In-Reply-To: <20141015221914.GD15225@google.com>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Linux PCI <linux-pci@vger.kernel.org>, Anton Blanchard <anton@au1.ibm.com>,
 Takashi Iwai <tiwai@suse.de>, Yijing Wang <wangyijing@huawei.com>,
 Brian King <brking@linux.vnet.ibm.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
>   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> 
> I'd be happy to merge it, but given what I know now, I would wait and merge
> it during the v3.19 merge window.  It sounds like it's more urgent than
> that and should be merged earlier, but from the changelogs, it looks like
> we're just replacing the powerpc-specific quirk with a more generic one.
> 
> So I assume you'll merge it via powerpc unless I hear otherwise.

Either way works but it's easy to keep it all in one series in one tree.

The urgency is that the current powerpc quirk works only with one specific
card (ie, one device ID for gfx and one for audio) and misses the DMA limitation
of the sound driver (which is a somewhat orthogonal issue but the patch for it is
in the series).

Any other radeon card causes the machine to crash at boot (the driver doesn't
recover well from the EEH error triggered by the bad MSI address and the world
falls over from there).

So I want this to go back into distros.

Cheers,
Ben.
