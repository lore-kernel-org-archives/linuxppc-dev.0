Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc kvm: fix kvmppc_start_thread() for CONFIG_SMP=N
In-reply-to: <4EBD46F4.5040503@suse.de>
References: <12283.1320977000@neuling.org> <4EBD46F4.5040503@suse.de>
Date: Sat, 12 Nov 2011 15:07:16 +1100
Message-ID: <2383.1321070836@neuling.org>
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

In message <4EBD46F4.5040503@suse.de> you wrote:
> On 11/11/2011 03:03 AM, Michael Neuling wrote:
> > Currently kvmppc_start_thread() tries to wake other SMT threads via
> > xics_wake_cpu().  Unfortunately xics_wake_cpu only exists when
> > CONFIG_SMP=Y so when compiling with CONFIG_SMP=N we get:
> >
> >    arch/powerpc/kvm/built-in.o: In function `.kvmppc_start_thread':
> >    book3s_hv.c:(.text+0xa1e0): undefined reference to `.xics_wake_cpu'
> >
> > The following should be fine since kvmppc_start_thread() shouldn't
> > called to start non-zero threads when SMP=N since threads_per_core=1.
> >
> > Signed-off-by: Michael Neuling<mikey@neuling.org>
> 
> Thanks, applied to kvm-ppc-next. Please CC kvm-ppc@vger next time :).

Thanks will do.

Mikey
