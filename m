Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 085481A0502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:11 +1100 (AEDT)
In-Reply-To: <1448968422-32178-1-git-send-email-vipin@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [v6] powerpc/pseries: Limit EPOW reset event warnings
Message-Id: <20151215112710.C57C9140AEB@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-12 at 11:13:42 UTC, Vipin K Parashar wrote:
> Kernel prints respective warnings about various EPOW events for
> user information/action after parsing EPOW interrupts. At times
> below EPOW reset event warning is seen to be flooding kernel log
> over a period of time.
> 
> May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> 
> These EPOW reset events are spurious in nature and are triggered by
> firmware without an actual EPOW event being reset. This patch avoids these
> multiple EPOW reset warnings by using a counter variable. This variable
> is incremented every time an EPOW event is reported. Upon receiving a EPOW
> reset event the same variable is checked to filter out spurious events and
> decremented accordingly.
> 
> This patch also improves log messages to better describe EPOW event being
> reported. Merged adjacent log messages into single one to reduce number of
> lines printed per event.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b4af279a7cba5cc1f665485e

cheers
