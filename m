Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BDE1B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 02:27:04 +1000 (EST)
In-Reply-To: <1277980982-12433-28-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EB2E1C5B-118B-481B-83D6-44CFAA2E55D3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
Date: Fri, 2 Jul 2010 18:27:20 +0200
To: Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +To find out if we're running on KVM or not, we overlay the PVR  
> register. Usually
> +the PVR register contains an id that identifies your CPU type. If,  
> however, you
> +pass KVM_PVR_PARA in the register that you want the PVR result in,  
> the register
> +still contains KVM_PVR_PARA after the mfpvr call.
> +
> +	LOAD_REG_IMM(r5, KVM_PVR_PARA)
> +	mfpvr	r5
> +	[r5 still contains KVM_PVR_PARA]

I love this part :-)

> +	__u64 scratch3;
> +	__u64 critical;		/* Guest may not get interrupts if == r1 */
> +	__u64 sprg0;
> +	__u64 sprg1;
> +	__u64 sprg2;
> +	__u64 sprg3;
> +	__u64 srr0;
> +	__u64 srr1;
> +	__u64 dar;
> +	__u64 msr;
> +	__u32 dsisr;
> +	__u32 int_pending;	/* Tells the guest if we have an interrupt */
> +};
> +
> +Additions to the page must only occur at the end. Struct fields  
> are always 32
> +bit aligned.

The u64s are 64-bit aligned, should they always be?

> +The "ld" and "std" instructions are transormed to "lwz" and "stw"  
> instructions
> +respectively on 32 bit systems with an added offset of 4 to  
> accomodate for big
> +endianness.

Will this add never overflow?  Is there anything that checks for it?

> +mtmsrd	rX, 0		b	<special mtmsr section>
> +mtmsr			b	<special mtmsr section>

mtmsr rX


Segher
