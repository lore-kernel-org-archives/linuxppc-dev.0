Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4BDB767C33
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 08:18:37 +1100 (EST)
Message-ID: <45621828.5000904@am.sony.com>
Date: Mon, 20 Nov 2006 13:03:36 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 3/16] add base support for Celleb platform
References: <200611150931.kAF9VciJ023243@toshiba.co.jp>
In-Reply-To: <200611150931.kAF9VciJ023243@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a few very minor comments.

Ishizaki Kou wrote:
> Index: linux-2.6.19/arch/powerpc/platforms/celleb/beat.c
> +int64_t beat_repository_encode(int vendor_id, const char *str, uint64_t name[4])
> +{ 
> +	union {
> +		unsigned char cbuf[8];
> +		uint64_t a;
> +	} buf[4];
> +
> +	buf[0].cbuf[0] = vendor_id << 4;
> +	buf[0].cbuf[1] = 0;
> +	buf[0].cbuf[2] = 0;
> +	buf[0].cbuf[3] = 0;
> +	if((str = re_det1(str, &buf[0].cbuf[4], 4)) == NULL) {
> +		return -1;
> +	}
> +	if((str = re_det1(str, &buf[1].cbuf[0], 8)) == NULL) {
> +		return -2;
> +	}
> +	if((str = re_det1(str, &buf[2].cbuf[0], 8)) == NULL) {
> +		return -3;
> +	}
> +	if((str = re_det1(str, &buf[3].cbuf[0], 8)) == NULL) {
> +		return -4; 
> +	}
> +	if(*str != 0) {
> +		return -5;
> +	} 
> +	name[0] = buf[0].a;
> +	name[1] = buf[1].a;
> +	name[2] = buf[2].a;
> +	name[3] = buf[3].a;
> +	return 0;
> +} 


I think we can have common lower level repository routines shared between
beat and lv1.


> +#ifdef DEBUG
> +#define DBG(fmt...) udbg_printf(fmt)
> +#else
> +#define DBG(fmt...)
> +#endif

Maybe you should consider using something like this for the non-debug case:

#define DBG(fmt...) do{if(0)printk(fmt);}while(0)

That way a syntax check is always done, and it will keep your DBG() statements
from getting out of sync with the rest of the code.


-Geoff
