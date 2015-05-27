Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB3C51A0E38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 04:31:23 +1000 (AEST)
Received: by igbjd9 with SMTP id jd9so5806284igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 11:31:21 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAE9FiQU9k6m-5bM5ZfFUZxW3H7_v4aOtaK66pa7iV0Zb-J86jw@mail.gmail.com>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
 <20130725175727.6006.98109.stgit@bhelgaas-glaptop>
 <CAE9FiQU9k6m-5bM5ZfFUZxW3H7_v4aOtaK66pa7iV0Zb-J86jw@mail.gmail.com>
Date: Wed, 27 May 2015 11:31:21 -0700
Message-ID: <CAE9FiQXq59tSBM0SQ4OToXydZrRC3yukALmWEb6K9xpCGbdUhg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: pciehp: Convert pciehp to be builtin only,
 not modular
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-sh@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Mundt <lethal@linux-sh.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 26, 2013 at 5:43 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Jul 25, 2013 at 10:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Convert pciehp to be builtin only, with no module option.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/pci/pcie/Kconfig |    5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> index 569f82f..3b94cfc 100644
>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>>  # Include service Kconfig here
>>  #
>>  config HOTPLUG_PCI_PCIE
>> -       tristate "PCI Express Hotplug driver"
>> +       bool "PCI Express Hotplug driver"
>>         depends on HOTPLUG_PCI && PCIEPORTBUS
>>         help
>>           Say Y here if you have a motherboard that supports PCI Express Native
>>           Hotplug
>>
>> -         To compile this driver as a module, choose M here: the
>> -         module will be called pciehp.
>> -
>>           When in doubt, say N.
>>
>>  source "drivers/pci/pcie/aer/Kconfig"
>>
>
> Acked-by: Yinghai Lu <yinghai@kernel.org>

Hi Bjorn,

Looks like we lose the option to disable pciehp after we make it as built-in.

Before acpiphp and pciehp could be compiled as modules, and user could
blacklist to disable them.

Now they are all built-in, but only acpiphp has acpiphp.disable to
disable acpiphp.
we don't have pciehp.disable yet.

Do you think if we should add pciehp.disable ?

BTW we don't have any description for acpiphp.disable anywhere.

Thanks

Yinghai
