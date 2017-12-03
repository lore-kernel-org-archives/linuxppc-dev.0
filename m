Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqNNy2tFMzDrvF
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Dec 2017 20:43:27 +1100 (AEDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: [PATCH] SB600 for the Nemo board has non-zero devices on non-root bus
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
Date: Sun, 3 Dec 2017 10:43:16 +0100
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Darren Stevens <darren@stevens-zone.net>
Message-Id: <4CEE49CE-68F3-457F-B302-54BA8550F36A@xenosoft.de>
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
 <CAOesGMhfMpt+xG1vhVHU+O5o4W5y2S5mZyn9tp+CPn9G6XrNVA@mail.gmail.com>
To: Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 3. Dec 2017, at 00:02, Olof Johansson <olof@lixom.net> wrote:
>=20
>> On Sat, Dec 2, 2017 at 3:00 PM, Olof Johansson <olof@lixom.net> wrote:
>>=20
>> The below patch, together with Bjorn's, should do it. Christian, can you t=
est
>> and report back?
>>=20
>> I'm guessing it won't do any harm to set this on non-X1000 platforms. My
>> test system is currently powered down so I can't check.
>>=20
>>=20
>> =46rom a3b390277627b0342c8ccfc16e58679e0d8abdde Mon Sep 17 00:00:00 2001
>> From: Olof Johansson <olof@lixom.net>
>> Date: Sat, 2 Dec 2017 14:56:36 -0800
>> Subject: [PATCH] powerpc/pasemi: set PCI_SCAN_ALL_PCI_DEVS
>>=20
>> Needed on Amiga X1000 with SB600.
>>=20
>> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>> arch/powerpc/platforms/pasemi/pci.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms=
/pasemi/pci.c
>> index 5ff6108..ea54ed2 100644
>> --- a/arch/powerpc/platforms/pasemi/pci.c
>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>> @@ -224,6 +224,8 @@ void __init pas_pci_init(void)
>>                return;
>>        }
>>=20
>> +       pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS):
>=20
> Typo, should be ';', not ':'. I obviously didn't even try compiling this. :=
)
>=20
>=20
> -Olof

Hi Olof,

Thanks a lot for your patch! I will test it on Wednesday.

Cheers,
Christian=
