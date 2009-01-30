Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 895E0DE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 13:12:00 +1100 (EST)
Subject: Re: 2.6.28-rt on PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
References: <20090129213429.GA29014@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Fri, 30 Jan 2009 13:11:50 +1100
Message-Id: <1233281510.18767.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This is trivially solved by converting arch/powerpc/sysdev/ipic.c
> back to spinlocks (ipic_lock).
> 
> Assuming that converting-back is automatic, there are few other
> chained interrupt controllers you might want to convert-back:
> 
> arch/powerpc/sysdev/i8259.c (i8259_lock)
> arch/powerpc/sysdev/mpic.c (mpic_lock)
> arch/powerpc/sysdev/qe_lib/qe_ic.c (qe_ic_lock)

Except that a bunch of those can be both primary and chained... It's
simply not a solution to have to "convert" interrupt controller code to
use a different locking scheme depending on whether they are chained or
primary...

Cheers,
Ben.
