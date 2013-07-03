Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8ABD92C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 07:53:20 +1000 (EST)
Date: Wed, 3 Jul 2013 16:52:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Add LRAT error exception handler
To: Alexander Graf <agraf@suse.de>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
 <1372870566-11299-2-git-send-email-mihai.caraman@freescale.com>
 <1372882590.8183.149@snotra> <6D66E322-D680-4F47-9841-E0A299F45EC1@suse.de>
In-Reply-To: <6D66E322-D680-4F47-9841-E0A299F45EC1@suse.de> (from
 agraf@suse.de on Wed Jul  3 16:42:40 2013)
Message-ID: <1372888373.8183.152@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 04:42:40 PM, Alexander Graf wrote:
>=20
> On 03.07.2013, at 22:16, Scott Wood wrote:
>=20
> > On 07/03/2013 11:56:06 AM, Mihai Caraman wrote:
> >> With LRAT (Logical to Real Address Translation) error exception =20
> handler in kernel
> >> KVM needs to add the counterpart otherwise will break the build.
> >> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> >> ---
> >> arch/powerpc/kvm/bookehv_interrupts.S |    2 ++
> >> 1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > Please combine these two patches to avoid breaking bisectability.
>=20
> Why does the split break bisectability?

Same reason as the altivec build breakage from earlier.  If we add a =20
new exception type but not a KVM handler for it, the kernel won't link.

-Scott=
