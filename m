Return-Path: <paulus@ozlabs.org>
Date: Tue, 23 Mar 2010 16:33:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100323053301.GA28676@drongo>
References: <20100308181232.GA3406@in.ibm.com>
	<20100308181448.GA5538@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100308181448.GA5538@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 08, 2010 at 11:44:48PM +0530, K.Prasad wrote:

> @@ -479,6 +483,7 @@ struct task_struct *__switch_to(struct t
>  		old_thread->accum_tb += (current_tb - start_tb);
>  		new_thread->start_tb = current_tb;
>  	}
> +	flush_ptrace_hw_breakpoint(current);
>  #endif
>  
>  	local_irq_save(flags);

This line should be in flush_thread(), not __switch_to().  In fact it
may not be necessary at all given that flush_ptrace_hw_breakpoint()
gets called in do_exit().

Paul.
