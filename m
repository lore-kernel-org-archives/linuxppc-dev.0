Return-Path: <jwboyer@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 96EECDDDF0
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 22:28:05 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so3403041wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Apr 2009 04:28:03 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 1 Apr 2009 07:27:56 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Problem with module_init?
Message-ID: <20090401112756.GA14171@yoda.jdub.homelinux.org>
References: <20090331143742.083c6cb0@lappy.seanm.ca>
	<20090331231153.256d1bf4@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090331231153.256d1bf4@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 31, 2009 at 11:11:53PM -0400, Sean MacLennan wrote:
>8d1cf34e7ad5c7738ce20d20bd7f002f562cb8b5 is first bad commit
>commit 8d1cf34e7ad5c7738ce20d20bd7f002f562cb8b5
>Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Date:   Thu Mar 19 19:34:08 2009 +0000
>
>    powerpc/mm: Tweak PTE bit combination definitions
>    
>    This patch tweaks the way some PTE bit combinations are defined, in
>    such a way that the 32 and 64-bit variant become almost identical
>    and that will make it easier to bring in a new common pte-* file
>    for the new variant of the Book3-E support.
>    
>    The combination of bits defining access to kernel pages are now
>    clearly separated from the combination used by userspace and the
>    core VM. The resulting generated code should remain identical
>    unless I made a mistake. 
>    Note: While at it, I removed a non-sensical statement related to
>    CONFIG_KGDB in ppc_mmu_32.c which could cause kernel mappings to be
>    user accessible when that option is enabled. Probably something
>    that bitrot. 
>    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
>:040000 040000 c105fb9641b078f1a8a60c2a7900ca2dd088b364
>e90678246962d7a455aa27ba12814c11cd9b3c22 M      arch

I'm assuming this is the result of a git-bisect run?

Can I also assume you were loading the module on your Warp board?

Ben, have you tested module loads on 4xx since you redid this?

josh
