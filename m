Return-Path: <srs0=xhv0=i2=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412Jc33kk3zDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 20:31:31 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 412Jc31ftmz96xt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 20:31:31 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 412Jc22Vrpz9s0W
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2018 20:31:29 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w58ASuG2066631
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2018 06:31:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jfps8ue2y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 08 Jun 2018 06:31:27 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 8 Jun 2018 11:31:26 +0100
Subject: Re: [v3 PATCH 2/5] powerpc/pseries: Fix endainness while restoring of
 r3 in MCE handler.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: stable@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839249913.25118.1191250274945665204.stgit@jupiter.in.ibm.com>
 <87fu1xvkjc.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 8 Jun 2018 16:01:21 +0530
MIME-Version: 1.0
In-Reply-To: <87fu1xvkjc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <f53147a1-bb9f-a1a8-8418-90ce9669d34c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/2018 12:20 PM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> During Machine Check interrupt on pseries platform, register r3 points
>> RTAS extended event log passed by hypervisor. Since hypervisor uses r3
>> to pass pointer to rtas log, it stores the original r3 value at the
>> start of the memory (first 8 bytes) pointed by r3. Since hypervisor
>> stores this info and rtas log is in BE format, linux should make
>> sure to restore r3 value in correct endian format.
> 
> Can we hit this under KVM? And if so what if the KVM/qemu is running
> little endian, does it still write the value BE?

FWNMI support for qemu is still not in. But when it is in, we can hit
this. But whenever FWNMI support gets in, it should pass RTAS event data
always in BE format including original r3 value.

Thanks,
-Mahesh.
> 
> cheers
> 
