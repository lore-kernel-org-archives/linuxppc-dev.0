Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgQfM5k6HzDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 11:55:38 +1000 (AEST)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 22:55:35 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 379AF3520068
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 21:55:21 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u370tYEL33292546
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 21:55:35 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u371tVle009657
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 21:55:31 -0400
Subject: Re: [PATCH 2/2 v2] powerpc/iommu: Remove the dependency on EEH struct
 in DDW mechanism
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459988405-13991-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1459988405-13991-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160407004833.GB16777@gwshan>
Cc: paulus@samba.org, nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5705BE13.6030105@linux.vnet.ibm.com>
Date: Wed, 6 Apr 2016 22:55:31 -0300
MIME-Version: 1.0
In-Reply-To: <20160407004833.GB16777@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2016 09:48 PM, Gavin Shan wrote:
> On Wed, Apr 06, 2016 at 09:20:05PM -0300, Guilherme G. Piccoli wrote:
>> Fixes: 39baadbf36ce ("powerpc/eeh: Remove eeh information from pci_dn")
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> Thanks, Guilherme. Please make sure if it needs to be backported
> to stable kernel. I assume it probably needs to be in 3.10+.

Thanks for your quick review Gavin! I guess we only need to backport 
this to kernels containing 39baadbf36ce. Stable is a good idea.


>> +	dn = pci_device_to_OF_node(dev);
>> +	pdn = PCI_DN(dn);
>> +	cfg_addr = (pdn->busno << 8) | (pdn->devfn);
>> +	buid = pdn->phb->buid;
>
> No parentheses required on the second operand when getting @cfg_addr.
> It would be nicer to initialize @buid and then @cfg_addr. When
> developers look at the code, they usually check @buid and then
> @cfg_addr.

OK, I'll change this in v3. buid first, cfg_addr second. Also I'll 
remove the parentheses - it's a bad habit of mine =)

Cheers,


Guilherme
