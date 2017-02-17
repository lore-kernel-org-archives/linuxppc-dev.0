Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPr3f5sdQzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 22:13:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com
Subject: Re: [PATCH 0/3] pci/hotplug/pnv-php: More bug fixes
In-Reply-To: <20170216232854.GA15742@bhelgaas-glaptop.roam.corp.google.com>
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20170216140925.GA21042@bhelgaas-glaptop.roam.corp.google.com>
 <20170216223808.GA7493@gwshan>
 <20170216232854.GA15742@bhelgaas-glaptop.roam.corp.google.com>
Date: Fri, 17 Feb 2017 22:13:01 +1100
Message-ID: <87tw7thxz6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Feb 17, 2017 at 09:38:08AM +1100, Gavin Shan wrote:
>> On Thu, Feb 16, 2017 at 08:09:26AM -0600, Bjorn Helgaas wrote:
>> >On Thu, Feb 16, 2017 at 10:22:31AM +1100, Gavin Shan wrote:
>> >> This series bases on the series: https://patchwork.ozlabs.org/patch/713513.
>> >> This series fixes couple of issues:
>> >> 
>> >>    * Remove WARN_ON() in pnv_php_put_slot(). The parent slot's refcount
>> >>      is decreased when releasing PCI slot. The parent slot can be NULL
>> >>      and no need to give a warning.
>> >>    * The MSI (or MSIx) could be enabled prior to load pnv-php.ko. A
>> >>      backtrace is thrown when phv-php.ko attempts to enable MSI again.
>> >>      PATCH[2/3] skips enabling surprise hotplug if MSI has been enabled
>> >>      by other driver.
>> >>    * PATCH[3/3] doesn't disable MSI that was enabled by other dirver.
>> >>      Also, the upstream port of the PCI slot is disabled when it's
>> >>      destroyed.
>> >> 
>> >> Gavin Shan (3):
>> >>   pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
>> >>   pci/hotplug/pnv-php: Disable surprise hotplug capability on conflicts
>> >>   pci/hotplug/pnv-php: Disable MSI and PCI device properly
>> >
>> >Since this is specific to pnv_php.c and depends on a previous series
>> >applied by Michael, I assume he'll handle this series as well.
>> 
>> Bjorn, yes, I think Michael will take care of this series and all
>> changes to pnv_php.c in future, as we all agreed previously. I was
>> asked by Michael to copy linux-pci@ and you when posting patches for
>> this component.
>
> Thanks, I appreciate at least seeing the changes!  If you mention in
> the cover letter that you expect Michael to merge it, then I will
> immediately know to ignore it unless I object for some reason.

Thanks Bjorn.

I guess I'll plan to merge all small to medium changes to this driver,
unless you object to them.

If there's something big or that looks like it interacts more than usual
with the PCI code I'll ping you for an ack.

cheers
