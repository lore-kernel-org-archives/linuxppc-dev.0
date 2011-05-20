Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5597B71A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 05:36:15 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc/book3e-64: hv exceptions aren't MASKABLE
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110520190030.GA7058@schlenkerla.am.freescale.net>
Date: Fri, 20 May 2011 14:36:09 -0500
Message-Id: <029E9D3E-D310-4DB6-9D0C-5E59705B2676@kernel.crashing.org>
References: <20110520190030.GA7058@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 20, 2011, at 2:00 PM, Scott Wood wrote:

> In general we will not have EE soft-disabled or be napping when
> these exceptions happen, but still it is not correct.
>=20
> The guest doorbell exceptions can only be triggered with MSR[GS]=3D1,
> and thus for host kernel nesting purposes are base-level exceptions.
>=20
> Note that ehpriv and hypercall are triggerable from normal userspace.
> I tested that the process gets properly signalled in this case.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/reg_booke.h |    2 +
> arch/powerpc/kernel/exceptions-64e.S |   67 =
++++++++++++++++++++++++++--------
> 2 files changed, 53 insertions(+), 16 deletions(-)

Can you look at a similar patch for 32-bit fsl-booke so we handle HV =
exceptions if they happen to get generated, maybe something already =
exists for KVM.

- k=
