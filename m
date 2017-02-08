Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ3vd2JvjzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 12:46:04 +1100 (AEDT)
Date: Wed, 8 Feb 2017 10:45:52 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: ananth@linux.vnet.ibm.com, mingo@kernel.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
Message-Id: <20170208104552.497ea03171826cfb9e63b557@kernel.org>
In-Reply-To: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed,  8 Feb 2017 01:24:14 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> kprobe_exceptions_notify() is not used on some of the architectures such
> as arm[64] and powerpc anymore. Introduce a weak variant for such
> architectures.
> 

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for all patches in this series.

Thank you!

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kprobes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 43460104f119..60a702a05684 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1705,6 +1705,12 @@ void unregister_kprobes(struct kprobe **kps, int num)
>  }
>  EXPORT_SYMBOL_GPL(unregister_kprobes);
>  
> +int __weak __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> +					      unsigned long val, void *data)
> +{
> +	return NOTIFY_DONE;
> +}
> +
>  static struct notifier_block kprobe_exceptions_nb = {
>  	.notifier_call = kprobe_exceptions_notify,
>  	.priority = 0x7fffffff /* we need to be notified first */
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
