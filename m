Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 73AB4B7084
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 23:33:07 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 075D1DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 23:33:06 +1000 (EST)
Date: Tue, 14 Jul 2009 17:33:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] powerpc/85xx: Don't scan for TBI PHY addresses on
	MPC8569E-MDS boards
Message-ID: <20090714133304.GA28970@oksana.dev.rtsoft.ru>
References: <20090701173925.GA22134@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090701173925.GA22134@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 01, 2009 at 09:39:25PM +0400, Anton Vorontsov wrote:
> Sometimes (e.g. when there are no UEMs attached to a board)
> fsl_pq_mdio_find_free() fails to find a spare address for a TBI PHY,
> this is because get_phy_id() returns bogus 0x0000ffff values
> (0xffffffff is expected), and therefore mdio bus probing fails with
> the following message:
> 
>   fsl-pq_mdio: probe of e0082120.mdio failed with error -16
> 
> And obviously ethernet doesn't work after this.
> 
> This patch solves the problem by adding tbi-phy node into mdio node,
> so that we won't scan for spare addresses, we'll just use a fixed one.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Kumar,

I believe this patch is suitable for 2.6.31, no?

Thanks,

> ---
>  arch/powerpc/boot/dts/mpc8569mds.dts |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/boot/dts/mpc8569mds.dts
> index 2577f37..baa4ac7 100644
> --- a/arch/powerpc/boot/dts/mpc8569mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8569mds.dts
> @@ -502,6 +502,10 @@
>  				reg = <0x6>;
>  				device_type = "ethernet-phy";
>  			};
> +			tbi-phy@11 {
> +				reg = <0x11>;
> +				device_type = "tbi-phy";
> +			};
>  		};
>  		mdio@3520 {
>  			#address-cells = <1>;
> -- 
> 1.6.3.3
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
