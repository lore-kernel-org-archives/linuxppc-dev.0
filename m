Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B5301A0342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 00:08:44 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF2DB14032B
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 00:08:43 +1100 (AEDT)
Date: Thu, 25 Feb 2016 14:08:39 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 01/12] powerpc/module: Only try to generate the
 ftrace_caller() stub once
Message-ID: <20160225130839.GC21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 01:28:24AM +1100, Michael Ellerman wrote:
> Currently we generate the module stub for ftrace_caller() at the bottom
> of apply_relocate_add(). However apply_relocate_add() is potentially
> called more than once per module, which means we will try to generate
> the ftrace_caller() stub multiple times.
> 
> Although the current code deals with that correctly, ie. it only
> generates a stub the first time, it would be clearer to only try to
> generate the stub once.
> 
> Note also on first reading it may appear that we generate a different
> stub for each section that requires relocation, but that is not the
> case. The code in stub_for_addr() that searches for an existing stub
> uses sechdrs[me->arch.stubs_section], ie. the single stub section for
> this module.
> 
> A cleaner approach is to only generate the ftrace_caller() stub once,
> from module_finalize(). An additional benefit is we can clean the ifdefs
> up a little.
> 
> Finally we must propagate the const'ness of some of the pointers passed
> to module_finalize(), but that is also an improvement.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Torsten Duwe <duwe@suse.de>

	Torsten
