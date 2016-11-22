Return-Path: <sthemmin@microsoft.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0117.outbound.protection.outlook.com [104.47.33.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNXG240qwzDvxr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 04:17:13 +1100 (AEDT)
From: Stephen Hemminger <sthemmin@microsoft.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Bjorn Helgaas
 <helgaas@kernel.org>, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>, Uma Krishnan <ukrishn@linux.vnet.ibm.com>, "Ian
 Munsie" <imunsie@au1.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] PCI: Add pci_set_vpd_timeout() to set VPD access
 timeout
Date: Tue, 22 Nov 2016 17:17:07 +0000
Message-ID: <BLUPR0301MB2098AD79A327EBDE07ADA255CCB40@BLUPR0301MB2098.namprd03.prod.outlook.com>
References: <1479762225-51440-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1479762589-51557-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <20161121220523.GB4832@bhelgaas-glaptop.roam.corp.google.com>
 <9f08836b-d483-e54a-b56d-c4f20d4d1a90@au1.ibm.com>
In-Reply-To: <9f08836b-d483-e54a-b56d-c4f20d4d1a90@au1.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I had old Marvell Sky2 hardware that had slow flash.

-----Original Message-----
From: Andrew Donnellan [mailto:andrew.donnellan@au1.ibm.com]=20
Sent: Monday, November 21, 2016 4:16 PM
To: Bjorn Helgaas <helgaas@kernel.org>; Matthew R. Ochs <mrochs@linux.vnet.=
ibm.com>
Cc: linux-pci@vger.kernel.org; Frederic Barrat <fbarrat@linux.vnet.ibm.com>=
; Uma Krishnan <ukrishn@linux.vnet.ibm.com>; Ian Munsie <imunsie@au1.ibm.co=
m>; Bjorn Helgaas <bhelgaas@google.com>; linuxppc-dev@lists.ozlabs.org; Ste=
phen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH 1/2] PCI: Add pci_set_vpd_timeout() to set VPD access t=
imeout

On 22/11/16 09:05, Bjorn Helgaas wrote:
> Hi Matthew,
>
> On Mon, Nov 21, 2016 at 03:09:49PM -0600, Matthew R. Ochs wrote:
>> The PCI core uses a fixed 50ms timeout when waiting for VPD accesses=20
>> to complete. When an access does not complete within this period, a=20
>> warning is logged and an error returned to the caller.
>>
>> While this default timeout is valid for most hardware, some devices=20
>> can experience longer access delays under certain circumstances. For=20
>> example, one of the IBM CXL Flash devices can take up to ~120ms in a=20
>> worst-case scenario. These types of devices can benefit from an=20
>> extended timeout that is specific to their hardware constraints.
>>
>> To support per-device VPD access timeouts, pci_set_vpd_timeout() is=20
>> added as an exported service. PCI devices will continue to default=20
>> with the 50ms timeout and use a per-device timeout when a driver calls t=
his new service.
>
> Can you include a pointer to something in the spec that's behind the=20
> default 50ms timeout, or did somebody just pull that number out of the=20
> air?

It looks like Stephen Hemminger added the 50ms timeout in 1120f8b8169f, whi=
ch seems to indicate that 50ms was chosen because it's longer than the 13ms=
 per word that was measured on one device.

--=20
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
