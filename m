Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17534.32164.268580.217501@cargo.ozlabs.ibm.com>
Date: Thu, 1 Jun 2006 15:39:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] use msleep() for RTAS delays
In-Reply-To: <1149139866.28307.32.camel@localhost.localdomain>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
Cc: External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> We could either do something like
> 
> for (;;) {
> 	rc = rtas_call(...);
> 	if (!rtas_check_busy(rc))
> 		break;

rtas_check_busy might need some state, such as the number of times we
have seen an RTAS_BUSY return value.

> Or something inside rtas_call
> 
> rtas_call_waitbusy(...);

That's a good idea...

Paul.
