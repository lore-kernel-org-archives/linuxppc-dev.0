Return-Path: <alexdeucher@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E39781A05E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 11:18:35 +1100 (EST)
Received: from mail-qg0-x231.google.com (mail-qg0-x231.google.com
 [IPv6:2607:f8b0:400d:c04::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59F3614011E
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2014 11:18:35 +1100 (EST)
Received: by mail-qg0-f49.google.com with SMTP id a108so6195694qge.8
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Oct 2014 17:18:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412725790.30859.214.camel@pasglop>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412725790.30859.214.camel@pasglop>
Date: Tue, 7 Oct 2014 20:18:32 -0400
Message-ID: <CADnq5_OhSYa+zXBp03_rrvNFTahcaQrtX2o5+H049Nig9378gg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Linux PCI <linux-pci@vger.kernel.org>, Anton Blanchard <anton@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 7, 2014 at 7:49 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2014-10-07 at 19:47 -0400, Alex Deucher wrote:
>> > While recent ASICs have that problem fixed, they don't seem to
>> > be listed in the PCI IDs of the current driver, so let's quirk all
>> > the ATI HDMI for now. The consequences are nil on x86 anyway.
>> >
>> > Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > CC: <stable@vger.kernel.org>
>>
>> Further discussion with the hw teams have revealed that this is still
>> an issue on newer asics so I think your original patch is correct
>> after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.
>
> Ok. You confirm that this is however good on newer video side right ?
>

Yes, this was definitely fixed on the GPU side.

> Also, is there a known issue that if MSI were once enabled, the chip
> still shoots them even if we disable them in config space ?
>
> When testing my new patch set, I was trying to test the error path
> when the arch does *not* honor the limitation. The error went back
> up to the driver as far as I can tell (ie, pci_enable_msi() failed),
> but the system still got into error state as if the card had tried
> to shoot an MSI to the wrong address.
>
> (I suspect the graphics side)

I'm not aware of any such issue, but I can ask the hw guys if there is
anything special required to disable MSIs beyond the pci config space
settings.

Alex

>
> Cheers,
> Ben.
>
>
