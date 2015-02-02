Return-Path: <bhelgaas@google.com>
Received: from mail-qc0-x233.google.com (mail-qc0-x233.google.com
 [IPv6:2607:f8b0:400d:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70F501A0A09
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 02:48:20 +1100 (AEDT)
Received: by mail-qc0-f179.google.com with SMTP id w7so30522268qcr.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Feb 2015 07:48:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422844101.11325.4.camel@ellerman.id.au>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-2-git-send-email-haokexin@gmail.com>
 <1422844101.11325.4.camel@ellerman.id.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Feb 2015 09:47:57 -0600
Message-ID: <CAErSpo7B3yDQiD0XA9nBxb4tFW0BktT0EZ3HCZENOYQqMy0m_Q@mail.gmail.com>
Subject: Re: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for
 !CONFIG_OF
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kevin Hao <haokexin@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 1, 2015 at 8:28 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
>> So we can avoid the ugly #ifdef in some drivers.
>>
>> Signed-off-by: Kevin Hao <haokexin@gmail.com>
>> ---
>>  include/linux/pci.h | 2 ++
>>  1 file changed, 2 insertions(+)
>
>
> Hi Bjorn,
>
> Do you mind putting this into your next for 3.20? Or giving us an ACK for it if
> you prefer.

I think it makes more sense to merge this along with the other 14
patches that remove the #ifdefs (at least, I assume that's what they
do; I haven't seen them).

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

But please edit the subject line so it is capitalized consistently
with the rest of the history.  And it'd be nice if the changelog were
a complete sentence all by itself, e.g.,

    PCI: Add pci_device_to_OF_node() stub for !CONFIG_OF

    Add a stub for pci_device_to_OF_node() so drivers don't need to use
    #ifdef CONFIG_OF around calls to it.

Bjorn

>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 8323cbf93913..421eb6a9e600 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1863,6 +1863,8 @@ static inline void pci_set_of_node(struct pci_dev *dev) { }
>>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
>>  static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
>> +static inline struct device_node *
>> +pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
>>  #endif  /* CONFIG_OF */
>>
>>  #ifdef CONFIG_EEH
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
