Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x234.google.com (mail-yk0-x234.google.com
 [IPv6:2607:f8b0:4002:c07::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B311A033E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 19:26:20 +1100 (AEDT)
Received: by ykfs79 with SMTP id s79so48718389ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 00:26:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448406993-7888-1-git-send-email-rashmicy@gmail.com>
References: <1448406993-7888-1-git-send-email-rashmicy@gmail.com>
Date: Wed, 25 Nov 2015 11:26:18 +0300
Message-ID: <CAOJe8K2szgooZQEhY4wsQ5Zu=PZOfaGgHzaQO2EzWyqK8kkM4w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix xmon ml command to work with 64 bit values.
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Rashmica Gupta <rashmicy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, jwboyer@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/15, Rashmica Gupta <rashmicy@gmail.com> wrote:
> The ml command in xmon currently only works for 32-bit values and so fails
> to find 64-bit values on a ppc64 machine. So change to work for 64-bit
> values.
>
> This is based off a patch by Josh Boyer.
>
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---

Please remove(update?) Josh Boyer from CC, the address bounces back.
>
> Based off this patch: http://patchwork.ozlabs.org/patch/90309/
>
>  arch/powerpc/xmon/xmon.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 786bf01691c9..df05bd2fca07 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -184,6 +184,12 @@ extern void xmon_leave(void);
>  #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) +
> (v)[3])
>  #endif
>
> +#if BITS_PER_LONG == 64
> +#define GETLONG(v)	(((unsigned long) GETWORD(v)) << 32 | GETWORD(v+4))
> +#else
> +#define GETLONG(v)	GETWORD(v)
> +#endif
> +
>  static char *help_string = "\
>  Commands:\n\
>    b	show breakpoints\n\
> @@ -2447,14 +2453,15 @@ memdiffs(unsigned char *p1, unsigned char *p2,
> unsigned nb, unsigned maxpr)
>  		printf("Total of %d differences\n", prt);
>  }
>
> -static unsigned mend;
> -static unsigned mask;
> +static unsigned long mend;
> +static unsigned long mask;
>
>  static void
>  memlocate(void)
>  {
> -	unsigned a, n;
> -	unsigned char val[4];
> +	unsigned long a, n;
> +	int size = sizeof(unsigned long);
> +	unsigned char val[size];
>
>  	last_cmd = "ml";
>  	scanhex((void *)&mdest);
> @@ -2470,10 +2477,10 @@ memlocate(void)
>  		}
>  	}
>  	n = 0;
> -	for (a = mdest; a < mend; a += 4) {
> -		if (mread(a, val, 4) == 4
> -			&& ((GETWORD(val) ^ mval) & mask) == 0) {
> -			printf("%.16x:  %.16x\n", a, GETWORD(val));
> +	for (a = mdest; a < mend; a += size) {
> +		if (mread(a, val, size) == size
> +			&& ((GETLONG(val) ^ mval) & mask) == 0){
> +			printf("%.16lx:  %.16lx\n", a, GETLONG(val));
>  			if (++n >= 10)
>  				break;
>  		}
> --
> 2.5.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
