Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wgyXW4nLdzDqKq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 11:53:47 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v551rZqR105128
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Jun 2017 21:53:44 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2avv4tb8pb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Jun 2017 21:53:43 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 5 Jun 2017 11:53:41 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v551rWpD56754180
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 11:53:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v551r7Gj000865
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Jun 2017 11:53:07 +1000
Subject: Re: [PATCH v2] cxl: Avoid double free_irq() for psl,slice interrupts
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
References: <20170602165648.18775-1-vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>, "Alastair D'Silva"
 <alastair@au1.ibm.com>, stable@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 5 Jun 2017 11:52:43 +1000
MIME-Version: 1.0
In-Reply-To: <20170602165648.18775-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ae6f95c6-af67-7057-d959-b3b4af60916c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/06/17 02:56, Vaibhav Jain wrote:
> During an eeh call to cxl_remove can result in double free_irq of
> psl,slice interrupts. This can happen if perst_reloads_same_image == 1
> and call to cxl_configure_adapter() fails during slot_reset
> callback. In such a case we see a kernel oops with following back-trace:
>
> Oops: Kernel access of bad area, sig: 11 [#1]
> Call Trace:
>   free_irq+0x88/0xd0 (unreliable)
>   cxl_unmap_irq+0x20/0x40 [cxl]
>   cxl_native_release_psl_irq+0x78/0xd8 [cxl]
>   pci_deconfigure_afu+0xac/0x110 [cxl]
>   cxl_remove+0x104/0x210 [cxl]
>   pci_device_remove+0x6c/0x110
>   device_release_driver_internal+0x204/0x2e0
>   pci_stop_bus_device+0xa0/0xd0
>   pci_stop_and_remove_bus_device+0x28/0x40
>   pci_hp_remove_devices+0xb0/0x150
>   pci_hp_remove_devices+0x68/0x150
>   eeh_handle_normal_event+0x140/0x580
>   eeh_handle_event+0x174/0x360
>   eeh_event_handler+0x1e8/0x1f0
>
> This patch fixes the issue of double free_irq by checking that
> variables that hold the virqs (err_hwirq, serr_hwirq, psl_virq) are
> not '0' before un-mapping and resetting these variables to '0' when
> they are un-mapped.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

v2 change looks good to me

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
