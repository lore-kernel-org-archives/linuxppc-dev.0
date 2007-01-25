Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 61949DDF93
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 00:32:20 +1100 (EST)
Date: Thu, 25 Jan 2007 14:32:13 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 8/14] ps3: bind interrupt to cpu
In-Reply-To: <45B8188A.5070900@am.sony.com>
Message-ID: <Pine.LNX.4.62.0701251430000.31896@pademelon.sonytel.be>
References: <45B8188A.5070900@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Jan 2007, Geoff Levand wrote:
> +struct ps3_bmp {
> +	struct {
> +		unsigned long status;
> +		unsigned long unused_1[3];
> +		unsigned long mask;
> +		unsigned long unused_2[3];
> +	} __attribute__ ((aligned (64)));
> +
> +	spinlock_t lock;
> +	unsigned long ipi_debug_brk_mask;
> +};

I know we support 64-bit kernels only, but as hypervisor calls are always
64-bit, perhaps you want to explicitly use u64 instead of unsigned long?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
