Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E56B2C030A
 for <linuxppc-dev@ozlabs.org>; Wed, 29 May 2013 03:41:55 +1000 (EST)
Date: Tue, 28 May 2013 12:41:42 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add support for H_IPOLL and H_XIRR_X
 in XICS emulation
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20130524014221.GA19310@iris.ozlabs.ibm.com> (from
 paulus@samba.org on Thu May 23 20:42:21 2013)
Message-ID: <1369762902.18630.2@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/23/2013 08:42:21 PM, Paul Mackerras wrote:
> This adds the remaining two hypercalls defined by PAPR for =20
> manipulating
> the XICS interrupt controller, H_IPOLL and H_XIRR_X.  H_IPOLL returns
> information about the priority and pending interrupts for a virtual
> cpu, without changing any state.  H_XIRR_X is like H_XIRR in that it
> reads and acknowledges the highest-priority pending interrupt, but it
> also returns the timestamp (timebase register value) from when the
> interrupt was first received by the hypervisor.  Currently we just
> return the current time, since we don't do any software queueing of
> virtual interrupts inside the XICS emulation code.
>=20
> These hcalls are not currently used by Linux guests, but may be in
> future.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> Unfortunately I missed these two hcalls in the previous submissions.
> It would be good to get this patch into 3.10 so we don't have a
> kernel version with these calls missing from the API, in case future
> guest kernels want to use them.
>=20
> Alex, given you're on vacation at the moment, are you OK with Ben
> taking this through his tree?

I believe Alex is staying far away from e-mail on his vacation.  He's =20
asked me to fill in for him while he's gone.

The patch itself seems reasonable (though I don't know much about XICS, =20
and do have one question...), but I'll leave it up to Gleb/Marcelo/Ben =20
if it should go in for 3.10 and via which tree.  I understand the =20
desire to not have an incomplete ABI in a released version, but Linus =20
is already grumbling about how much went into rc3, and you say the =20
hcalls aren't currently used...  Are they likely to be used in any =20
timeframe in which we'd reasonably care about 3.10?  If so, would the =20
effect of not having them implemented be such that it would be worse =20
than not having in-kernel XICS at all?

> @@ -787,6 +804,18 @@ int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 =20
> req)
>  	if (!xics || !vcpu->arch.icp)
>  		return H_HARDWARE;
>=20
> +	/* These requests don't have real-mode implementations at =20
> present */
> +	switch (req) {
> +	case H_XIRR_X:
> +		res =3D kvmppc_h_xirr(vcpu);
> +		kvmppc_set_gpr(vcpu, 4, res);
> +		kvmppc_set_gpr(vcpu, 5, get_tb());
> +		return rc;
> +	case H_IPOLL:
> +		rc =3D kvmppc_h_ipoll(vcpu, kvmppc_get_gpr(vcpu, 4));
> +		return rc;
> +	}
> +
>  	/* Check for real mode returning too hard */
>  	if (xics->real_mode)
>  		return kvmppc_xics_rm_complete(vcpu, req);

Could you explain what's going on here relative to =20
kvmppc_xics_rm_complete()?  What does "returning too hard" mean, and =20
why must rm_action not be checked for these hcalls?

-Scott=
