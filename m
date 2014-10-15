Return-Path: <bhelgaas@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CB601A033E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 09:19:21 +1100 (EST)
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D623B14011B
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2014 09:19:19 +1100 (EST)
Received: by mail-ig0-f176.google.com with SMTP id hn15so18325430igb.3
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2014 15:19:17 -0700 (PDT)
Date: Wed, 15 Oct 2014 16:19:14 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
Message-ID: <20141015221914.GD15225@google.com>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412746096.30859.229.camel@pasglop>
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

On Wed, Oct 08, 2014 at 04:28:16PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2014-10-07 at 19:47 -0400, Alex Deucher wrote:
> > > This moves the setting of the quirk flag to the audio driver.
> > >
> > > While recent ASICs have that problem fixed, they don't seem to
> > > be listed in the PCI IDs of the current driver, so let's quirk all
> > > the ATI HDMI for now. The consequences are nil on x86 anyway.
> > >
> > > Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > CC: <stable@vger.kernel.org>
> > 
> > Further discussion with the hw teams have revealed that this is still
> > an issue on newer asics so I think your original patch is correct
> > after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.
> 
> Allright, I won't resend the whole series, I can just pickup my previous
> patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
> maintainership, how do you want to proceed ? I'm happy to merge the
> whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
> send me the appropriate acks, otherwise, let me know.

It all looks beautiful to me.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If I were merging it, I would change this:

  pci/msi: Add device flag indicating that 64-bit MSIs don't work

to this:

  PCI/MSI: Add device flag indicating that 64-bit MSIs don't work

I'd be happy to merge it, but given what I know now, I would wait and merge
it during the v3.19 merge window.  It sounds like it's more urgent than
that and should be merged earlier, but from the changelogs, it looks like
we're just replacing the powerpc-specific quirk with a more generic one.

So I assume you'll merge it via powerpc unless I hear otherwise.

Bjorn
