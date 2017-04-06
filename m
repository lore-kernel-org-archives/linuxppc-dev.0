Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzBjK1qSNzDqLD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 15:53:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, gleb@kernel.org,
 agraf@suse.de, KVM-PPC <kvm-ppc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 pbonzini@redhat.com
Cc: KVM <kvm@vger.kernel.org>, david@gibson.dropbear.id.au
Subject: Re: [PATCH v7 2/3] powerpc/powernv: Introduce a machine check hook
 for Guest MCEs.
In-Reply-To: <149142524189.28284.14876788789820474952.stgit@jupiter.in.ibm.com>
References: <149142508580.28284.10052904644951828717.stgit@jupiter.in.ibm.com>
 <149142524189.28284.14876788789820474952.stgit@jupiter.in.ibm.com>
Date: Thu, 06 Apr 2017 15:53:53 +1000
Message-ID: <878tneuln2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> This patch introduces a mce hook which is invoked at the time of guest
> exit to facilitate the host-side handling of machine check exception
> before the exception is passed on to the guest. This hook will be invoked
> from host virtual mode from KVM (before exiting the guest with
> KVM_EXIT_NMI reason) for machine check exception that occurs in the guest.

Hi Mahesh,

This patch doesn't meaningfully abstract anything.

opal_machine_check_guest() doesn't call opal, or do anything opal
specific. It just passes the evt struct back to code in mce.c, which is
where the struct came from in the first place.

> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -479,6 +479,32 @@ int opal_machine_check(struct pt_regs *regs)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +/*
> + * opal_machine_check_guest() is a hook which is invoked at the time
> + * of guest exit to facilitate the host-side handling of machine check
> + * exception before the exception is passed on to the guest. This hook
> + * is invoked from host virtual mode from KVM (before exiting the guest
> + * with KVM_EXIT_NMI reason) for machine check exception that occurs in
> + * the guest.
> + *
> + * Currently no action is performed in the host other than printing the
> + * event information. The machine check exception is passed on to the
> + * guest kernel and the guest kernel will attempt for recovery.
> + */
> +int opal_machine_check_guest(struct machine_check_event *evt)
> +{
> +	/* Print things out */
> +	if (evt->version != MCE_V1) {
> +		pr_err("Machine Check Exception, Unknown event version %d !\n",
> +		       evt->version);
> +		return 0;
> +	}
> +	machine_check_print_event_info(evt);
> +	return 0;
> +}
> +#endif

Called from kvmppc_handle_exit_hv():

+		if (ppc_md.machine_check_exception_guest)
+			ppc_md.machine_check_exception_guest(
+							&vcpu->arch.mce_evt);
 		break;

Just call machine_check_print_event_info() directly from
kvmppc_handle_exit_hv().

You'll need to export symbol it, but that's all AFAICS, I don't think it
even needs any #ifdefs.

If we ever want to do anything different we can change the code then.

cheers
