Return-Path: <ebiederm@xmission.com>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E63691A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 01:35:18 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>,
 linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
Date: Fri, 10 Jul 2015 08:41:28 -0500
In-Reply-To: <20150710113331.4368.63745.stgit@softrs> (Hidehiro Kawai's
 message of "Fri, 10 Jul 2015 20:33:31 +0900")
Message-ID: <87wpy82kqf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:

> You can call panic notifiers and kmsg dumpers before kdump by
> specifying "crash_kexec_post_notifiers" as a boot parameter.
> However, it doesn't make sense if kdump is not available.  In that
> case, disable "crash_kexec_post_notifiers" boot parameter so that
> you can't change the value of the parameter.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

You are confusing kexec on panic and CONFIG_CRASH_DUMP
which is about the tools for reading the state of the previous kernel.

Eric

> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  kernel/panic.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 04e91ff..5252331 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -502,12 +502,14 @@ __visible void __stack_chk_fail(void)
>  core_param(pause_on_oops, pause_on_oops, int, 0644);
>  core_param(panic_on_warn, panic_on_warn, int, 0644);
>  
> +#ifdef CONFIG_CRASH_DUMP
>  static int __init setup_crash_kexec_post_notifiers(char *s)
>  {
>  	crash_kexec_post_notifiers = true;
>  	return 0;
>  }
>  early_param("crash_kexec_post_notifiers", setup_crash_kexec_post_notifiers);
> +#endif
>  
>  static int __init oops_setup(char *s)
>  {
