Return-Path: <namhyung@kernel.org>
Received: from LGEMRELSE7Q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by ozlabs.org (Postfix) with ESMTP id 19C032C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 21:36:39 +1100 (EST)
From: Namhyung Kim <namhyung@kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 07/45] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073446.13822.39253.stgit@srivatsabhat.in.ibm.com>
Date: Tue, 29 Jan 2013 19:21:19 +0900
In-Reply-To: <20130122073446.13822.39253.stgit@srivatsabhat.in.ibm.com>
 (Srivatsa S. Bhat's message of "Tue, 22 Jan 2013 13:04:54 +0530")
Message-ID: <87mwvsuw68.fsf@sejong.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Srivatsa,

On Tue, 22 Jan 2013 13:04:54 +0530, Srivatsa S. Bhat wrote:
> @@ -246,15 +291,21 @@ struct take_cpu_down_param {
>  static int __ref take_cpu_down(void *_param)
>  {
>  	struct take_cpu_down_param *param = _param;
> -	int err;
> +	unsigned long flags;
> +	int err = 0;

It seems no need to set 'err' to 0.

Thanks,
Namhyung

> +
> +	percpu_write_lock_irqsave(&hotplug_pcpu_rwlock, &flags);
>  
>  	/* Ensure this CPU doesn't handle any more interrupts. */
>  	err = __cpu_disable();
>  	if (err < 0)
> -		return err;
> +		goto out;
>  
>  	cpu_notify(CPU_DYING | param->mod, param->hcpu);
> -	return 0;
> +
> +out:
> +	percpu_write_unlock_irqrestore(&hotplug_pcpu_rwlock, &flags);
> +	return err;
>  }
>  
>  /* Requires cpu_add_remove_lock to be held */
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
