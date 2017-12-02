Return-Path: <olof@lixom.net>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yq6902FLnzDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Dec 2017 10:02:12 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id f13so15306587lff.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Dec 2017 15:02:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171202230052.34y2ivxgpgr3osct@localhost>
References: <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <6d2505ab-a985-bdb0-ad3a-e7659cc2c54d@xenosoft.de>
 <20171202230052.34y2ivxgpgr3osct@localhost>
From: Olof Johansson <olof@lixom.net>
Date: Sat, 2 Dec 2017 15:02:08 -0800
Message-ID: <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on non-root
 bus
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Darren Stevens <darren@stevens-zone.net>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 2, 2017 at 3:00 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Dec 02, 2017 at 01:54:41PM +0100, Christian Zigotzky wrote:
>> On 02 December 2017 at 00:27AM, Bjorn Helgaas wrote:
>> >
>> > Thanks for testing that.  I'll merge a similar patch for v4.16.
>> >
>> > I don't think using "pci=pcie_scan_all" is really an acceptable
>> > long-term answer for you, though.  Is there some way we can identify
>> > at run-time whether we're on a Nemo system?  If so, we can make this
>> > happen automatically.
>> >
>> > Bjorn
>> >
>> Hi Bjorn,
>>
>> Many thanks for your effort! I appreciate it very much. :-)
>>
>> We can identify the Nemo board at the boot time. See dmesg output: [
>> 0.061592] NEMO SB600 IOB base e0000000
>>
>> @linuxppc-dev
>> Any other ideas? Maybe the same as we can identify the other P.A. Semi
>> boards (Electra, Chitra, and Athena).
>>
>> @Olof
>> Maybe you know how we can identify the P.A. Semi Nemo board at the run-time.
>>
>> @Darren
>> Do you have an idea?
>
>
> The below patch, together with Bjorn's, should do it. Christian, can you test
> and report back?
>
> I'm guessing it won't do any harm to set this on non-X1000 platforms. My
> test system is currently powered down so I can't check.
>
>
> From a3b390277627b0342c8ccfc16e58679e0d8abdde Mon Sep 17 00:00:00 2001
> From: Olof Johansson <olof@lixom.net>
> Date: Sat, 2 Dec 2017 14:56:36 -0800
> Subject: [PATCH] powerpc/pasemi: set PCI_SCAN_ALL_PCI_DEVS
>
> Needed on Amiga X1000 with SB600.
>
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/powerpc/platforms/pasemi/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 5ff6108..ea54ed2 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -224,6 +224,8 @@ void __init pas_pci_init(void)
>                 return;
>         }
>
> +       pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS):

Typo, should be ';', not ':'. I obviously didn't even try compiling this. :)


-Olof
