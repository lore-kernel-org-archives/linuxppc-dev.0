Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EF4E1A1009
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 12:45:30 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 28 Oct 2015 07:15:27 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D7E4DE0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 07:15:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9S1jO9V32178252
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 07:15:24 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9S1jOhx009310
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 07:15:24 +0530
Date: Wed, 28 Oct 2015 09:45:23 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 03/12] powerpc/pci: Cache VF index in pci_dn
Message-ID: <20151028014523.GB16965@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <87pp00otn1.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87pp00otn1.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 28, 2015 at 09:04:34AM +1100, Daniel Axtens wrote:
>Hi,
>
>>
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index b3a226b..3d7e537 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -210,6 +210,7 @@ struct pci_dn {
>>  #define IODA_INVALID_PE		(-1)
>>  #ifdef CONFIG_PPC_POWERNV
>>  	int	pe_number;
>> +	int     vf_index;		/* VF index in the PF */
>
>Here, vf_index is inside CONFIG_PPC_POWERNV...
>
>>  #ifdef CONFIG_PCI_IOV
>>  	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>>  	u16     num_vfs;		/* number of VFs enabled*/
>> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>> index b3b4df9..f771130 100644
>> --- a/arch/powerpc/kernel/pci_dn.c
>> +++ b/arch/powerpc/kernel/pci_dn.c
>> @@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>>  #ifdef CONFIG_PCI_IOV
>>  static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>  					   struct pci_dev *pdev,
>> +					   int vf_index,
>>  					   int busno, int devfn)
>>  {
>>  	struct pci_dn *pdn;
>> @@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>>  	pdn->parent = parent;
>>  	pdn->busno = busno;
>>  	pdn->devfn = devfn;
>> +	pdn->vf_index = vf_index;
>>  #ifdef CONFIG_PPC_POWERNV
>>  	pdn->pe_number = IODA_INVALID_PE;
>... but here, vf_index is outside CONFIG_PPC_POWERNV.
>

Hey, Daniel

Glad to see you comment. You are right, to be consistent this should be put
into the CONFIG_PPC_POWERNV. Will change it next version.

>Otherwise, the patch looks fine to me.
>
>I'm still trying to get my head around SR-IOV generally - once I do I
>will add any more comments I have or add a reviewed-by.
>
>Regards,
>Daniel



-- 
Richard Yang
Help you, Help me
