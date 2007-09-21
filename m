Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18163.8093.667452.739363@cargo.ozlabs.ibm.com>
Date: Fri, 21 Sep 2007 11:34:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: add setup_cpu for 44x for processor-specific init
In-Reply-To: <20070920175558.GA3191@ru.mvista.com>
References: <200709201732.l8KHWuGA035995@sullivan.realtime.net>
	<20070920175558.GA3191@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak writes:

> +_GLOBAL(__setup_cpu_440epx)
> +	mflr	r4
> +	bl	__init_fpu_44x
> +_GLOBAL(__setup_cpu_440grx)
> +	bl	__plb_disable_wrp
> +	mtlr	r4
> +	blr

If we enter at __setup_cpu_440grx we'll return to some bogus
address...

Paul.
