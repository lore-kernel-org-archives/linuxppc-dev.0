Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjgds3q24zF1PG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 04:50:09 +1100 (AEDT)
Date: Fri, 16 Feb 2018 14:50:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
 namhyung@kernel.org, linux-kernel@vger.kernel.org,
 brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
Message-ID: <20180216175002.GC16919@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180216165245.GD24436@kernel.org>
 <20180216165616.GF24436@kernel.org>
 <20180216170336.GG24436@kernel.org>
 <20180216170812.GA16919@kernel.org>
 <20180216172901.GB16919@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216172901.GB16919@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Feb 16, 2018 at 02:29:01PM -0300, Arnaldo Carvalho de Melo escreveu:
> Humm, we need to create two tables, one for 32-bit and another for 64,
> even with ppc not having (AFAIK) clashes in syscall numbers for 32/64...
> 
> Trying to do it now.

Now seems to work, take a look at my perf/core branch, should be one of the first few csets.

perfbuilder@cc1a85517216:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c 
	[192] = "mmap2",
perfbuilder@cc1a85517216:/git/perf$ powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
perfbuilder@cc1a85517216:/git/perf$

perfbuilder@9d7fc9dcfb73:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_32.c
	[192] = "mmap2",
perfbuilder@9d7fc9dcfb73:/git/perf$ grep 192 /tmp/build/perf/arch/powerpc/include/generated/asm/syscalls_64.c
perfbuilder@9d7fc9dcfb73:/git/perf$ powerpc64-linux-gnu-gcc --version
powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
perfbuilder@9d7fc9dcfb73:/git/perf$ 
