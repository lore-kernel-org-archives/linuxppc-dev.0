Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33889DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 17:45:06 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3ac1a55a11baddefb903f24b988566fe@kernel.crashing.org>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<1172518068.15970.6.camel@localhost> <20070226222724.GA13182@keitarou>
	<1172558897.11949.43.camel@localhost.localdomain>
	<3ac1a55a11baddefb903f24b988566fe@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 07:43:07 +0100
Message-Id: <1172644987.11949.90.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, john stultz <johnstul@us.ibm.com>,
	Paul TBBle Hampson <Paul.Hampson@Pobox.com>, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It's most likely a red herring, lots of config changes
> make the bug go away on some kernel versions (but not
> on others); the problem is very sensitive to changes in
> memory layout.

I wouldn't be that sure ... I've had problems in the past with PMU based
cpufreq... looks like flushing all caches and hard-resetting the
processor on the fly when there can be pending DMAs might be a source of
trouble... especially on CPUs that don't have working cache flush HW
assist.

Ben.
