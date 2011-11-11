Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 965D31007D4
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2011 03:01:43 +1100 (EST)
Message-ID: <4EBD46F4.5040503@suse.de>
Date: Fri, 11 Nov 2011 17:01:56 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc kvm: fix kvmppc_start_thread() for CONFIG_SMP=N
References: <12283.1320977000@neuling.org>
In-Reply-To: <12283.1320977000@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/11/2011 03:03 AM, Michael Neuling wrote:
> Currently kvmppc_start_thread() tries to wake other SMT threads via
> xics_wake_cpu().  Unfortunately xics_wake_cpu only exists when
> CONFIG_SMP=Y so when compiling with CONFIG_SMP=N we get:
>
>    arch/powerpc/kvm/built-in.o: In function `.kvmppc_start_thread':
>    book3s_hv.c:(.text+0xa1e0): undefined reference to `.xics_wake_cpu'
>
> The following should be fine since kvmppc_start_thread() shouldn't
> called to start non-zero threads when SMP=N since threads_per_core=1.
>
> Signed-off-by: Michael Neuling<mikey@neuling.org>

Thanks, applied to kvm-ppc-next. Please CC kvm-ppc@vger next time :).


Alex
