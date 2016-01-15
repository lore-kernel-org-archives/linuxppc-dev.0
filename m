Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F74F1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 16:42:23 +1100 (AEDT)
Message-ID: <1452836542.25634.33.camel@neuling.org>
Subject: Re: [PATCH V2 4/8] powerpc: Explicitly disable math features when
 copying thread
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
Date: Fri, 15 Jan 2016 16:42:22 +1100
In-Reply-To: <1452834254-22078-5-git-send-email-cyrilbur@gmail.com>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-5-git-send-email-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-01-15 at 16:04 +1100, Cyril Bur wrote:
> With threads leaving the math bits enabled in their saved MSR to indicate
> that the hardware is hot and a restore is not needed, children need to tu=
rn
> it off as when they do get scheduled, there's no way their registers coul=
d
> have been hot.

Is this a bug in the current code?

Mikey

> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index dccc87e..e0c3d2d 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1307,6 +1307,7 @@ int copy_thread(unsigned long clone_flags,
> unsigned long usp,
> =20
>  		f =3D ret_from_fork;
>  	}
> +	childregs->msr &=3D ~(MSR_FP|MSR_VEC|MSR_VSX);
>  	sp -=3D STACK_FRAME_OVERHEAD;
> =20
>  	/*
