Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BC3CDDEBA
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 17:50:03 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul TBBle Hampson <Paul.Hampson@Pobox.com>
In-Reply-To: <20070226222724.GA13182@keitarou>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<1172518068.15970.6.camel@localhost> <20070226222724.GA13182@keitarou>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 07:48:16 +0100
Message-Id: <1172558897.11949.43.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, john stultz <johnstul@us.ibm.com>,
	torvalds@linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I've not been able to reproduce it since, but I know others (BCC'ed on
> > this note) have seen it and might prod them to come forth with details
> > (and broken .config files)
> 
> In my case, disabling CPU_FREQ_PMAC made the failure go away.
> After reverting this patch, CPU_FREQ_PMAC is once again operating
> successfully, so far.

Hrm.. which cpufreq method is used on both your machines ? If it's the
one involving the PMU, it does involve a full hard reset of the
processor (with appropriate cache flushes etc...), maybe something's
going wrong in that area....

Ben.
