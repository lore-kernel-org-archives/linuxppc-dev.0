Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zk09x4FY4zF1NP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 17:15:29 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1H6Ecgj030480
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 01:15:27 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g67yras2m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 01:15:26 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Sat, 17 Feb 2018 06:15:25 -0000
Subject: Re: [PATCH 1/3] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org,
 linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
 tmricht@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180216165245.GD24436@kernel.org> <20180216165616.GF24436@kernel.org>
 <20180216170336.GG24436@kernel.org> <20180216170812.GA16919@kernel.org>
 <20180216172901.GB16919@kernel.org> <20180216175002.GC16919@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Sat, 17 Feb 2018 11:47:15 +0530
MIME-Version: 1.0
In-Reply-To: <20180216175002.GC16919@kernel.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <a7b11ddd-2c24-ff15-0861-6621053f9c86@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops.. Really sorry about that.

I've tested acme/perf/core on ubuntu ppc32 with and without libaudit-dev
and it's working fine.

Thank you very much for fixing it,
Ravi

On 02/16/2018 11:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 16, 2018 at 02:29:01PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Humm, we need to create two tables, one for 32-bit and another for 64,
>> even with ppc not having (AFAIK) clashes in syscall numbers for 32/64...
>>
>> Trying to do it now.
> Now seems to work, take a look at my perf/core branch, should be one of the first few csets.
>
> perfbuilder@cc1a85517216:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c 
> 	[192] = "mmap2",
> perfbuilder@cc1a85517216:/git/perf$ powerpc-linux-gnu-gcc --version
> powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
> perfbuilder@cc1a85517216:/git/perf$
>
> perfbuilder@9d7fc9dcfb73:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c
> 	[192] = "mmap2",
> perfbuilder@9d7fc9dcfb73:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_64.c
> perfbuilder@9d7fc9dcfb73:/git/perf$ powerpc64-linux-gnu-gcc --version
> powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
> perfbuilder@9d7fc9dcfb73:/git/perf$ 
>
