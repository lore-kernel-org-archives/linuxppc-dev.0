Return-Path: <bhelgaas@google.com>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com
 [IPv6:2607:f8b0:4002:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B68CC1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 23:22:49 +1000 (AEST)
Received: by ykfl8 with SMTP id l8so12997245ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 06:22:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150616085024.GA1230@richard>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150601234645.GF3631@google.com> <20150603033142.GA22584@richard>
 <20150603051023.GA26652@gwshan> <20150603154638.GL3631@google.com>
 <20150616085024.GA1230@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 16 Jun 2015 08:22:26 -0500
Message-ID: <CAErSpo7uqjQTN0NZyFcjoKMa4THyBwwEAtP29GDmL67WyWC0FQ@mail.gmail.com>
Subject: Re: [PATCH V7 06/10] powerpc/eeh: Create PE for VFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 16, 2015 at 3:50 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Wed, Jun 03, 2015 at 10:46:38AM -0500, Bjorn Helgaas wrote:
>>On Wed, Jun 03, 2015 at 03:10:23PM +1000, Gavin Shan wrote:
>>> It's correct. "The following operations" refers to eeh_add_device_late()
>>> and eeh_sysfs_add_device(). The former one requires the resources for
>>> one particular PCI device (VF here) are finalized (assigned). eeh_sysfs_add_device()
>>> will fail if the sysfs entry for the PCI device isn't populated yet.
>>
>>eeh_add_device_late() contains several things that read config space:
>>eeh_save_bars() caches the entire config header, and
>>eeh_addr_cache_insert_dev() looks at the device resources (which are
>>determined by BARs in config space).  I think this is an error-prone
>>approach.  I think it would be simpler and safer for you to capture what
>>you need in your PCI config accessors.
>>
>>eeh_add_device_late() also contains code to deal with an EEH cache that
>>"might not be removed correctly because of unbalanced kref to the device
>>during unplug time."  That's unrelated to this patch series, but it sounds
>>... like a hacky workaround for some bug in the unplug path.
>>
>>> >>> +        eeh_add_device_early(pdn);
>>> >>> +        eeh_add_device_late(pdev);
>>> >>> +        eeh_sysfs_add_device(pdev);
>>> >>> +}
>>> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_eeh_vf_final_fixup);
>>> >>
>>> >>Ugh.  This is powerpc code, but I don't like using fixups as a hook like
>>> >>this.  There is a pcibios_add_device() -- could this be done there?
>>> >>
>>> >
>>> >I don't like it neither :-) But looks we can't put it in the
>>> >pcibios_add_device().
>>> >
>>> >>If not, what happens after pcibios_add_device() that is required for this
>>> >>code?  Maybe we need a pcibios_bus_add_device() hook?
>>> >
>>> >The pnv_eeh_vf_final_fixup() will try to create sysfs for VFs. This requires
>>> >the VF sysfs(kobj) is initialized properly. If we put these into
>>> >pcibios_add_device(), the eeh_sysfs_add_device() would fail.
>>> >
>>> >Below is the call flow for your reference:
>>> >
>>> >pci_device_add()
>>> >    pcibios_add_device()
>>> >    device_add()                <--- kobj initialized here
>>> >
>>>
>>> We can put it into pcibios_bus_add_device(), but we don't it currently. If
>>> Bjorn agree to add pcibios_bus_add_device(), I'm fine to move the block code
>>> there.
>>
>>I think I'm OK with adding a pcibios_bus_add_device().  I think that would
>>be better than using the fixup mechanism for this.
>>
>
> Hi, Bjorn, Gavin,
>
> Been working on some bug recently, just got a chance to this one.
>
> Would you mind giving me some hint, where you suggest to put the
> pcibios_bus_add_device()?

I would expect it to be called from pci_bus_add_device().

Bjorn
