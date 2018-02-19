Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlB9j1w1bzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 15:49:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org,
 linux-kernel@vger.kernel.org, brueckner@linux.vnet.ibm.com,
 tmricht@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
In-Reply-To: <20180216175002.GC16919@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180216165245.GD24436@kernel.org> <20180216165616.GF24436@kernel.org>
 <20180216170336.GG24436@kernel.org> <20180216170812.GA16919@kernel.org>
 <20180216172901.GB16919@kernel.org> <20180216175002.GC16919@kernel.org>
Date: Mon, 19 Feb 2018 15:49:28 +1100
Message-ID: <87a7w5lh2f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Fri, Feb 16, 2018 at 02:29:01PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Humm, we need to create two tables, one for 32-bit and another for 64,
>> even with ppc not having (AFAIK) clashes in syscall numbers for 32/64...
>> 
>> Trying to do it now.
>
> Now seems to work, take a look at my perf/core branch, should be one of the first few csets.

LGTM. Thanks for fixing this up.

cheers

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
