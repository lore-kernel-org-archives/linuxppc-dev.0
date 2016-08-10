Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Vq15QYMzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:30:21 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7ACTURt107777
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:30:19 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9r4ub0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:30:18 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 09:30:17 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 952D03520068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:29:54 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7ACUEup5234692
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:30:14 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7ACUEGO003982
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:30:14 -0300
Subject: Re: [PATCH v2 2/2] powerpc: update pci_controller.refcount for PCI
 devices and buses
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1470789844-16401-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <3e033c05-bf77-18d3-1822-7973b2525373@au1.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 09:30:10 -0300
MIME-Version: 1.0
In-Reply-To: <3e033c05-bf77-18d3-1822-7973b2525373@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <0e3186dd-0800-210a-8e94-8c8d04d9a82f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2016 12:35 AM, Andrew Donnellan wrote:
>>      if (phb->controller_ops.release_device)
>>          phb->controller_ops.release_device(dev);
>> +
>> +    if (unlikely(!phb))
>> +        pr_warn("%s: PCI device %s has null PHB; refcount bug!",
>> +            __func__, dev_name(&dev->dev)); /* WARN_ON ahead */
>
> This should probably go before trying to dereference phb->controller_ops
> above?

You're right; I misplaced this check; will fix that.

Just a bit of explanation/history:

While trying to understand why I didn't hit that null dereference
when I initially hit the WARN_ON (the reason for the 'small change'
in the commit description), I found that back then I checked for
'pci_dev->sysdata' directly (not 'phb' -- early stages of the patch).

The former indeed was null, as it didn't inherit 'pci_bus->sysdata'
on pseries, but the code uses 'phb = dev->bus->sysdata' (and this
was not null as pci_bus->sysdata was actually set).

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
