Return-Path: <bhelgaas@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.44.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01320B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 00:15:28 +1000 (EST)
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com
	[172.24.198.77]) by smtp-out.google.com with ESMTP id p4IEFIfa002015
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2011 07:15:18 -0700
Received: from gwaa18 (gwaa18.prod.google.com [10.200.27.18])
	by wpaz13.hot.corp.google.com with ESMTP id p4IEFHqt027965
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2011 07:15:17 -0700
Received: by gwaa18 with SMTP id a18so545603gwa.19
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 07:15:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTi=tvyOPoN3f3v_C+NuVOwr+YKaRJA@mail.gmail.com>
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=tvyOPoN3f3v_C+NuVOwr+YKaRJA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 18 May 2011 08:14:57 -0600
Message-ID: <BANLkTim22Lm=TG9vP+XH25k04ncX=kqy8g@mail.gmail.com>
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

On Wed, May 18, 2011 at 4:02 AM, Prashant Bhole
<prashantsmailcenter@gmail.com> wrote:
> On Mon, May 2, 2011 at 10:21 AM, Prashant Bhole
> <prashantsmailcenter@gmail.com> wrote:
>>
>> Hi,
>> I have a custom made powerpc 460EX board. On that board u-boot
>> can see a PCI device but Linux kernel cannot see it. What could be the p=
roblem?
>>
>> On u-boot "pci =A02" commands displays following device:
>> Scanning PCI devices on bus 2
>> BusDevFun =A0VendorId =A0 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Clas=
s
>> _____________________________________________________________
>> 02.00.00 =A0 0x1000 =A0 =A0 0x0072 =A0 =A0 Mass storage controller 0x00
>>
>> And when the kernel is booted, there is only one pci device (bridge):
>> #ls /sys/bus/pci/devices
>> 0000:80:00.0
>>
>
> I am still facing in this problem.
>
> a call to pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l) return=
s
> positive value in the function pci_scan_device(), which means VENDOR_ID r=
eading
> failed. I could not find the reason. Any hints?

Hmm...  probably powerpc-related, so I added linuxppc-dev.

My guess would be that Linux didn't find the host bridge to the
hierarchy containing bus 2.  I would guess the host bridge info is
supposed to come from OF.  More information, like the complete u-boot
PCI scan and the kernel dmesg log, would be useful.  And maybe u-boot
has a way to dump the OF device tree?
