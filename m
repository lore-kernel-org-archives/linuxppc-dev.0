Return-Path: <vrbagal1@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418Mqd3Tr9zF09q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 17:17:33 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5I7DxWV146006
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 03:17:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jp6c0uk2q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 03:17:30 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vrbagal1@linux.vnet.ibm.com>;
 Mon, 18 Jun 2018 03:17:29 -0400
Subject: Re: [PATCH] powerpc/eeh: Avoid misleading message "EEH: no capable
 adapters found"
To: Russell Currey <ruscur@russell.cc>,
 "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: kernel@gpiccoli.net
References: <1521771052-5973-1-git-send-email-maurosr@linux.vnet.ibm.com>
 <1524789288.2096.0.camel@russell.cc>
From: Venkat Rao B <vrbagal1@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 12:47:23 +0530
MIME-Version: 1.0
In-Reply-To: <1524789288.2096.0.camel@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <353bdc35-1573-7608-82a3-4463368fbd0c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 27 April 2018 06:04 AM, Russell Currey wrote:
> On Thu, 2018-03-22 at 23:10 -0300, Mauro S. M. Rodrigues wrote:
>> Due to recent refactoring in EEH in:
>> commit b9fde58db7e5 ("powerpc/powernv: Rework EEH initialization on
>> powernv")
>> a misleading message was seen in the kernel message buffer:
>>
>> [    0.108431] EEH: PowerNV platform initialized
>> [    0.589979] EEH: No capable adapters found
>>
>> This happened due to the removal of the initialization delay for
>> powernv
>> platform.
>>
>> Even though the EEH infrastructure for the devices is eventually
>> initialized and still works just fine the eeh device probe step is
>> postponed in order to assure the PEs are created. Later
>> pnv_eeh_post_init does the probe devices job but at that point the
>> message was already shown right after eeh_init flow.
>>
>> This patch introduces a new flag EEH_POSTPONED_PROBE to represent
>> that
>> temporary state and avoid the message mentioned above and showing the
>> follow one instead:
>>
>> [    0.107724] EEH: PowerNV platform initialized
>> [    4.844825] EEH: PCI Enhanced I/O Error Handling Enabled
>>
>> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> 
> Good idea, thanks for the patch.
> 
> Acked-by: Russell Currey <ruscur@russell.cc>
>


Hi Mauro,

I got a chance to test your patch, I applied your patch on top of 
mainline kernel commit:8efcf34a263965e471e3999904f94d1f6799d42a and 
booted and I don't see the message "No capable adapters found" instead I 
see "EEH: PCI Enhanced I/O Error Handling Enabled" as desired. But I 
have not injected any EEH.Hope this should qualify your patch.

Tested-by:Venkat Rao B <vrbagal1@linux.vnet.ibm.com>

Regards,
Venkat.
