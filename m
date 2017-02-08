Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ5Gn3BznzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 13:47:45 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v182ht1a107471
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 21:47:42 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ft94127k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 21:47:42 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 12:47:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4638C357805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 13:47:36 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v182lSkl35127486
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 13:47:36 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v182l3DK008442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 13:47:04 +1100
Date: Wed, 8 Feb 2017 13:46:38 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
Subject: Re: [PATCH] drivers/misc/cxl: Avoid unnecessary error message
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485834216-25191-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <43e94920-66a0-88af-81fe-5733ad7cf743@au1.ibm.com>
 <871svab6fj.fsf@concordia.ellerman.id.au>
 <20170207232130.GB10885@gwshan>
 <784859a2-527a-17c6-dbb2-9663b6562846@au1.ibm.com>
 <20170207235720.GA17605@gwshan>
 <87poit9zg0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87poit9zg0.fsf@concordia.ellerman.id.au>
Message-Id: <20170208024638.GA14581@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 08, 2017 at 01:41:19PM +1100, Michael Ellerman wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> On Wed, Feb 08, 2017 at 10:39:55AM +1100, Andrew Donnellan wrote:
>>>On 08/02/17 10:21, Gavin Shan wrote:
>>>>On Tue, Feb 07, 2017 at 10:12:48PM +1100, Michael Ellerman wrote:
>>>>>Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
>>>>
>>>>.../...
>>>>
>>>>>>The effect of this patch is to copy the memory resources from the *real*
>>>>>>PHB to the vPHB, as given through the device tree. It shouldn't have any
>>>>>>practical effect other than squashing this message.
>>>>>
>>>>>It sounds a bit backward to me. If we don't need the resources then
>>>>>why have them?
>>>>>
>>>>>If we have code that thinks that's an error, than maybe that's what
>>>>>needs fixing, or special casing for the vPHB?
>>>>>
>>>>
>>>>Yeah, vPHB is a special case. There are basically two stages in PCI enumeration:
>>>>probing and then resource assignment. vPHB is different from *real* PHB as the
>>>>resource assignment is skipped on it. So vPHB doesn't need any resources to be
>>>>populated. However, there is a check in probing stage and it's where the warning
>>>>message comes from.
>>>>
>>>>   drivers/misc/cxl/vphb.c::cxl_pci_vphb_add()
>>>>   arch/powerpc/kernel/pci-common.c::pcibios_scan_phb()
>>>>                                     pcibios_setup_phb_resources()
>>>>
>>>>   static void pcibios_setup_phb_resources(struct pci_controller *hose,
>>>>                                        struct list_head *resources)
>>>>   {
>>>>       :
>>>>       for (i = 0; i < 3; ++i) {
>>>>            res = &hose->mem_resources[i];
>>>>            if (!res->flags) {
>>>>                if (i == 0)
>>>>                    printk(KERN_ERR "PCI: Memory resource 0 not set for "
>>>>                        "host bridge %s (domain %d)\n",
>>>>                        hose->dn->full_name, hose->global_number);
>>>>                continue;
>>>>            }
>>>>       :
>>>>   }
>>>>
>>>>Alternatively, we can replace prink(KERN_ERR) with pr_debug(). It's going to
>>>>affect all PHBs including the real ones. Andrew and Michael, what do you think? :-)
>>>
>>>In what other circumstances do we get this error printed on real PHBs?
>>>
>>
>> When hose->mem_resources[0] isn't built from PHB's device-tree node. It means
>> the device-tree node's "ranges" isn't populated correctly by loader and it
>> should be very rare ... I never saw it before.
>
>Sounds to me like we could probably just drop the warning. Or make it pr_devel().
>

Agree, I will drop it and post the patch shortly. Thanks for confirm.

Thanks,
Gavin
