Return-Path: <SRS0=aJRt=GL=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405rgV3V23zF1ps
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 00:46:21 +1100 (AEDT)
Date: Wed, 21 Mar 2018 09:46:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras
 <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard
 <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 sathnaga@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/5] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
Message-ID: <20180321094617.6088d579@gandalf.local.home>
In-Reply-To: <b6aff6c7194bd7bb97828db63ca0c82ee4598918.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <b6aff6c7194bd7bb97828db63ca0c82ee4598918.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Mar 2018 16:13:18 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We have some C code that we call into from real mode where we cannot
> take any exceptions. Though the C functions themselves are mostly safe,
> if these functions are traced, there is a possibility that we may take
> an exception. For instance, in certain conditions, the ftrace code uses
> WARN(), which uses a 'trap' to do its job.
> 
> For such scenarios, introduce a new field in paca 'ftrace_disabled',
> which is checked on ftrace entry before continuing. This field can then
> be set to a non-zero value to disable/pause ftrace, and reset to zero to
> resume ftrace.

Looks fine to me:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
