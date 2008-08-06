Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: inline assembly & r0 SOS
Date: Wed, 6 Aug 2008 10:41:50 +1000
References: <4898EE60.9080206@hypersurf.com>
In-Reply-To: <4898EE60.9080206@hypersurf.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808061041.50577.jk@ozlabs.org>
Cc: Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kevin,

>          /*
>           * Turn r3 (range) into a rotate count for the selected
> range. * 0 -> 23, 1 -> 31
>           */
>          __asm__ __volatile__ (  "slwi %0,%0,3\n"
>                                  "addi %0,%0,23\n"
>                                  "rlwnm %0,%1,%0,30,31\n":
>                  "=r"(ret):
>                  "r"(config),"0"(range)
>          );

Wouldn't this be much simpler in plain C?

However, if you really do need to do this in inline asm, you can use 
the "b" modifier rather than "r" to avoid using r0.

Cheers,


Jeremy
