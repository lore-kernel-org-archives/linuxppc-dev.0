Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0230.hostedemail.com
 [216.40.44.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41E1C1A0907
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 04:35:05 +1100 (AEDT)
Date: Wed, 23 Dec 2015 12:34:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Bin <huawei.libin@huawei.com>
Cc: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 3/5] powerpc: ftrace: fix the comments for
 ftrace_modify_code
Message-ID: <20151223123459.722b4a5c@gandalf.local.home>
In-Reply-To: <1449367378-29430-4-git-send-email-huawei.libin@huawei.com>
References: <1449367378-29430-1-git-send-email-huawei.libin@huawei.com>
 <1449367378-29430-4-git-send-email-huawei.libin@huawei.com>
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

On Sun, 6 Dec 2015 10:02:56 +0800
Li Bin <huawei.libin@huawei.com> wrote:

> There is no need to worry about module and __init text disappearing
> case, because that ftrace has a module notifier that is called when
> a module is being unloaded and before the text goes away and this
> code grabs the ftrace_lock mutex and removes the module functions
> from the ftrace list, such that it will no longer do any
> modifications to that module's text, the update to make functions
> be traced or not is done under the ftrace_lock mutex as well.
> And by now, __init section codes should not been modified
> by ftrace, because it is black listed in recordmcount.c and
> ignored by ftrace.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Li Bin <huawei.libin@huawei.com>

Hi, can I get a POWERPC maintainer to ack this, or you can take it too.

-- Steve

> ---
>  arch/powerpc/kernel/ftrace.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 44d4d8e..83e3c88 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -47,13 +47,11 @@ ftrace_modify_code(unsigned long ip, unsigned int old, unsigned int new)
>  	unsigned int replaced;
>  
>  	/*
> -	 * Note: Due to modules and __init, code can
> -	 *  disappear and change, we need to protect against faulting
> -	 *  as well as code changing. We do this by using the
> -	 *  probe_kernel_* functions.
> -	 *
> -	 * No real locking needed, this code is run through
> -	 * kstop_machine, or before SMP starts.
> +	 * Note:
> +	 * We are paranoid about modifying text, as if a bug was to happen, it
> +	 * could cause us to read or write to someplace that could cause harm.
> +	 * Carefully read and modify the code with probe_kernel_*(), and make
> +	 * sure what we read is what we expected it to be before modifying it.
>  	 */
>  
>  	/* read the text we want to modify */
