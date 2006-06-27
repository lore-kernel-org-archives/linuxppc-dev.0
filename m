Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7811467A62
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2006 20:14:03 +1000 (EST)
Date: Tue, 27 Jun 2006 12:08:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Remove extra local_bh_disable/enable from arch do_softirq
Message-ID: <20060627100856.GA17160@elte.hu>
References: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> At the moment, powerpc and s390 have their own versions of do_softirq 
> which include local_bh_disable() and __local_bh_enable() calls.  They 
> end up calling __do_softirq (in kernel/softirq.c) which also does 
> local_bh_disable/enable.
> 
> Apparently the two levels of disable/enable trigger a warning from 
> some validation code that Ingo is working on, and he would like to see 
> the outer level removed.  But to do that, we have to move the 
> account_system_vtime calls that are currently in the arch do_softirq() 
> implementations for powerpc and s390 into the generic __do_softirq() 
> (this is a no-op for other archs because account_system_vtime is 
> defined to be an empty inline function on all other archs).  This 
> patch does that.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

thanks - this solves the problem nicely.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
