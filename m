Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93BC81A0BE4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 00:09:25 +1100 (AEDT)
In-Reply-To: <1452600863-6294-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: ulrich.weigand@de.ibm.com, Anton Blanchard <anton@samba.org>,
 rostedt@goodmis.org, amodra@gmail.com
Subject: Re: [1/2] scripts/recordmcount.pl: support data in text section on
 powerpc
Message-Id: <20160113130925.4CCC814076E@ozlabs.org>
Date: Thu, 14 Jan 2016 00:09:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-01 at 12:14:22 UTC, Michael Ellerman wrote:
> From: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> 
> If a text section starts out with a data blob before the first
> function start label, disassembly parsing doing in recordmcount.pl
> gets confused on powerpc, leading to creation of corrupted module
> objects.
> 
> This was not a problem so far since the compiler would never create
> such text sections.  However, this has changed with a recent change
> in GCC 6 to support distances of > 2GB between a function and its
> assoicated TOC in the ELFv2 ABI, exposing this problem.
> 
> There is already code in recordmcount.pl to handle such data blobs
> on the sparc64 platform.  This patch uses the same method to handle
> those on powerpc as well.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/2e50c4bef77511b42cc226865d

cheers
