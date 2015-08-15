Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B8AF1A1DE5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 20:28:01 +1000 (AEST)
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA08F1401AD
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2015 20:28:00 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so75117508pab.0
 for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2015 03:27:59 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] powerpc/powernv: allocate sparse PE# when using
 M64 BAR in Single PE mode
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1439475071-7001-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1439475071-7001-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150814010300.GC18334@gwshan>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55CF142A.5090208@ozlabs.ru>
Date: Sat, 15 Aug 2015 20:27:54 +1000
MIME-Version: 1.0
In-Reply-To: <20150814010300.GC18334@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/14/2015 11:03 AM, Gavin Shan wrote:
> On Thu, Aug 13, 2015 at 10:11:11PM +0800, Wei Yang wrote:
>> When M64 BAR is set to Single PE mode, the PE# assigned to VF could be
>> sparse.
>>
>> This patch restructures the patch to allocate sparse PE# for VFs when M64
>> BAR is set to Single PE mode.
>>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/include/asm/pci-bridge.h     |    2 +-
>> arch/powerpc/platforms/powernv/pci-ioda.c |   59 +++++++++++++++++++----------
>> 2 files changed, 41 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index 9d33ada..b026ef8 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -214,7 +214,7 @@ struct pci_dn {
>> #ifdef CONFIG_PCI_IOV
>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>> 	u16     num_vfs;		/* number of VFs enabled*/
>> -	int     offset;			/* PE# for the first VF PE */
>> +	int     pe_num_map[MAX_M64_BAR];/* PE# for the first VF PE or array */
>
> Same question as to "m64_map". pdn for non-PF doesn't need it.


non-PF is VF, right?




-- 
Alexey
