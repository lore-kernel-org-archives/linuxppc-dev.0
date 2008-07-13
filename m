Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18554.33417.542066.185326@cargo.ozlabs.ibm.com>
Date: Mon, 14 Jul 2008 08:32:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Srinivasa D S <srinivasa@in.ibm.com>
Subject: Re: [RFC] [PATCH] task_pt_regs for powerpc systems
In-Reply-To: <200807071952.27427.srinivasa@in.ibm.com>
References: <200807071952.27427.srinivasa@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Srinivasa D S writes:

>  task_pt_regs() macro defines pt_regs for the given task,  this macro is  
> currently not defined for powerpc arch. We need this macro for 
> upcoming utrace features. 
>  Below attached patch  defines this macro for powerpc arch. Please let 
> me know your comments on this.

> +#define task_pt_regs(tsk)	((struct pt_regs *)(tsk)->thread.regs)

The cast is unnecessary since tsk->thread.regs is already a struct
pt_regs *.  Also note that tsk->thread.regs will be NULL for a kernel
thread.

Paul.
