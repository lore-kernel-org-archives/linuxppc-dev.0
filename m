Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMsd2Xj3zF152
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:52:37 +1000 (AEST)
In-Reply-To: <47c79b5591208f332876fc548186b5b1e3b68e52.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v5,
 01/10] powerpc64/ftrace: Add a field in paca to disable ftrace in
 unsafe code paths
Message-Id: <40gMsd0tycz9s4Z@ozlabs.org>
Date: Wed,  9 May 2018 00:52:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-19 at 07:04:00 UTC, "Naveen N. Rao" wrote:
> We have some C code that we call into from real mode where we cannot
> take any exceptions. Though the C functions themselves are mostly safe,
> if these functions are traced, there is a possibility that we may take
> an exception. For instance, in certain conditions, the ftrace code uses
> WARN(), which uses a 'trap' to do its job.
> 
> For such scenarios, introduce a new field in paca 'ftrace_enabled',
> which is checked on ftrace entry before continuing. This field can then
> be set to zero to disable/pause ftrace, and set to a non-zero value to
> resume ftrace.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ea678ac627e01daf5b4f1da24bf1d0

cheers
