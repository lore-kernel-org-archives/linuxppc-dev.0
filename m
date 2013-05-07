Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC67B2C0171
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 09:40:56 +1000 (EST)
Date: Tue, 7 May 2013 18:40:43 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
To: Tiejun Chen <tiejun.chen@windriver.com>
In-Reply-To: <1367924791-24394-1-git-send-email-tiejun.chen@windriver.com>
 (from tiejun.chen@windriver.com on Tue May  7 06:06:30 2013)
Message-ID: <1367970043.3398.39@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2013 06:06:30 AM, Tiejun Chen wrote:
> We also can direct ISI exception to Guest like DSI.
>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kvm/booke_emulate.c |    3 +++
>  arch/powerpc/kvm/e500mc.c        |    3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Are you seeing a real performance improvement from this?  This will =20
interfere somewhat with using the VF bit, if we were to ever do so, =20
since VF only affects data accesses (and so the guest would see an ISI =20
storm rather than a machine check if it tries to execute from such an =20
address).

-Scott=
