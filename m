Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCP360BJczDvPj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 07:21:05 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA7KKgX9125472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 15:21:03 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jsq5phjg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 15:21:02 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 20:21:01 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 90A351B08067
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 20:23:10 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA7KKwAt39583838
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 20:20:58 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA7KKv54024360
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 13:20:58 -0700
Subject: Re: [RFC v2 6/7] mm/powerpc: Use generic VDSO remap and unmap
 functions
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christopher Covington <cov@codeaurora.org>, criu@openvz.org,
 Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org
References: <20161101171101.24704-1-cov@codeaurora.org>
 <20161101171101.24704-6-cov@codeaurora.org>
 <87oa1vn8lc.fsf@concordia.ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 7 Nov 2016 21:20:56 +0100
MIME-Version: 1.0
In-Reply-To: <87oa1vn8lc.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <e974b3a6-2a80-a416-7583-4b0644e8a613@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2016 05:59, Michael Ellerman wrote:
> Christopher Covington <cov@codeaurora.org> writes:
> 
>> The PowerPC VDSO remap and unmap code was copied to a generic location,
>> only modifying the variable name expected in mm->context (vdso instead of
>> vdso_base) to match most other architectures. Having adopted this generic
>> naming, drop the code in arch/powerpc and use the generic version.
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  arch/powerpc/Kconfig                     |  1 +
>>  arch/powerpc/include/asm/Kbuild          |  1 +
>>  arch/powerpc/include/asm/mm-arch-hooks.h | 28 -------------------------
>>  arch/powerpc/include/asm/mmu_context.h   | 35 +-------------------------------
>>  4 files changed, 3 insertions(+), 62 deletions(-)
>>  delete mode 100644 arch/powerpc/include/asm/mm-arch-hooks.h
> 
> This looks OK.
> 
> Have you tested it on powerpc? I could but I don't know how to actually
> trigger these paths, I assume I need a CRIU setup?

FWIW, tested on ppc64le using a sample test process moving its VDSO and
then catching a signal on 4.9-rc4 and using CRIU on top of 4.8 with
sightly changes to due minor upstream changes.

Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
