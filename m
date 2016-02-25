Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438AD1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 01:25:58 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9C0F140324
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 01:25:57 +1100 (AEDT)
Date: Thu, 25 Feb 2016 15:25:54 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 08/12] powerpc/ftrace: Rework ftrace_caller()
Message-ID: <20160225142554.GI21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-8-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456324115-21144-8-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2016 at 01:28:31AM +1100, Michael Ellerman wrote:
> The main change is to just use paca->kernel_toc, rather than a branch to
> +4 and mflr etc. That makes the code simpler and should also perform
> better.

Indeed.

> There was also a sequence after ftrace_call() where we load from
> pt_regs->nip, move to LR, then a few instructions later load from LRSAVE
> and move to LR. Instead I think we want to put pt_regs->nip into CTR and
> branch to it later.

Yes, I did some of this cleanup in the livepatch implementation.

> We also rework some of the SPR loads to hopefully speed them up a bit.
> Also comment the asm much more, to hopefully make it clearer.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Torsten Duwe <duwe@suse.de>

	Torsten
