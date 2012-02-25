Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64024B6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 18:47:29 +1100 (EST)
Received: by ggni2 with SMTP id i2so1039281ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 23:47:26 -0800 (PST)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20120224142430.58f5e5ef@jbarnes-desktop>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-10-git-send-email-yinghai@kernel.org>
 <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
 <1328738567.2903.45.camel@pasglop>
 <CAErSpo7ekGn-+Mnyz7KL=fVFH3Ed19AeE3MKkZWJ4bd0Jo7kCw@mail.gmail.com>
 <1328823358.2903.77.camel@pasglop>
 <20120223122536.6a2a7a6b@jbarnes-desktop>
 <CAErSpo7_WGjitDZz4XH+77f65Uz1ynd5_USN+D17D09Eux1iQQ@mail.gmail.com>
 <20120224142430.58f5e5ef@jbarnes-desktop>
Date: Fri, 24 Feb 2012 23:47:26 -0800
Message-ID: <CAE9FiQXx6wXaes1pbpM7SAHzndgr=N2D2g6LEWsB2_pf8+mgSA@mail.gmail.com>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 24, 2012 at 2:24 PM, Jesse Barnes <jbarnes@virtuousgeek.org> wr=
ote:
> On Thu, 23 Feb 2012 12:51:30 -0800
> Bjorn Helgaas <bhelgaas@google.com> wrote:
>> 2) We already have a way to add resources to a root bus: the
>> pci_add_resource() used to add I/O port and MMIO apertures. =A0I think
>> it'd be a lot simpler to just use that same interface for the bus
>> number aperture, e.g.,
>>
>> =A0 =A0 pci_add_resource(&resources, hose->io_space);
>> =A0 =A0 pci_add_resource(&resources, hose->mem_space);
>> =A0 =A0 pci_add_resource(&resources, hose->busnr_space);
>> =A0 =A0 bus =3D pci_scan_root_bus(dev, next_busno, pci_ops, sysdata, &re=
sources);
>>
>> This is actually a bit redundant, since "next_busno" should be the
>> same as hose->busnr_space->start. =A0So if we adopted this approach, we
>> might want to eventually drop the "next_busno" argument.
>
> Yeah that would be nice, the call would certainly make more sense that
> way.

no, I don't think so.

using pci_add_resource will need to create dummy resource abut bus range.

there is lots of pci_scan_root_bus(),  and those user does not bus end
yet before scan.
so could just hide pci_insert_busn_res in pci_scan_root_bus, and
update busn_res end there.

other arch like x86, ia64, powerpc, sparc, will insert exact bus range
between pci_create_root_bus and
pci_scan_child_bus, will not need to update busn_res end.

please check v7 of this patchset.

    	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.gi=
t
for-pci-busn-alloc

It should be clean and have minimum lines of change.

Thanks

      Yinghai
