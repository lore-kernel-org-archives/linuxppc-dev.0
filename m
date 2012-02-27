Return-Path: <bhelgaas@google.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4A93B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 09:45:06 +1100 (EST)
Received: by wgbdt14 with SMTP id dt14so1184045wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 14:45:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXx6wXaes1pbpM7SAHzndgr=N2D2g6LEWsB2_pf8+mgSA@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-10-git-send-email-yinghai@kernel.org>
 <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
 <1328738567.2903.45.camel@pasglop>
 <CAErSpo7ekGn-+Mnyz7KL=fVFH3Ed19AeE3MKkZWJ4bd0Jo7kCw@mail.gmail.com>
 <1328823358.2903.77.camel@pasglop> <20120223122536.6a2a7a6b@jbarnes-desktop>
 <CAErSpo7_WGjitDZz4XH+77f65Uz1ynd5_USN+D17D09Eux1iQQ@mail.gmail.com>
 <20120224142430.58f5e5ef@jbarnes-desktop>
 <CAE9FiQXx6wXaes1pbpM7SAHzndgr=N2D2g6LEWsB2_pf8+mgSA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 27 Feb 2012 15:44:42 -0700
Message-ID: <CAErSpo4YvyAhG1dCmtVhqNpCLj2oF4tCQ+UpU0oQYrG0nw+-ug@mail.gmail.com>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
To: Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Paul Mackerras <paulus@samba.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Feb 25, 2012 at 12:47 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Feb 24, 2012 at 2:24 PM, Jesse Barnes <jbarnes@virtuousgeek.org> =
wrote:
>> On Thu, 23 Feb 2012 12:51:30 -0800
>> Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> 2) We already have a way to add resources to a root bus: the
>>> pci_add_resource() used to add I/O port and MMIO apertures. =A0I think
>>> it'd be a lot simpler to just use that same interface for the bus
>>> number aperture, e.g.,
>>>
>>> =A0 =A0 pci_add_resource(&resources, hose->io_space);
>>> =A0 =A0 pci_add_resource(&resources, hose->mem_space);
>>> =A0 =A0 pci_add_resource(&resources, hose->busnr_space);
>>> =A0 =A0 bus =3D pci_scan_root_bus(dev, next_busno, pci_ops, sysdata, &r=
esources);
>>>
>>> This is actually a bit redundant, since "next_busno" should be the
>>> same as hose->busnr_space->start. =A0So if we adopted this approach, we
>>> might want to eventually drop the "next_busno" argument.
>>
>> Yeah that would be nice, the call would certainly make more sense that
>> way.
>
> no, I don't think so.
>
> using pci_add_resource will need to create dummy resource abut bus range.

I don't see the problem here.  The bus number aperture is a
fundamental property of a host bridge, and any firmware or native
bridge driver that tells you about a bridge but doesn't tell you the
bus number aperture is just broken.

Every arch already has struct resources for the MMIO and IO port
regions available on the bus.  ACPI already has a resource for the bus
number range.  It makes sense to me that the arch should supply a bus
number resource.

Conceptually, it's just like the MMIO and IO resources, so it makes
sense to me that the code for bus numbers should look like the code
for MMIO and IO ports.

> there is lots of pci_scan_root_bus(), =A0and those user does not bus end
> yet before scan.
> so could just hide pci_insert_busn_res in pci_scan_root_bus, and
> update busn_res end there.

pci_scan_child_bus() does NOT tell you the end of the bus number
aperture, and we shouldn't pretend that it does.  It might give you a
lower bound on the end of the aperture (as long as you're willing to
trust the current PCI config and you don't change anything).

> other arch like x86, ia64, powerpc, sparc, will insert exact bus range
> between pci_create_root_bus and
> pci_scan_child_bus, will not need to update busn_res end.
>
> please check v7 of this patchset.
>
> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linu=
x-yinghai.git
> for-pci-busn-alloc

I looked at your git tree, but I can't tell whether what's there is v7
or not and it's too much trouble to try to figure it out.

Bjorn
