Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F126EDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 19:15:21 +1000 (EST)
Subject: Re: fsl booke MM vs. SMP questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070522084645.GA12009@iram.es>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<20070522084645.GA12009@iram.es>
Content-Type: text/plain
Date: Tue, 22 May 2007 19:14:38 +1000
Message-Id: <1179825278.32247.827.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Dave Liu <r63238@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Why do you want to clear the reservation here? 
> 
> Coming out of some code path with the reservation still held 
> can only affect buggy code (someone doing st[dw]cx. before 
> l[dw]arx) AFAIK.

And buggy CPUs :-)

Seriously, lots of CPU implementations don't test the address for local
lwarx stwcx. so if your kernel code "replaces" a reservation with
another that is left set, the userland stwcx. might well succeed which
is bogus.

Ben.
