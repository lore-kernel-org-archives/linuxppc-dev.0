Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47C931A05E7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 08:10:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7292014016A
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 08:10:16 +1000 (EST)
Message-ID: <1412201390.4285.233.camel@pasglop>
Subject: Re: [PATCH 1/4] pci/msi: Move "force_32bit_msi" flag from powerpc
 to generic pci_dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 02 Oct 2014 08:09:50 +1000
In-Reply-To: <20141001203322.GE4171@google.com>
References: <1412048401.4285.128.camel@pasglop>
 <CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
 <CADnq5_PT+dX=KA4epGNRaoraco2z1pe5K7UgqLmTUhWMnvtWkw@mail.gmail.com>
 <1412108504.4285.155.camel@pasglop>
 <CADnq5_O_iLAZUKLL4nph8VwuP2NOkWXhBZC2XTSkFm5P42WZ+g@mail.gmail.com>
 <1412110946.4285.158.camel@pasglop>
 <CADnq5_OXBax1+TKPsR2RDYTWijQKDVw34ECfWzcwN2SibCGYTg@mail.gmail.com>
 <1412112324.4285.160.camel@pasglop> <1412129363.4285.190.camel@pasglop>
 <20141001203322.GE4171@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 14:33 -0600, Bjorn Helgaas wrote:
> I like the idea of handling this more generically, e.g., with a bit like
> this in struct pci_dev (I'd probably name it something like "no_64bit_msi"
> along the lines of your driver #defines).
> 
> What I don't like is that we haven't done anything to help other
> architectures, because the only code that *looks* at this bit is in
> arch/powerpc.  The next arch that tries to use 64-bit MSI addresses for
> these devices will trip over the same problem.

I started looking. From my (limited) understanding of x86, it doesn't
even look at the "size" of MSIs which makes me think it's always 32-bit,
and I plan to look at the others next (though not for stable).

> Can we check in pci_enable_msi_range() and pci_enable_msix_range() whether
> the MSI addresses allocated by the arch are too big, and fail the call if
> they are?

Yes, good idea, I'll add something.

Cheers,
Ben.
