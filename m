Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 066D367B93
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 23:32:12 +1000 (EST)
In-Reply-To: <995B09A8299C2C44B59866F6391D26351C2E54@zch01exm21.fsl.freescale.net>
References: <995B09A8299C2C44B59866F6391D26351C2E54@zch01exm21.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4ED20ECF-2EDA-4727-BC00-60AC61099DBC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix the UCC rx tx clock of QE
Date: Wed, 18 Oct 2006 08:32:06 -0500
To: Liu Dave-r63238 <DaveLiu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k

On Oct 18, 2006, at 3:36 AM, Liu Dave-r63238 wrote:

> CLK16 of CMXUCR3 and CMXUCR4 registers are missed in
> ucc_set_qe_mux_rxtx().
> This patch adds the CLK16 to the function. MPC8323EMDS board ethernet
> interface
> with RMII is use the CLK16 as the rx and tx clock.
>
> Signed-off-by: Dave Liu <daveliu@freescale.com>
>
> ---
> diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c
> b/arch/powerpc/sysdev/qe_lib/ucc.c
> index 916c9e5..ac12a44 100644
> --- a/arch/powerpc/sysdev/qe_lib/ucc.c
> +++ b/arch/powerpc/sysdev/qe_lib/ucc.c
> @@ -207,6 +207,7 @@ int ucc_set_qe_mux_rxtx(int ucc_num, enu
>                 case QE_CLK18:  source = 8; break;
>                 case QE_CLK7:   source = 9; break;
>                 case QE_CLK8:   source = 10; break;
> +               case QE_CLK16:  source = 11; break;
>                 default:        source = -1; break;
>                 }
>                 break;
> @@ -222,6 +223,7 @@ int ucc_set_qe_mux_rxtx(int ucc_num, enu
>                 case QE_CLK22:  source = 8; break;
>                 case QE_CLK7:   source = 9; break;
>                 case QE_CLK8:   source = 10; break;
> +               case QE_CLK16:  source = 11; break;
>                 default:        source = -1; break;
>                 }
>                 break;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
