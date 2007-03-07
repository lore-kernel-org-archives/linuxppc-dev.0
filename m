Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 13E93DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 03:26:02 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so212974nfc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Mar 2007 08:25:58 -0800 (PST)
Message-ID: <528646bc0703070825y299e0c78ne8d0a91e1cc6c02d@mail.gmail.com>
Date: Wed, 7 Mar 2007 09:25:58 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [RFC PATCH] icecube/lite5200b: fix OF_TBCLK (timebase-frequency)
	calculation
In-Reply-To: <20070307070258.GA4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070307070258.GA4397@moe.telargo.com>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/7/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> I tracked jiffies (on Linux) incrementing twice as fast on
> lite5200b to this ("timebase-frequency" property).
>
> G2 core reference manual says decrementer and time base
> are decreasing/increasing once every 4 bus clock cycles.
>
> Was there a reason this was busfreq/8?

Simply sloppyness on my part.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

>
>
>         Domen
> ---
>  include/configs/IceCube.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: u-boot.git/include/configs/IceCube.h
> ===================================================================
> --- u-boot.git.orig/include/configs/IceCube.h
> +++ u-boot.git/include/configs/IceCube.h
> @@ -182,7 +182,7 @@
>
>  #define OF_CPU                 "PowerPC,5200@0"
>  #define OF_SOC                 "soc5200@f0000000"
> -#define OF_TBCLK               (bd->bi_busfreq / 8)
> +#define OF_TBCLK               (bd->bi_busfreq / 4)
>  #define OF_STDOUT_PATH         "/soc5200@f0000000/serial@2000"
>
>  /*
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
