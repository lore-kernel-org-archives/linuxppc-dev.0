Return-Path: <alexdeucher@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 840071A06CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 11:19:27 +1000 (EST)
Received: from mail-qc0-x230.google.com (mail-qc0-x230.google.com
 [IPv6:2607:f8b0:400d:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CFD561400DD
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 11:19:26 +1000 (EST)
Received: by mail-qc0-f176.google.com with SMTP id r5so1430456qcx.35
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2014 18:19:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412201282.4285.232.camel@pasglop>
References: <1412129393.4285.195.camel@pasglop> <s5htx3o44tv.wl-tiwai@suse.de>
 <1412149289.4285.204.camel@pasglop> <s5hr3ys43ev.wl-tiwai@suse.de>
 <s5hoatw42f6.wl-tiwai@suse.de>
 <CADnq5_P1qTkedSuFfgJ=dd5cWji1-OUbmKoUyq+kLQgPGYYaQw@mail.gmail.com>
 <1412201282.4285.232.camel@pasglop>
Date: Wed, 1 Oct 2014 21:19:24 -0400
Message-ID: <CADnq5_PuquWuwoJuOL_rNk_bkWmKh4Mh2fu2r7dNASHktFAN_w@mail.gmail.com>
Subject: Re: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
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

On Wed, Oct 1, 2014 at 6:08 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-10-01 at 13:58 -0400, Alex Deucher wrote:
>> Patch looks good.  Audio DMAs are limited to 40 bits, same as the GPU
>> side.  I'm still waiting to hear back on the MSIs for audio, but they
>> probably follow the GPU side, so I expect they should be fixed on Sea
>> Islands as well.
>
> In the audio driver we don't have the "family names", just a list of
> PCI IDs, do you happen to know which ones are unaffected ?

The list of unaffected ones are:
0x1308 //kaveri
0x9840 //Kabini
0xaac0 //bonaire
0xaac8 //hawaii
0xaad8 //tonga
Pus all newer asics.

Alternatively, the list of older asics that are affected (some of
these may not even support MSI64 in the first place):
0x1314 //palm
0x7919 //RS690
0x793b //RS600
0x7969 //RS740
0x960f //RS780
0x9646 //sumo
0x970f //RS880
0x9902 //trinity
0xaa00 //R600
0xaa08 //RV630
0xaa10 //RV610
0xaa18 //RV670
0xaa20 //RV635
0xaa28 //RV620
0xaa30 //RV770
0xaa38 //RV730
0xaa40 //RV710
0xaa48 //RV740
0xaa50 //cypress
0xaa58 //juniper
0xaa60 //redwood
0xaa68 //cedar
0xaa80 //cayman
0xaa88 //barts
0xaa90 //turks
0xaa98 //caicos
0xaaa0 //tahiti
0xaab0 //verde, pitcairn, oland

It might be better to only set the msi32 flag on the above affected
asics so we don't have to worry about new ones.

Alex
