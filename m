Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNbhY0kgGzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 21:52:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>,
 KVM <kvm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>, Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the kvm tree with the powerpc tree
In-Reply-To: <20170215133820.439190c9@canb.auug.org.au>
References: <20170215133820.439190c9@canb.auug.org.au>
Date: Wed, 15 Feb 2017 21:52:08 +1100
Message-ID: <878tp7lo9z.fsf@concordia.ellerman.id.au>
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the kvm tree got a conflict in:
>
>   arch/powerpc/kvm/book3s_hv_rm_xics.c
>
> between commit:
>
>   ab9bad0ead9a ("powerpc/powernv: Remove separate entry for OPAL real mode calls")
>
> from the powerpc tree and commit:
>
>   21acd0e4df04 ("KVM: PPC: Book 3S: XICS: Don't lock twice when checking for resend")
>
> from the kvm tree.

Thanks.

That will go away if/when Paolo merges the rest of Paul's next.

cheers


> diff --cc arch/powerpc/kvm/book3s_hv_rm_xics.c
> index 29f43ed6d5eb,0b2e388f4cdf..000000000000
> --- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
> @@@ -35,8 -35,8 +35,8 @@@ int kvm_irq_bypass = 1
>   EXPORT_SYMBOL(kvm_irq_bypass);
>   
>   static void icp_rm_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
> - 			    u32 new_irq);
> + 			    u32 new_irq, bool check_resend);
>  -static int xics_opal_rm_set_server(unsigned int hw_irq, int server_cpu);
>  +static int xics_opal_set_server(unsigned int hw_irq, int server_cpu);
>   
>   /* -- ICS routines -- */
>   static void ics_rm_check_resend(struct kvmppc_xics *xics,
