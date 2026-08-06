Return-Path: <linuxppc-dev+bounces-25514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A256C56205
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 18:37:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGGGS1RB9z2yd7;
	Fri, 07 Aug 2026 04:37:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786041424;
	cv=none; b=W0j9vaog8Rs7EJDfESDdWODAwQk7bEUWtgiwlmOEgboQgit2NP+XI5PQPsFt6jzHMxU+sVwOkfq4QGPzLnrCr7LqJz009Ayti/ETcmGhIEqPmz1UIbugaeUzqr1VAoOsxuRumxpJAMBHa7PdmFyblORB3bjFhAlPLPyeCGl3wrqQrSHIaipSxm81vG1ym57Ow1Kb1nzMfqWDBVxrCY842oN/0hBfoBqyf17a6NFJMNBH1WgrYIRnSEGoJQzqJfKfzkAyVEV22HnOnEAjNQ27JQ7zZoO3Ax9nFOEdMHzRf6/kkQkVAhZ2b5VD/jqRrP+uR+PWMqUbr9CnB9BbKilxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786041424; c=relaxed/relaxed;
	bh=sL881gPdJx6xM4Jsh+VbyFliie3hWpb8MUCaNrE+uYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNgd1853yHa7pG0eLLdKKEqusxMv1zPywoNVDd1if277G6EYy4cwuglaMGafVhCRuRLHdwP8T3nCvybpvMVjbd8pbrfg+cJgp9QaxfxHbWVIzc+wbsFK0Vv+Ts+tNDdJLcV8O91L3mc0EUaxeJrxYE8P6g9kpfx0HLmyykMXR4ExhfoLnaFjdtkRrDkSOANy5AC8QNERBvlPNv8K92LkiSQCoC9tyyQt8me9XvqlVPH044avDsQ0MG327ShlTb0QT0OnB7audqczc66Y0zER/1U85scYnHa9/1BGAOUrh7Sh24e77XJ1o1mASZJFAv0KbF+phXtVt/8DaLho98MMag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfsPO31k; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfsPO31k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGGGR0vqZz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 04:37:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1105A601D9;
	Thu,  6 Aug 2026 18:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385651F000E9;
	Thu,  6 Aug 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041419;
	bh=sL881gPdJx6xM4Jsh+VbyFliie3hWpb8MUCaNrE+uYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfsPO31k61DsJweKdPhhxMqlaEXRqE+kAYR+6gUovaMBF4e6JNXzuIIG/EztW/9CO
	 gqar1hRM4MwYl6vSArul19Llspq8KZsstFtaWw8ojOuX9/Bs4anLVUj1IyxLYoT0Wz
	 fbAzmzhPRnK84ZA2+pfi1ithX9fUQ5tMOOmQuFQQLZYt7aZ/MFqaxDL7A+jCUaA6pZ
	 bpPSVqwuVfbPEWcgTeZuwIg+vc1vhVtIhfsgJz7IkvJsm8z8jX8vDVmcIZn/5pq1Qw
	 +bdsJdaaLxDTNaQmuiMGaZerdBKnEv/dY7sJpFVszEZ35eEEk5b66aCgK1RnJctcf8
	 izsEm0RsruwXg==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	simon.horman@corigine.com,
	shaik.abdulla1@ibm.com,
	davemarq@linux.ibm.com
Subject: Re: [PATCH net-next v4 01/14] ibmveth: Add MQ RX hypercall wrappers and call definitions
Date: Thu,  6 Aug 2026 11:36:14 -0700
Message-ID: <20260806183614.3171785-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <1bb2ecd260f27171c534b9beda377b75ea1790ae.1785457143.git.mmc@linux.ibm.com>
References: <1bb2ecd260f27171c534b9beda377b75ea1790ae.1785457143.git.mmc@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Add MQ RX hypercall wrappers and call definitions

This adds three new PHYP call IDs for multi-queue receive support and four
static inline hcall wrapper helpers in ibmveth.h, bumping MAX_HCALL_OPCODE
to the highest new opcode. No callers are added by this patch.

A couple of questions below about the new wrappers and about the hvcall.h
hunk.

> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> index dff90a7d7f70b..d79baf2e38273 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -362,7 +362,10 @@
>  #define H_GUEST_DELETE		0x488
>  #define H_PKS_WRAP_OBJECT	0x490
>  #define H_PKS_UNWRAP_OBJECT	0x494
> -#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
> +#define H_REG_LOGICAL_LAN_QUEUE 0x49C
> +#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
> +#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
> +#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE

[Severity: Low]
Could the changelog cite the PAPR/PHYP document and revision that assigns
0x49C, 0x4A0 and 0x4A8?  These become architecture-wide constants shared
with the KVM hcall emulation, so it would help to have the provenance
recorded in the commit.

There are also holes left at 0x498 and at 0x4A4 (the latter from dropping
H_FREE_LOGICAL_LAN_BUFFER_QUEUE in v4).  Are those numbers reserved by the
architecture for something else, or are they simply unused?

Separately, MAX_HCALL_OPCODE is not driver-local.  It sizes
kvm_arch.enabled_hcalls:

  arch/powerpc/include/asm/kvm_host.h:
      DECLARE_BITMAP(enabled_hcalls, MAX_HCALL_OPCODE/4 + 1);

and it bounds the userspace-visible opcode range accepted by
KVM_CAP_PPC_ENABLE_HCALL:

  arch/powerpc/kvm/powerpc.c:kvm_vm_ioctl_enable_cap() {
      ...
      if (hcall > MAX_HCALL_OPCODE || (hcall & 3) ||
          cap->args[1] > 1)
      ...
  }

It also sizes the per-CPU hcall statistics array in
arch/powerpc/platforms/pseries/hvCall_inst.c and gates
kvmppc_pseries_do_hcall() and kvmppc_h_pr().  As far as I can tell the bump
is behaviourally inert for these new opcodes, since kvm_vm_ioctl_enable_cap()
still rejects them via kvmppc_book3s_hcall_implemented(), and the KVM
dispatch path ends up returning RESUME_HOST either way.  Would it be worth
mentioning the cross-subsystem effect in the changelog so the powerpc/KVM
side has something to ack against?

>  
>  /* Scope args for H_SCM_UNBIND_ALL */
>  #define H_UNBIND_SCOPE_ALL (0x1)
> diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
> index d87713668ed30..c88dbeb7cd967 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -66,6 +66,143 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
>  			    desc5, desc6, desc7, desc8);
>  }
>  
> +/**
> + * h_reg_logical_lan_queue - Register a subordinate receive queue

[Severity: Low]
This isn't a bug, but the naming here diverges from the existing wrappers in
this file, which all spell it out as h_register_logical_lan() and
h_free_logical_lan().  Would h_register_logical_lan_queue() read more
consistently?

[ ... ]

> +static inline long h_reg_logical_lan_queue(unsigned long unit_address,
> +					   unsigned long buffer_list,
> +					   unsigned long rec_queue,
> +					   unsigned long *queue_handle,
> +					   unsigned long *irq)
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
This helper returns the queue handle as unsigned long *, which matches
retbuf's element type and matches the other output parameters in this header
(h_send_logical_lan()'s corellator_out, h_illan_attributes()'s
ret_attributes).

But h_register_logical_lan_with_handle() below declares the same conceptual
value, the PHYP queue handle read out of retbuf[0], as u64 *.  Can these two
be made to agree?  As it stands, callers have to pick a different storage
type depending on which of the two helpers they call, even though both are
returning the same thing.

The commit message says the new wrappers have "argument ordering and return
semantics matching the existing ibmveth hcall wrappers", which holds for
this one but not for the u64 * variant.

[ ... ]

> +static inline long h_free_logical_lan_queue(unsigned long unit_address,
> +					    unsigned long queue_handle)
> +{
> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> +
> +	return plpar_hcall9(H_FREE_LOGICAL_LAN_QUEUE,
> +			    retbuf, unit_address, queue_handle);
> +}

[Severity: Low]
The kerneldoc above documents no output data for this hcall, and retbuf is
never read.  Why not use plpar_hcall_norets() here, the way the existing
counterpart in this file does?

  #define h_free_logical_lan(ua) \
    plpar_hcall_norets(H_FREE_LOGICAL_LAN, ua)

That would drop the dead nine-entry stack buffer.

[ ... ]

> +static inline long
> +h_register_logical_lan_with_handle(unsigned long unit_address,
> +				   unsigned long buffer_list,
> +				   unsigned long rec_queue,
> +				   unsigned long filter_list,
> +				   unsigned long mac_address,
> +				   u64 *queue_handle)
                                    ^^^^^^^^^^^^^^^^^^

[Severity: Low]
This is the u64 * side of the inconsistency noted above.  Both types are
64-bit on ppc64, which is the only configuration that builds ibmveth, and
the callers added later in the series do compile against both prototypes, so
this looks like a readability issue rather than a functional one.  Could both
helpers use unsigned long * for the handle?

> +{
> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
> +	long rc;
> +
> +	rc = plpar_hcall9(H_REGISTER_LOGICAL_LAN, retbuf,
> +			  unit_address, buffer_list, rec_queue,
> +			  filter_list, mac_address);
> +
> +	if (rc == H_SUCCESS && queue_handle)
> +		*queue_handle = retbuf[0];
> +
> +	return rc;
> +}

Thanks.
-- 
pw-bot: cr

