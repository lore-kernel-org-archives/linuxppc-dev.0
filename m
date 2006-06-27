Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4F7167B44
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 00:51:25 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.6/8.13.6) with ESMTP id k5RBgxHU027700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2006 11:42:59 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5RBjTnw141332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2006 13:45:29 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k5RBgwer009052
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2006 13:42:58 +0200
Subject: Re: [PATCH] Remove extra local_bh_disable/enable from arch do_softirq
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
References: <17566.32236.368906.227113@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 13:43:09 +0200
Message-Id: <1151408589.5390.4.camel@localhost>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, mingo@elte.hu,
	linux-kernel@vger.kernel.org
Reply-To: schwidefsky@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-06-25 at 22:13 +1000, Paul Mackerras wrote:
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

Nod, Heiko stumbled over that one as well as he ported the lock
validator patch. Moving the account_system_vtime call is the correct
solution.
 
-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
