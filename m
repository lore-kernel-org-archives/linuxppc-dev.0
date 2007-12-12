Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01266DDF3E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 19:00:12 +1100 (EST)
Message-Id: <B07AAF57-E87C-40CF-A550-7F868497A2CB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20071212054512.882AC62C070@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
Date: Wed, 12 Dec 2007 01:59:55 -0600
References: <20071212054512.882AC62C070@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2007, at 11:45 PM, Michael Neuling wrote:

> This makes the setjmp/longjmp code used by xmon, generically available
> to other code.  It also removes the requirement for debugger hooks to
> be only called on 0x300 (data storage) exception.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>
> arch/powerpc/kernel/misc_64.S |  124 ++++++++++++++++++++++++++++++++ 
> ++++++
> arch/powerpc/mm/fault.c       |    6 -
> arch/powerpc/xmon/Makefile    |    2
> arch/powerpc/xmon/setjmp.S    |  135  
> ------------------------------------------
> arch/powerpc/xmon/xmon.c      |   10 ---
> include/asm-powerpc/setjmp.h  |   12 +++
> 6 files changed, 142 insertions(+), 147 deletions(-)

it would seem that moving this code out of xmon.c into misc_64.s would  
break ppc32 usage.

- k
