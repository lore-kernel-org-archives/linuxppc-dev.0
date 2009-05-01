Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id CE4B7DDEDD
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 07:33:57 +1000 (EST)
Date: Fri, 1 May 2009 17:33:54 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v6] introduce macro spin_event_timeout()
Message-ID: <20090501173354.64e78def@lappy.seanm.ca>
In-Reply-To: <1240859144-20893-1-git-send-email-timur@freescale.com>
References: <1240859144-20893-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 27 Apr 2009 14:05:44 -0500
"Timur Tabi" <timur@freescale.com> wrote:

> +#define spin_event_timeout(condition, timeout, delay,
> rc)                   \
> +{                                                                           \
> +	unsigned long __loops = tb_ticks_per_usec *
> timeout;                \
> +	unsigned long __start =
> get_tbl();                                  \
> +	while (!(rc = (condition)) && (tb_ticks_since(__start) <=
> __loops)) \
> +		udelay(delay);
> 	    \ +}
> +

Would cpu_relax be a good thing to put here?

Something like:

while (!(rc = (condition)) && (tb_ticks_since(__start) <= __loops)) \
	if (delay) \
		udelay(delay); \
	else \
		cpu_relax(); \

Cheers,
   Sean
