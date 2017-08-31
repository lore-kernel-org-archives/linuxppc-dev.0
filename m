Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjnvY1NHSzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 02:31:53 +1000 (AEST)
Date: Thu, 31 Aug 2017 13:31:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 namhyung@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf test powerpc: Fix 'Object code reading' test
Message-ID: <20170831163146.GE4831@kernel.org>
References: <1504170896-7876-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <b1d6fc01-05ff-708c-a61a-b7cb6706ab8d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b1d6fc01-05ff-708c-a61a-b7cb6706ab8d@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Aug 31, 2017 at 12:15:29PM +0300, Adrian Hunter escreveu:
> On 31/08/17 12:14, Ravi Bangoria wrote:
> > 'Object code reading' test always fails on powerpc guest. Two reasons
> > for the failure are:
> > 
> > 1. When elf section is too big (size beyond 'unsigned int' max value).
> > objdump fails to disassemble from such section. This was fixed with
> > commit 0f6329bd7fc ("binutils/objdump: Fix disassemble for huge elf
> > sections") in binutils.
> > 
> > 2. When the sample is from hypervisor. Hypervisor symbols can not
> > be resolved within guest and thus thread__find_addr_map() fails for
> > such symbols. Fix this by ignoring hypervisor symbols in the test.
> > 
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo
