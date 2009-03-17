Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 214A9DDF94
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 14:54:18 +1100 (EST)
Received: by gxk22 with SMTP id 22so8611093gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 20:54:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1237197925-71727-1-git-send-email-kosmo@semihalf.com>
References: <20090311222615.63410@gmx.net>
	<1237197925-71727-1-git-send-email-kosmo@semihalf.com>
Date: Mon, 16 Mar 2009 21:54:16 -0600
Message-ID: <fa686aa40903162054v2d28fc2er53aa4f71837110a2@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Enable CPU_FTR_NEED_COHERENT for MPC52xx
From: Grant Likely <grant.likely@secretlab.ca>
To: Piotr Ziecik <kosmo@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LinuxPPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 16, 2009 at 4:05 AM, Piotr Ziecik <kosmo@semihalf.com> wrote:
> BestComm, a DMA engine in MPC52xx SoC, requires snooping when
> CPU caches are enabled to work properly.
>
> Adding CPU_FTR_NEED_COHERENT fixes NFS problems on MPC52xx machines
> introduced by 'powerpc/mm: Fix handling of _PAGE_COHERENT in BAT setup co=
de'.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> ---
>
> This patch was succesfully tested on our MPC5200-based.
> Ben, Gerhard could you ack this patch, as it implements your suggestion.
>
> =A0arch/powerpc/include/asm/cputable.h | =A0 =A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/a=
sm/cputable.h
> index b18358f..22dc2d8 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -241,9 +241,11 @@ extern const char *powerpc_base_platform;
> =A0/* We need to mark all pages as being coherent if we're SMP or we have=
 a
> =A0* 74[45]x and an MPC107 host bridge. Also 83xx and PowerQUICC II
> =A0* require it for PCI "streaming/prefetch" to work properly.
> + * This is also required by 52xx family.
> =A0*/
> =A0#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
> - =A0 =A0 =A0 || defined(CONFIG_PPC_83xx) || defined(CONFIG_8260)
> + =A0 =A0 =A0 || defined(CONFIG_PPC_83xx) || defined(CONFIG_8260) \
> + =A0 =A0 =A0 || defined(CONFIG_PPC_MPC52xx)
>  #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
>  #else
>  #define CPU_FTR_COMMON                  0

Aside from the fact that MPC10X_BRIDGE, PPC83xx and 8260 are already
doing it, adding the feature bit this way isn't multiplatform
friendly.  Essentially it means that all selected platforms will have
CPU_FTR_NEED_COHERENT enabled if CONFIG_PPC_MPC52xx is enabled.

Adding a new section to cputable.c for PVR=3D0x8082201x and applying the
bit there would contain the impact to only G2 cores, but it's not
perfect.  Some of the 82xx parts have the same PVR and so would also
be impacted.

Maybe I'm fretting over nothing.  Ben, what's the right thing to do here?

Otherwise, I've pulled this into my tree and while I'm not affected by
the bug, I don't see any new problems with the patch either.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
