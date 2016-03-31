Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbHcQ3G0qzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:24:38 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 18:24:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A9DC82CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:24:33 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2V8OPLP51708140
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:24:33 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2V8O1bp020808
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:24:01 +1100
Date: Thu, 31 Mar 2016 13:53:11 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Message-ID: <20160331082311.GA17907@naverao1-tp.ibm.com>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/03/28 05:06PM, Thiago Jung Bauermann wrote:
> Fixes the following testsuite failure:
> 
> $ sudo ./perf test -v kallsyms
>  1: vmlinux symtab matches kallsyms                          :
> --- start ---
> test child forked, pid 12489
> Using /proc/kcore for kernel object code
> Looking at the vmlinux_path (8 entries long)
> Using /boot/vmlinux for symbols
> 0xc00000000003d300: diff name v: .kretprobe_trampoline_holder k: kretprobe_trampoline
> Maps only in vmlinux:
>  c00000000086ca38-c000000000879b6c 87ca38 [kernel].text.unlikely
>  c000000000879b6c-c000000000bf0000 889b6c [kernel].meminit.text
>  c000000000bf0000-c000000000c53264 c00000 [kernel].init.text
>  c000000000c53264-d000000004250000 c63264 [kernel].exit.text
>  d000000004250000-d000000004450000 0 [libcrc32c]
>  d000000004450000-d000000004620000 0 [xfs]
>  d000000004620000-d000000004680000 0 [autofs4]
>  d000000004680000-d0000000046e0000 0 [x_tables]
>  d0000000046e0000-d000000004780000 0 [ip_tables]
>  d000000004780000-d0000000047e0000 0 [rng_core]
>  d0000000047e0000-ffffffffffffffff 0 [pseries_rng]
> Maps in vmlinux with a different name in kallsyms:
> Maps only in kallsyms:
>  d000000000000000-f000000000000000 1000000000010000 [kernel.kallsyms]
>  f000000000000000-ffffffffffffffff 3000000000010000 [kernel.kallsyms]
> test child finished with -1
> ---- end ----
> vmlinux symtab matches kallsyms: FAILED!

You should indent the above output -- in this specific case, the start 
marker interferes with git am.

Apart from that, I have tested this patch and kretprobe works fine. A 
minor nit I had is that we end up with a non-dot function in .text 
without a corresponding function descriptor for kretprobe_trampoline.  
But, since this is a trampoline, I think that is good. So, for this 
patch:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen
