Return-Path: <bhelgaas@google.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB948B72BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 01:23:55 +1000 (EST)
Received: by eekc1 with SMTP id c1so1538200eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 08:23:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1338959744.7150.153.camel@pasglop>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <1338959744.7150.153.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Jun 2012 09:23:30 -0600
Message-ID: <CAErSpo4pDOigbvF3SPzOUqx79d_-8yHWrc8TsWChG9indB+k_A@mail.gmail.com>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@au1.ibm.com>,
 Ben Collins <ben.c@servergy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 5, 2012 at 11:15 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2012-06-05 at 23:50 -0400, Ben Collins wrote:
>> The commit introducing pcibios_io_space_offset() was ignoring 32-bit to
>> 64-bit sign extention, which is the case on ppc32 with 64-bit resource
>> addresses. This only seems to have shown up while running under QEMU for
>> e500mc target. It may or may be suboptimal that QEMU has an IO base
>> address > 32-bits for the e500-pci implementation, but 1) it's still a
>> regression and 2) it's more correct to handle things this way.
>
> See Bjorn, we both did end up getting it wrong :-)

Ooh, sorry about that.  Who's going to push this fix?  I don't see it
in Linus' tree yet.  If you want me to, please forward me the original
patch.

>> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>> =A0arch/powerpc/kernel/pci-common.c | =A0 =A08 +++++++-
>> =A01 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-=
common.c
>> index 8e78e93..be9ced7 100644
>> --- a/arch/powerpc/kernel/pci-common.c
>> +++ b/arch/powerpc/kernel/pci-common.c
>> @@ -1477,9 +1477,15 @@ int pcibios_enable_device(struct pci_dev *dev, in=
t mask)
>> =A0 =A0 =A0 return pci_enable_resources(dev, mask);
>> =A0}
>>
>> +/* Before assuming too much here, take care to realize that we need sig=
n
>> + * extension from 32-bit pointers to 64-bit resource addresses to work.
>> + */
>> =A0resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
>> =A0{
>> - =A0 =A0 return (unsigned long) hose->io_base_virt - _IO_BASE;
>> + =A0 =A0 long vbase =3D (long)hose->io_base_virt;
>> + =A0 =A0 long io_base =3D _IO_BASE;
>> +
>> + =A0 =A0 return (resource_size_t)(vbase - io_base);
>> =A0}
>>
>> =A0static void __devinit pcibios_setup_phb_resources(struct pci_controll=
er *hose, struct list_head *resources)
>
>
