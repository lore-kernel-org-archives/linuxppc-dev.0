Return-Path: <satyam@infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF284DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 10:06:10 +1000 (EST)
Date: Tue, 18 Sep 2007 05:38:57 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Avoid pointless WARN_ON(irqs_disabled()) from
	panic codepath
In-Reply-To: <alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
Message-ID: <alpine.LFD.0.999.0709180535470.8863@enigma.security.iitk.ac.in>
References: <46EA5CEB.7020104@linux.vnet.ibm.com>
	<a781481a0709140337u2c26f770h2af6d457bc39f280@mail.gmail.com>
	<alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Tue, 18 Sep 2007, Satyam Sharma wrote:
> 
> > ------------[ cut here ]------------
> > Badness at arch/powerpc/kernel/smp.c:202
> 
> comes when smp_call_function_map() has been called with irqs disabled,
> which is illegal. However, there is a special case, the panic() codepath,
> when we do not want to warn about this -- warning at that time is pointless
> anyway, and only serves to scroll away the *real* cause of the panic and
> distracts from the real bug.

BTW arch/ppc/ has same issue, but that's gonna be removed by next year
anyways, so I think there's no point making a patch for that (?)
