Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03782DE1D8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 09:10:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18965.57196.651940.177235@cargo.ozlabs.ibm.com>
Date: Fri, 22 May 2009 09:10:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] powerpc:beyond ARRAY_SIZE of args.args
In-Reply-To: <4A15AF33.60100@gmail.com>
References: <4A15AF33.60100@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roel Kluin writes:

> Do not go beyond ARRAY_SIZE of args.args
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> I'm quite sure the first is correct, but should maybe `args.nret'
> and `nargs + args.nret' also be `>= ARRAY_SIZE(args.args)'?

I don't think this change is needed, and it changes a user-visible
API, so I'm nacking it unless you can convince me there's really a
problem.

If nargs == ARRAY_SIZE(args.args), then args.nret must be zero, so
nothing will access *(args.rets).

Paul.
