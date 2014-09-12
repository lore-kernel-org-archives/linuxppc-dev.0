Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC7431A0044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:05:28 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 12 Sep 2014 15:05:27 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8E0CF2BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:05:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8C4fTSO41943248
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 14:41:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8C55L6e019109
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:05:21 +1000
Date: Fri, 12 Sep 2014 15:05:18 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V2] powerpc/eeh: Fix kernel crash when passing through VF
Message-ID: <20140912050518.GA17933@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1410406921-8557-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1410494123.17540.2.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410494123.17540.2.camel@concordia>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2014 at 01:55:23PM +1000, Michael Ellerman wrote:
>On Thu, 2014-09-11 at 11:42 +0800, Wei Yang wrote:
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index 4a45ba8..403445e 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -625,7 +625,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
>>  int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
>>  {
>>  	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
>> -	struct eeh_pe *pe = edev->pe;
>> +	struct eeh_pe *pe = edev ? edev->pe : NULL;
>>  
>>  	if (!pe) {
>>  		pr_err("%s: No PE found on PCI device %s\n",
>
>
>We seem to do this or something similar in a few places. Is it worth having a
>pci_dev_to_eeh_pe() inline?
>

Yes, maybe we just need a eeh_dev_to_pe() because converting
pci_dev to eeh_dev is already coverred by pci_dev_to_eeh_dev().

With eeh_dev_to_pe(), it looks like this:

struct pci_dev *pdev;
struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
struct eeh_pe *pe = eeh_dev_to_pe(edev);

Or another case:

struct device_node *dn;
struct eeh_dev *edev = of_node_to_eeh_dev(dn);
struct eeh_pe *pe = eeh_dev_to_pe(edev);

Thanks,
Gavin

>cheers
>
>
