Return-Path: <bhelgaas@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECB2CB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 03:59:23 +1000 (EST)
Received: from kpbe20.cbf.corp.google.com (kpbe20.cbf.corp.google.com
	[172.25.105.84]) by smtp-out.google.com with ESMTP id p4JHxGSH017021
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2011 10:59:17 -0700
Received: from gwj21 (gwj21.prod.google.com [10.200.10.21])
	by kpbe20.cbf.corp.google.com with ESMTP id p4JHwwhA011280
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2011 10:59:14 -0700
Received: by gwj21 with SMTP id 21so1425748gwj.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 10:59:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTinNSXCQJ=WJm6CkfttOgpVz1XOCBQ@mail.gmail.com>
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=tvyOPoN3f3v_C+NuVOwr+YKaRJA@mail.gmail.com>
	<BANLkTim22Lm=TG9vP+XH25k04ncX=kqy8g@mail.gmail.com>
	<BANLkTinNSXCQJ=WJm6CkfttOgpVz1XOCBQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 19 May 2011 11:58:54 -0600
Message-ID: <BANLkTimoyzERHjw_kQ5SAbNWudWJoX7yMA@mail.gmail.com>
Subject: Re: Kernel cannot see PCI device
To: Prashant Bhole <prashantsmailcenter@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 6:41 AM, Prashant Bhole
<prashantsmailcenter@gmail.com> wrote:
> On Wed, May 18, 2011 at 7:44 PM, Bjorn Helgaas <bhelgaas@google.com> wrot=
e:
>> On Wed, May 18, 2011 at 4:02 AM, Prashant Bhole
>> <prashantsmailcenter@gmail.com> wrote:
>>> On Mon, May 2, 2011 at 10:21 AM, Prashant Bhole
>>> <prashantsmailcenter@gmail.com> wrote:
>>>>
>>>> I have a custom made powerpc 460EX board. On that board u-boot
>>>> can see a PCI device but Linux kernel cannot see it. What could be the=
 problem?
>>>>
>>>> On u-boot "pci =A02" commands displays following device:
>>>> Scanning PCI devices on bus 2
>>>> BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Cl=
ass
>>>> _____________________________________________________________
>>>> 02.00.00 =A0 0x1000 =A0 =A0 0x0072 =A0 =A0 Mass storage controller 0x0=
0
>>>>
>>>> And when the kernel is booted, there is only one pci device (bridge):
>>>> #ls /sys/bus/pci/devices
>>>> 0000:80:00.0
>>>
>>> a call to pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l) retu=
rns
>>> positive value in the function pci_scan_device(), which means VENDOR_ID=
 reading
>>> failed. I could not find the reason. Any hints?
>>
>> My guess would be that Linux didn't find the host bridge to the
>> hierarchy containing bus 2. =A0I would guess the host bridge info is
>> supposed to come from OF. =A0More information, like the complete u-boot
>> PCI scan and the kernel dmesg log, would be useful. =A0And maybe u-boot
>> has a way to dump the OF device tree?
>
> I am not using OF for booting u-boot. OF is being used for booting the ke=
rnel.
> Not sure whether the host bridge info is coming from OF.
> Device tree has two pciex nodes with following property:
>
> compatible =3D "ibm,plb-pciex-460ex", "ibm,plb-pciex"
> I think that node represents a pciex bus not the bridge.

I think you have three PCI host bridges:

  PCIE1 to domain 0000 [bus 80-bf]  /plb/pciex@d20000000
  PCIX0 to domain 0001 [bus 00-3f]  /plb/pci@c0ec00000
  PCIE0 to [bus 40-7f] ("disabled via device-tree")

The scan below PCIE1 seems to work; at least, we found a P2P bridge at
0000:80:00.0.

The scan below PCIX0 (bus 0001:00) doesn't find anything.  You really
need a powerpc expert to help here, but in their absence, my guess
would be something's wrong with config space access, so I would start
by just adding some printks to ppc4xx_probe_pcix_bridge() to see if
the rsrc_cfg address looks reasonable.  You might need a chip spec or
maybe you can compare it to the device tree (I have no idea what the
relation between the device tree and OF is).

You mentioned the u-boot "pci 2" command earlier.  It found a device
on bus 2, which means there must be at least one P2P bridge to get you
from bus 0 to bus 2.  So the output of "pci 0", "pci 1", "pci 80", and
"pci 81" (to compare with what Linux found) would be interesting.

Bjorn
