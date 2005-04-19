Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2350167AC6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2005 00:50:08 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0504120101210.10781@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0504120101210.10781@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <700d35a3fce7b67412f955baf473b426@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 19 Apr 2005 09:50:05 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc32: Fix alignment exception checking on load/store
	multiple instructions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

What is the state of ack'ing this patch?

- kumar

On Apr 12, 2005, at 1:03 AM, Kumar Gala wrote:

> Paulus,
>
> Can you take a look and ack this patch before I send to akpm.
>
> The handling of misaligned load/store multiplies did not check to see=20=

> if
> the address were ok to access before __{get,put}_user().
>
>
>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> ---
>  diff -Nru a/arch/ppc/kernel/align.c b/arch/ppc/kernel/align.c
> --- a/arch/ppc/kernel/align.c=A0=A0 2005-04-12 01:00:10 -05:00
>  +++ b/arch/ppc/kernel/align.c=A0=A0 2005-04-12 01:00:10 -05:00
>  @@ -290,6 +290,10 @@
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 /* =
lwm, stmw */
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 nb =
=3D (32 - reg) * 4;
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 }
>  +
>  +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (!access_ok((flags & ST? =
VERIFY_WRITE:=20
> VERIFY_READ), addr, nb+nb0))
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 return =
-EFAULT; /* bad address */
> +
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 rptr =3D (unsigned char =
*) &regs->gpr[reg];
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if (flags & LD) {
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 for =
(i =3D 0; i < nb; ++i)
>  _______________________________________________
> Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
