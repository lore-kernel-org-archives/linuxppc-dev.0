Return-Path: <glikely@secretlab.ca>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB9B91A0339
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 18:31:10 +1000 (EST)
Received: by mail-ig0-f170.google.com with SMTP id h15so3005713igd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 01:31:07 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20140619024651.GC6478@richard>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-15-git-send-email-weiyang@linux.vnet.ibm.com>
 <CACxGe6v6Rdd=GQ8qR5LQ64NThidn7kn3WkKFkOXOsNuWq75D-A@mail.gmail.com>
 <20140619024651.GC6478@richard>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 19 Jun 2014 09:30:47 +0100
Message-ID: <CACxGe6sgOh3MP-03Ge9NK7DWf+dgC98huA9Sv4DcThXNfByf2w@mail.gmail.com>
Subject: Re: [RFC PATCH V3 14/17] ppc/pci: create/release dev-tree node for VFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 gwshan@linux.vnet.ibm.com, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, yan@linux.vnet.ibm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 19, 2014 at 3:46 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Wed, Jun 18, 2014 at 07:26:27PM +0100, Grant Likely wrote:
>>On Tue, Jun 10, 2014 at 2:56 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>>> Currently, powernv platform is not aware of VFs. This means no dev-node
>>> represents a VF. Also, VF PCI device is created when PF driver want to enable
>>> it. This leads to the pdn->pdev and pdn->pe_number an invalid value.
>>>
>>> This patch create/release dev-node for VF and fixs this when a VF's pci_dev
>>> is created.
>>>
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>
>>I don't think this is the right way to handle this. Unless it is a
>>fixup to a buggy devicetree provided by firmware, I don't want to see
>>any code modifying the devicetree to describe stuff that is able to be
>>directly enumerated. Really the pci code should handle the lack of a
>>device_node gracefully. If it cannot then it should be fixed.
>
> Grant,
>
> Glad to see your comment.
>
> I will fix this in the firmware.

That's not really what I meant. The kernel should be able to deal with
virtual functions even if firmware doesn't know how, and the kernel
should not require modifying the device tree to support them.

I'm saying fix the kernel so that a device node is not necessary for
virtual functions.

g.
