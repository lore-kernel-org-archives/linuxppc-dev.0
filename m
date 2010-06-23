Return-Path: <jbaron@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 9548EB6F11
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 04:04:37 +1000 (EST)
Date: Wed, 23 Jun 2010 14:03:54 -0400
From: Jason Baron <jbaron@redhat.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH 39/40] trace syscalls: Clean confusing {s,r,}name and
	fix ABI breakage
Message-ID: <20100623180353.GB2680@redhat.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-40-git-send-email-imunsie@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277287401-28571-40-git-send-email-imunsie@au1.ibm.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 23, 2010 at 08:03:20PM +1000, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This patch cleans up the preprocessor macros defining system calls by
> standidising on the parameters passing around the system call name, with
> and without it's prefix.
> 
> Overall this makes the preprocessor code easier to understand and
> follow and less likely to introduce bugs due to misunderstanding what to
> place into each parameter.
> 
> The parameters henceforth should be named:
> 
> sname is the system call name WITHOUT the prefix (e.g. read)
> prefix is the prefix INCLUDING the trailing underscore (e.g. sys_)
> 
> These are mashed together to form the full syscall name when required
> like blah##prefix##sname. For just prefix##sname please use the provided
> SYSNAME(prefix,sname) macro instead as it will be safe if prefix itself
> is a macro.
> 
> This patch also fixes an ABI breakage - the ftrace events are once again
> named like 'sys_enter_read' instead of 'enter_sys_read'. The rwtop
> script shipped with perf relies on this ABI. Others may as well.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---

overall this patch is a major improvement! My question though is
about the naming of the compat syscalls in the context of events. I
believe this patch differeniates compat syscall event names as:
"sys32_enter_sname", and "compat_sys_enter_sname". I agree that we keep that
distinction for purposes of defining the actual syscall function. However,
we had discuessed previously about keeping the event name the same for
all compat syscalls. ie they are all called "compat_sys_sname" or some
such. Reason being you could just do "compat_*" to match all compat
events.

thanks,

-Jason
