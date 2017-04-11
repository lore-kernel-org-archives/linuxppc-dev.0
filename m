Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2P5f6J2PzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 20:52:38 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3BAnN2q008661
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 06:52:32 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29rcsys9tv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 06:52:32 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 06:52:31 -0400
Subject: Re: [PATCH v2] ppc64/kprobe: Fix oops when kprobed on 'stdu'
 instruction
To: Balbir Singh <bsingharora@gmail.com>
References: <1491887293-3815-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1491900956.8380.5.camel@gmail.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com,
 chris@distroguy.com, viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 anton@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 "ananth@in.ibm.com" <ananth@in.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 11 Apr 2017 16:22:18 +0530
MIME-Version: 1.0
In-Reply-To: <1491900956.8380.5.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <58ECB562.8070903@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Balbir for the review,

On Tuesday 11 April 2017 02:25 PM, Balbir Singh wrote:
> On Tue, 2017-04-11 at 10:38 +0530, Ravi Bangoria wrote:
>> If we set a kprobe on a 'stdu' instruction on powerpc64, we see a kernel 
>> OOPS:
>>
>>   [ 1275.165932] Bad kernel stack pointer cd93c840 at c000000000009868
>>   [ 1275.166378] Oops: Bad kernel stack pointer, sig: 6 [#1]
>>   ...
>>   GPR00: c000001fcd93cb30 00000000cd93c840 c0000000015c5e00 00000000cd93c840
>>   ...
>>   [ 1275.178305] NIP [c000000000009868] resume_kernel+0x2c/0x58
>>   [ 1275.178594] LR [c000000000006208] program_check_common+0x108/0x180
>>
>> Basically, on 64 bit system, when user probes on 'stdu' instruction,
>> kernel does not emulate actual store in emulate_step itself because it
>> may corrupt exception frame. So kernel does actual store operation in
>> exception return code i.e. resume_kernel().
>>
>> resume_kernel() loads the saved stack pointer from memory using lwz,
>> effectively loading a corrupt (32bit) address, causing the kernel crash.
>>
>> Fix this by loading the 64bit value instead.
>>
>> Fixes: be96f63375a1 ("powerpc: Split out instruction analysis part of emulate_step()") 
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> 
>> ---
> The patch looks correct to me from the description and code. I have not
> validated that the write to GPR1(r1) via store of r8 to 0(r5) is indeed correct.
> I would assume r8 should contain regs->gpr[r1] with the updated ea that
> is written down to the GPR1(r1) which will be what we restore when we return
> from the exception.

emulate_step() updates regs->gpr[r1] with the new value. So,
regs->gpr[r1] and GPR(r1) both are same at resume_kernel.

At resume_kernel, r1 points to the exception frame. Address
of frame preceding exception frame gets loaded in r8 with:

    addi    r8,r1,INT_FRAME_SIZE

Let me know if you need more details.

Ravi
