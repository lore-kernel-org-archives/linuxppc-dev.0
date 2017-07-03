Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1CKP3hK3zDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 13:28:57 +1000 (AEST)
Date: Mon, 3 Jul 2017 12:28:52 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shuah
 Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests/ftrace: Update multiple kprobes test
 for powerpc
Message-Id: <20170703122852.c7f94b042bdb5a20a5316b0f@kernel.org>
In-Reply-To: <f7a4667e3a43fa6a3e33c4026d412a4dd02b4550.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
 <f7a4667e3a43fa6a3e33c4026d412a4dd02b4550.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017 19:05:38 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> KPROBES_ON_FTRACE is only available on powerpc64le. Update comment to
> clarify this.
> 
> Also, we should use an offset of 8 to ensure that the probe does not
> fall on ftrace location. The current offset of 4 will fall before the
> function local entry point and won't fire, while an offset of 12 or 16
> will fall on ftrace location. Offset 8 is currently guaranteed to not be
> the ftrace location.

OK, looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> index f4d1ff785d67..2a1cb9908746 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> @@ -2,10 +2,10 @@
>  # description: Register/unregister many kprobe events
>  
>  # ftrace fentry skip size depends on the machine architecture.
> -# Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc
> +# Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
>  case `uname -m` in
>    x86_64|i[3456]86) OFFS=5;;
> -  ppc*) OFFS=4;;
> +  ppc64le) OFFS=8;;
>    *) OFFS=0;;
>  esac
>  
> -- 
> 2.13.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
