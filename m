Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18392.24345.831902.400398@cargo.ozlabs.ibm.com>
Date: Thu, 13 Mar 2008 09:54:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] Always define pmu_sys_suspended
In-Reply-To: <20080227141452.GA10345@bogon.ms20.nix>
References: <20080227141452.GA10345@bogon.ms20.nix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guido G=FCnther writes:

> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.=
c
> index ebec663..296edcb 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -2437,8 +2437,8 @@ void pmu=5Fblink(int n)
>  }
>  #endif /* DEBUG=5FSLEEP */
> =20
> -#if defined(CONFIG=5FSUSPEND) && defined(CONFIG=5FPPC32)
>  int pmu=5Fsys=5Fsuspended;
> +#if defined(CONFIG=5FSUSPEND) && defined(CONFIG=5FPPC32)

I don't think this is quite right, since pmu.h currently defines
pmu=5Fsys=5Fsuspended to be 0 if CONFIG=5FPM=5FSLEEP is not defined.  T=
hus
with your patch we will get a syntax error in that case.

Paul.
