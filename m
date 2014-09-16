Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96E431A0188
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 17:14:34 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 16 Sep 2014 17:14:34 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 318502CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 17:14:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8G6uSij26148884
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 16:56:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8G7EUDm015890
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 17:14:30 +1000
Date: Tue, 16 Sep 2014 17:14:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Fix kernel crash when passing through VF
Message-ID: <20140916071426.GA28267@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1410406921-8557-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1410768481-27325-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1410840236.12488.1.camel@concordia>
 <20140916060218.GA20909@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140916060218.GA20909@richard>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2014 at 02:02:18PM +0800, Wei Yang wrote:
>On Tue, Sep 16, 2014 at 02:03:56PM +1000, Michael Ellerman wrote:
>>On Mon, 2014-09-15 at 16:08 +0800, Wei Yang wrote:
>>> This patch introduces a marco to convert eeh_dev to eeh_pe. By doing so, it
>>> will prevent converting with NULL pointer.
>>> 
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> 
>>> V2 -> V3:
>>>    1. rebased on 3.17-rc4
>>>    2. introduce a marco
>>>    3. use this marco in several other places
>>
>>Macro :)
>
>:-)
>
>>
>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>> index 59a64f8..0f1b637 100644
>>> --- a/arch/powerpc/kernel/eeh.c
>>> +++ b/arch/powerpc/kernel/eeh.c
>>> @@ -410,7 +410,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
>>>  	}
>>>  	dn = eeh_dev_to_of_node(edev);
>>>  	dev = eeh_dev_to_pci_dev(edev);
>>> -	pe = edev->pe;
>>> +	pe = eeh_dev_to_pe(edev);
>>
>>This looks good, but ..
>>
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index fd03e819..9656f92 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -1824,6 +1824,11 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>>>  {
>>>  	return pdev->dev.archdata.edev;
>>>  }
>>> +
>>> +static inline struct eeh_pe *eeh_dev_to_pe(struct eeh_dev* edev)
>>> +{
>>> +	return edev ? edev->pe : NULL;
>>> +}
>>>  #endif
>>
>>Why is it in linux/pci.h ? It's powerpc specific, it should be in arch/powerpc/include/asm/pci.h
>>
>
>Good question, let me move to powerpc directory and have a try.
>

It would be part of arch/powerpc/include/asm/eeh.h :-)

Thanks,
Gavin

>>cheers
>>
>
>-- 
>Richard Yang
>Help you, Help me
