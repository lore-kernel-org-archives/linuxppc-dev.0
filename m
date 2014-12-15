Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 873051A0215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:35:18 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 15 Dec 2014 11:35:18 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6EBF0357806F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:35:15 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBF1ZEUM38142116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:35:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBF1ZEDw032125
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Dec 2014 12:35:14 +1100
Date: Mon, 15 Dec 2014 09:35:12 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pci: remove the multi-init for pci_dn->phb
Message-ID: <20141215013512.GB7341@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1418440144-12122-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141214105742.GA4476@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141214105742.GA4476@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 14, 2014 at 09:57:42PM +1100, Gavin Shan wrote:
>On Sat, Dec 13, 2014 at 11:09:04AM +0800, Wei Yang wrote:
>>pci_dn->phb is set to phb in update_dn_pci_info(), if succeed.
>>
>>This patch removes the duplication of pci_dn->phb initialization.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/kernel/pci_dn.c |    1 -
>> 1 file changed, 1 deletion(-)
>>
>>diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
>>index ddae246..d40b579 100644
>>--- a/arch/powerpc/kernel/pci_dn.c
>>+++ b/arch/powerpc/kernel/pci_dn.c
>>@@ -382,7 +382,6 @@ void pci_devs_phb_init_dynamic(struct pci_controller *phb)
>> 	pdn = dn->data;
>> 	if (pdn) {
>> 		pdn->devfn = pdn->busno = -1;
>>-		pdn->phb = phb;
>> 		phb->firmware_data = pdn;
>
>It seems the patch bases on unmerged code because "phb->firmware_data"
>isn't existing yet in upstream or ppc.next.
>

Oh, my mistake. I will rebase it on the latest upstream.

>Thanks,
>Gavin
>
>> 	}
>> 
>>-- 
>>1.7.9.5
>>
>>_______________________________________________
>>Linuxppc-dev mailing list
>>Linuxppc-dev@lists.ozlabs.org
>>https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Richard Yang
Help you, Help me
