Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0C3B1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 01:39:10 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 707301401C7
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:39:10 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 00:39:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6FFA13578056
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:39:07 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1PEcwJE56099022
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:39:07 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1PEcYYo022645
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:38:34 +1100
Date: Thu, 25 Feb 2016 20:08:04 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [PATCH 01/12] powerpc/module: Only try to generate the
 ftrace_caller() stub once
Message-ID: <20160225143800.GA5530@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2016-02-25 01:28:24]:

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

For all of the patches in the series.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


Regards,
Kamalesh.
