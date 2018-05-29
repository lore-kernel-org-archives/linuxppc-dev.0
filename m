Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vxdv0g19zDr41
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 11:56:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4T1mwUa005532
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 21:56:00 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j8w6fgqrj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 21:56:00 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 29 May 2018 02:55:58 +0100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, stable@vger.kernel.org,
 "Alastair D'Silva" <alastair@linux.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH-RESEND] cxl: Disable prefault_mode in Radix mode
In-Reply-To: <871sdv5kev.fsf@concordia.ellerman.id.au>
References: <20180518094223.786-1-vaibhav@linux.vnet.ibm.com>
 <871sdv5kev.fsf@concordia.ellerman.id.au>
Date: Tue, 29 May 2018 07:25:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87po1fi5sr.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
>
>> From: Vaibhav Jain <vaibhav@linux.ibm.com>
>>
>> Currently we see a kernel-oops reported on Power-9 while attaching a
>> context to an AFU, with radix-mode and sysfs attr 'prefault_mode' set
>> to anything other than 'none'. The backtrace of the oops is of this
>> form:
>>
>> Unable to handle kernel paging request for data at address 0x00000080
>> Faulting instruction address: 0xc00800000bcf3b20
>> cpu 0x1: Vector: 300 (Data Access) at [c00000037f003800]
>>     pc: c00800000bcf3b20: cxl_load_segment+0x178/0x290 [cxl]
>>     lr: c00800000bcf39f0: cxl_load_segment+0x48/0x290 [cxl]
>>     sp: c00000037f003a80
>>    msr: 9000000000009033
>>    dar: 80
>>  dsisr: 40000000
>>   current = 0xc00000037f280000
>>   paca    = 0xc0000003ffffe600   softe: 3        irq_happened: 0x01
>>     pid   = 3529, comm = afp_no_int
>> <snip>
>> [c00000037f003af0] c00800000bcf4424 cxl_prefault+0xfc/0x248 [cxl]
>> [c00000037f003b50] c00800000bcf8a40 process_element_entry_psl9+0xd8/0x1a0 [cxl]
>> [c00000037f003b90] c00800000bcf944c cxl_attach_dedicated_process_psl9+0x44/0x130 [cxl]
>> [c00000037f003bd0] c00800000bcf5448 native_attach_process+0xc0/0x130 [cxl]
>> [c00000037f003c50] c00800000bcf16cc afu_ioctl+0x3f4/0x5e0 [cxl]
>> [c00000037f003d00] c00000000039d98c do_vfs_ioctl+0xdc/0x890
>> [c00000037f003da0] c00000000039e1a8 ksys_ioctl+0x68/0xf0
>> [c00000037f003df0] c00000000039e270 sys_ioctl+0x40/0xa0
>> [c00000037f003e30] c00000000000b320 system_call+0x58/0x6c
>> --- Exception: c01 (System Call) at 0000000010053bb0
>   ^^^
> This tells patch/git-am to drop the rest of the change log, which is not
> what we want.
>
> I tend to indent stack traces etc with two spaces, which avoids the
> problem. Or in this case we can just drop the line as it's not really
> that informative.
>
> I've fixed it up.
>
> cheers
>

Sorry for missing that and thanks for fixing it in the patch.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
