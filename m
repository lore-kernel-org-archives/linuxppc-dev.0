Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D102FDDF5C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 19:06:35 +1100 (EST)
Date: Fri, 07 Mar 2008 17:06:19 +0900 (JST)
Message-Id: <20080307.170619.-1300529804.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: Re: [PATCH] PPC: in celleb_show_cpuinfo() convert strncpy(x, y,
	sizeof(x)) to strlcpy
In-Reply-To: <47CFEF82.10709@tiscali.nl>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, 12o3l@tiscali.nl, linux-kernel@vger.kernel.org,
	arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roel Kluin <12o3l@tiscali.nl> wrote:
> Roel Kluin wrote:
> > This patch was not yet tested. Please confirm it's right.
> 
> was too quick with the send button. the batch below is probably better
> ---
> strncpy does not append '\0' if the length of the source string equals
> the size parameter, strlcpy does.
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Acked-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

I tested Roel's 2nd patch and it works good on Celleb.

> ---
> diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
> index f27ae1e..cbe09d9 100644
> --- a/arch/powerpc/platforms/celleb/setup.c
> +++ b/arch/powerpc/platforms/celleb/setup.c
> @@ -81,8 +81,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
>  
>  static int __init celleb_machine_type_hack(char *ptr)
>  {
> -	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
> -	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
> +	strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
>  	return 0;
>  }
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
