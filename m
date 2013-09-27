Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D70AD2C0334
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 03:44:49 +1000 (EST)
Received: by mail-ie0-f180.google.com with SMTP id u16so4683113iet.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 10:44:44 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
References: <1380270519.27811.10.camel@pasglop>
 <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
Date: Fri, 27 Sep 2013 10:44:44 -0700
Message-ID: <CAE9FiQW+b7OtN4hJc6uygzbqzaCOkn3WcLDgSg5isHAJfdgmwg@mail.gmail.com>
Subject: Re: Please revert 928bea964827d7824b548c1f8e06eccbbc4d0d7d
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 27, 2013 at 9:01 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Sep 27, 2013 at 1:28 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> Hi Linus, Yinghai !
>>
>> Please consider reverting:
>>
>> 928bea964827d7824b548c1f8e06eccbbc4d0d7d
>> PCI: Delay enabling bridges until they're needed
>>
>> (I'd suggest to revert now and maybe merge a better patch later)
>>
>> This breaks PCI on the PowerPC "powernv" platform (which is booted via
>> kexec) and probably x86 as well under similar circumstances. It will
>> basically break PCIe if the bus master bit of the bridge isn't set at
>> boot (by the firmware for example, or because kexec'ing cleared it).
>>
>> The reason is that the PCIe port driver will call pci_enable_device() on
>> the bridge (on everything under the sun actually), which will marked the
>> device enabled (but will not do a set_master).
>>
>> Because of that, pci_enable_bridge() later on (called as a result of the
>> child device driver doing pci_enable_device) will see the bridge as
>> already enabled and will not call pci_set_master() on it.

Ben,

looks like PCIe port driver does call pci_enable_device AND pci_set_master()

| int pcie_port_device_register(struct pci_dev *dev)
| {
|        int status, capabilities, i, nr_service;
|        int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
|
|        /* Enable PCI Express port device */
|        status = pci_enable_device(dev);
|        if (status)
|                return status;
|
|        /* Get and check PCI Express port services */
|        capabilities = get_port_device_capability(dev);
|        if (!capabilities)
|                return 0;
|
|        pci_set_master(dev);

so how come that pci_set_master is not called for powerpc?

Can you send out lspci -vvxxx with current linus-tree and v3.11?

Yinghai
