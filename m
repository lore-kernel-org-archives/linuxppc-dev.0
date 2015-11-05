Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D51B51A0DD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:46:38 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 Nov 2015 09:46:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 86BB62BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 10:46:35 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA5NkCfs35979448
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 10:46:20 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA5Nk2Gi021483
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Nov 2015 10:46:03 +1100
Date: Fri, 6 Nov 2015 10:45:37 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 03/50] powerpc/pci: Cleanup on struct pci_controller_ops
Message-ID: <20151105234537.GB30465@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <87si4khyau.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87si4khyau.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 06, 2015 at 09:32:57AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> Each PHB has one instance of "struct pci_controller_ops", which
>> includes various callbacks called by PCI subsystem. In the definition
>> of this struct, some callbacks have explicit names for its arguments,
>> but the left don't have.
>>
>> This adds all explicit names of the arguments to the callbacks in
>> "struct pci_controller_ops" so that the code looks consistent.
>
>Thank you very much for doing this - I should have done it the first
>time I created pci_controller_ops.
>
>They all look good, with one nit-pick:
>
>> -	void		(*shutdown)(struct pci_controller *);
>> +	void		(*shutdown)(struct pci_controller *hose);
>
>I think we're trying to move from hose to phb in new code.
>

Nope, We don't have the movement as I explained in previous reply:
hose for pci_controller while phb represents pnv_phb on PowerNV
platform.

>Once that is fixed:
>  Reviewed-by: Daniel Axtens <dja@axtens.net>
>

Thanks,
Gavin

>
>>  };
>>  
>>  /*
>> -- 
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
