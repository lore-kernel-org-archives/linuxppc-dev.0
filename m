Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E26EDE2A4
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 05:45:11 +1000 (EST)
Message-ID: <4846F0C0.80808@freescale.com>
Date: Wed, 04 Jun 2008 14:45:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: inline assembly
References: <4846EEAE.3000908@hypersurf.com>
In-Reply-To: <4846EEAE.3000908@hypersurf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs wrote:
> Hi,
> 
>     When doing inline assembly, is there a way to get the compiler to 
> assign "extra" (one not specified for inputs and outputs) registers? In 
> the following:
> 
>                 __asm__ __volatile__ (
>                         "addi 5,%1,-1\n"
>                         "andc 5,%1,5\n"
>                         "cntlzw 5,5\n"
>                         "subfic %0,5,31":
>                         "=r"(j):
>                         "r"(i)
>                 );
> 
> Can I get the compiler to choose a register for r5?

Yes, like this:

int tmp;

asm volatile("addi %1, %2, -1;"
              "andc %1, %2, %1;"
              "cntlzw %1, %1;"
              "subfic %0, %1, 31" : "=r" (j), "=&r" (tmp) : "r" (i));

However, it'd be better to let the compiler do more, by just using the 
existing cntlzw() function.

-Scott
