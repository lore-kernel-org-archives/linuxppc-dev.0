Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77B721A009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 12:08:39 +1100 (AEDT)
Message-ID: <1448240918.3061.6.camel@neuling.org>
Subject: Re: [PATCH 4/8] powerpc: Explicitly disable math features when
 copying thread
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, anton@samba.org, linuxppc-dev@ozlabs.org
Date: Mon, 23 Nov 2015 12:08:38 +1100
In-Reply-To: <1447817215-15804-5-git-send-email-cyrilbur@gmail.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-5-git-send-email-cyrilbur@gmail.com>
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

On Wed, 2015-11-18 at 14:26 +1100, Cyril Bur wrote:
> With threads leaving the math bits enabled in their saved MSR to
> indicate
> that the hardware is hot and a restore is not needed, children need
> to turn
> it off as when they do get scheduled, there's no way their registers
> could
> have been hot.
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/kernel/process.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index 398f7bf..441d9e5 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1243,6 +1243,7 @@ int copy_thread(unsigned long clone_flags,
> unsigned long usp,
> =20
>  		f =3D ret_from_fork;
>  	}
> +	childregs->msr &=3D ~(MSR_FP|MSR_VEC|MSR_VSX);

Is this a current bug?=20

Mikey

>  	sp -=3D STACK_FRAME_OVERHEAD;
> =20
>  	/*
