Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRSpn6xNwzDrFV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 01:53:37 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0OEqDR8083582
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 09:53:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fpsm6fnvj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 09:53:35 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 24 Jan 2018 09:53:34 -0500
Subject: Re: [PATCH v4 3/7] platforms/pseries: Set eeh_pe of EEH_PE_VF type
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
 <20180105164552.36371-4-bryantly@linux.vnet.ibm.com>
 <87shawukgv.fsf@concordia.ellerman.id.au>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Wed, 24 Jan 2018 08:53:28 -0600
MIME-Version: 1.0
In-Reply-To: <87shawukgv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <1059d399-60f8-99db-c498-c4222725712f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 1/23/18 7:14 PM, Michael Ellerman wrote:

> "Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:
>
>> To correctly use EEH code one has to make
>> sure that the EEH_PE_VF is set for dynamic created
>> VFs. Therefore this patch allocates an eeh_pe of
>> eeh type EEH_PE_VF and associates PE with parent.
>>
>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/pci-bridge.h        |  5 ++++-
>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 17 +++++++++++++++++
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>> index 9f66ddebb799..16d70740a76f 100644
>> --- a/arch/powerpc/include/asm/pci-bridge.h
>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>> @@ -211,7 +211,10 @@ struct pci_dn {
>>  	unsigned int *pe_num_map;	/* PE# for the first VF PE or array */
>>  	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>>  #define IODA_INVALID_M64        (-1)
>> -	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>> +	union {
>> +		int     (*m64_map)[PCI_SRIOV_NUM_BARS]; /*Only used in powernv */
>> +		int     last_allow_rc;	/* Only used in pSeries */
>> +	};
>>  #endif /* CONFIG_PCI_IOV */
>>  	int	mps;			/* Maximum Payload Size */
>>  	struct list_head child_list;
> I don't see the point of using a union to save 4 bytes.
>
> And if you look at the current layout of the struct there's actually a 4
> byte hole after mps, so it doesn't actually save any space at all.
>
> I can remove it before applying, unless there's some compelling reason
> for it I'm not seeing.
>
> cheers

No specific reason for the union, you can go ahead and remove it before applying. 

Thanks!

Bryant
