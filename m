Return-Path: <SRS0=2n06=HI=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Rqpf4jLSzF22b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 06:10:02 +1000 (AEST)
Date: Thu, 19 Apr 2018 11:22:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, Satheesh Rajendran
 <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 06/10] powerpc64/ftrace: Disable ftrace during kvm
 entry/exit
Message-ID: <20180419112216.173f8fd6@gandalf.local.home>
In-Reply-To: <62b77045b205b008946b793fe31effb155b335be.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
 <62b77045b205b008946b793fe31effb155b335be.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 19 Apr 2018 12:34:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> 2. If we are a secondary thread in Power8, then we would be in nap due
> to SMT being disabled. We are woken up by an IPI to enter the guest. In
> this scenario, we enter the guest through kvm_start_guest(). We disable
> ftrace at this point. In this scenario, ftrace would only get re-enabled
> on the secondary thread when SMT is re-enabled (via start_secondary()).
> 
	trace_hardirqs_off();
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index bd63fa8a08b5..2c3cbe0067b2 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -342,6 +342,9 @@ kvm_start_guest:
>  
>  	ld	r2,PACATOC(r13)
>  

You may want to add a comment here about where ftrace gets re-enabled.

-- Steve

> +	li	r0,0
> +	stb	r0,PACA_FTRACE_ENABLED(r13)
> +
>  	li	r0,KVM_HWTHREAD_IN_KVM
>  	stb	r0,HSTATE_HWTHREAD_STATE(r13)
>  
