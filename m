Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B4451A0060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 00:31:37 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E2EC61402D6
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 00:31:36 +1100 (AEDT)
Date: Thu, 25 Feb 2016 14:31:33 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 03/12] powerpc/module: Create a special stub for
 ftrace_caller()
Message-ID: <20160225133133.GE21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-3-git-send-email-mpe@ellerman.id.au>
 <56CE4616.9080100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CE4616.9080100@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 11:08:54AM +1100, Balbir Singh wrote:
> How about some comments on r2
> r2 is still pointing to the module's toc, will be saved by ftrace_caller and restored by the instruction following bl ftrace_caller (after patching _mcount/nop)

To be precise: ftrace_caller needs to save _and_ restore r2 in case of -mprofile-kernel.

> > +	/* Stub uses address relative to kernel_toc */
> > +	reladdr = (unsigned long)ftrace_caller - get_paca()->kernel_toc;

kernel_toc is a compile time constant; do you really want to look it up in
memory at runtime each time? It's a bit tricky to get the +- 0x8000 right
OTOH...

I wrote:
extern unsigned long __toc_start;
    reladdr = addr - ((unsigned long)(&__toc_start) + 0x8000UL);

looks a bit odd, but evaluates to a constant for ftrace_caller.

Either way is fine with me:

Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Torsten Duwe <duwe@suse.de>

> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

	Torsten
