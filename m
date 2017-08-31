Return-Path: <adrian.hunter@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjcMk0xmnzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:22:09 +1000 (AEST)
Subject: Re: [PATCH v2] perf test powerpc: Fix 'Object code reading' test
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, namhyung@kernel.org, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
References: <1504170896-7876-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <b1d6fc01-05ff-708c-a61a-b7cb6706ab8d@intel.com>
Date: Thu, 31 Aug 2017 12:15:29 +0300
MIME-Version: 1.0
In-Reply-To: <1504170896-7876-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/08/17 12:14, Ravi Bangoria wrote:
> 'Object code reading' test always fails on powerpc guest. Two reasons
> for the failure are:
> 
> 1. When elf section is too big (size beyond 'unsigned int' max value).
> objdump fails to disassemble from such section. This was fixed with
> commit 0f6329bd7fc ("binutils/objdump: Fix disassemble for huge elf
> sections") in binutils.
> 
> 2. When the sample is from hypervisor. Hypervisor symbols can not
> be resolved within guest and thus thread__find_addr_map() fails for
> such symbols. Fix this by ignoring hypervisor symbols in the test.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
>  - Add pr_debug()
> 
>  tools/perf/tests/code-reading.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index 761c5a4..466a462 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -237,6 +237,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  
>  	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, addr, &al);
>  	if (!al.map || !al.map->dso) {
> +		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
> +			pr_debug("Hypervisor address can not be resolved - skipping\n");
> +			return 0;
> +		}
> +
>  		pr_debug("thread__find_addr_map failed\n");
>  		return -1;
>  	}
> 
