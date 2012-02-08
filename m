Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01018B71B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 04:31:38 +1100 (EST)
Received: by vbbfo1 with SMTP id fo1so513870vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2012 09:31:35 -0800 (PST)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-10-git-send-email-yinghai@kernel.org>
 <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
Date: Wed, 8 Feb 2012 09:31:35 -0800
Message-ID: <CAE9FiQVnJ2PpBSUoRZeEy2p44xv3mHVYRgn9tKzr1yeXmwMYbA@mail.gmail.com>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
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

On Wed, Feb 8, 2012 at 7:58 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Feb 4, 2012 at 10:57 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>> =A0arch/powerpc/kernel/pci-common.c | =A0 =A07 ++++++-
>> =A01 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-=
common.c
>> index cce98d7..501f29b 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1732,6 +1732,8 @@ void __devinit pcibios_scan_phb(struct pci_control=
ler *hose)
>> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
>> =A0 =A0 =A0 =A0hose->bus =3D bus;
>>
>> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->last=
_busno);
>> +
>> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
>> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
>> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
>> @@ -1742,8 +1744,11 @@ void __devinit pcibios_scan_phb(struct pci_contro=
ller *hose)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL)
>> + =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, 255);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =3D=
 pci_scan_child_bus(bus);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, bus->subo=
rdinate);
>> + =A0 =A0 =A0 }
>
> The only architecture-specific thing here is discovering the range of
> bus numbers below a host bridge. =A0The architecture should not have to
> mess around with pci_bus_update_busn_res_end() like this. =A0It should
> be able to say "here's my bus number range" (and of course the PCI
> core can default to 0-255 if the arch doesn't supply a range) and the
> core should take care of the rest.

during the pci_scan_child_bus,  child bus busn_res will be inserted
under parent bus busn_res.

So need to make sure parent busn_res.end is bigger enough.


Yinghai
