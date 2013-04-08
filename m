Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CF852C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 23:14:36 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 8 Apr 2013 07:14:33 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 59A923E40071
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 07:07:52 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r38D7dcf073120
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 07:07:39 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r38DAO6q016640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 07:10:25 -0600
Message-ID: <5162C11A.8040201@linux.vnet.ibm.com>
Date: Mon, 08 Apr 2013 08:07:38 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics
 adapters on Power
References: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
 <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com>
 <20130408052522.GB9550@concordia>
In-Reply-To: <20130408052522.GB9550@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 klebers@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/2013 12:25 AM, Michael Ellerman wrote:
> On Fri, Apr 05, 2013 at 02:11:01PM -0600, Bjorn Helgaas wrote:
>> On Thu, Apr 4, 2013 at 3:58 PM, Brian King <brking@linux.vnet.ibm.com> wrote:
>>>
>>> Initialize dev->dev.type such that the PCI group attributes for boot_vga
>>> and SR-IOV can be displayed if appropriate. This fixes an issue seen on
>>> Power preventing X from auto initializing a graphics adapter when using KMS.
>>>
>>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>>> ---
>>>
>>>  arch/powerpc/kernel/pci_of_scan.c |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff -puN arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type arch/powerpc/kernel/pci_of_scan.c
>>> --- linux/arch/powerpc/kernel/pci_of_scan.c~powerpc_set_pci_dev_type    2013-04-03 09:43:19.000000000 -0500
>>> +++ linux-bjking1/arch/powerpc/kernel/pci_of_scan.c     2013-04-03 09:43:19.000000000 -0500
>>> @@ -141,6 +141,7 @@ struct pci_dev *of_create_pci_dev(struct
>>>         dev->dev.of_node = of_node_get(node);
>>>         dev->dev.parent = bus->bridge;
>>>         dev->dev.bus = &pci_bus_type;
>>> +       dev->dev.type = &pci_dev_type;
>>>         dev->devfn = devfn;
>>>         dev->multifunction = 0;         /* maybe a lie? */
>>>         dev->needs_freset = 0;          /* pcie fundamental reset required */
>>
>> I think sparc has the same issue in its own copy of of_create_pci_dev().
>>
>> Of course, both of_create_pci_dev() implementations are basically
>> copies of the generic pci_setup_device() that most arches use.  That's
>> the reason why I wish sparc and powerpc had used config space
>> accessors that hid the OF mangling internally so they could use the
>> generic pci_setup_device() instead of cloning it.
>>
>> Of course, they don't, and that's too much work for fixing this issue,
>> but if anybody wanted to work on that, I think it would be an
>> interesting project.
>>
>> But what if you set dev->dev.type in alloc_pci_dev()?  I think if you
>> did that, you wouldn't need to export "pci_dev_type," and  it should
>> fix this for both powerpc and sparc.
> 
> That sounds good, Brian can you confirm that works and send a new series
> using that technique.

It does indeed work. I've sent a new series using this technique.

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
