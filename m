Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17834.47158.581922.62728@cargo.ozlabs.ibm.com>
Date: Mon, 15 Jan 2007 10:09:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH] atomic_dec_if_positive sign extension fix
In-Reply-To: <20070114225502.GA21471@austin.ibm.com>
References: <20070114225502.GA21471@austin.ibm.com>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> Please apply for 2.6.20.  If an atomic counter is explicitly set to a
> negative value the atomic_dec_if_positive function will decrement and
> store the next smallest value in the atomic counter contrary to it's
> intended operation.  

[snip]

>  	__asm__ __volatile__(
>  	LWSYNC_ON_SMP
>  "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
> +	extsw	%0,%0\n\
>  	addic.	%0,%0,-1\n\
>  	blt-	2f\n"
>  	PPC405_ERR77(0,%1)

NAK: Good fix for 64-bit, but it will break 32-bit.  I think a better
fix would be to use a cmpwi after the lwarx, and use addi rather than
addic..

Paul.
