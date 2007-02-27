Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0908DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 22:58:35 +1100 (EST)
In-Reply-To: <1172558897.11949.43.camel@localhost.localdomain>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<1172518068.15970.6.camel@localhost>
	<20070226222724.GA13182@keitarou>
	<1172558897.11949.43.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3ac1a55a11baddefb903f24b988566fe@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
Date: Tue, 27 Feb 2007 12:58:28 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

>>> I've not been able to reproduce it since, but I know others (BCC'ed 
>>> on
>>> this note) have seen it and might prod them to come forth with 
>>> details
>>> (and broken .config files)
>>
>> In my case, disabling CPU_FREQ_PMAC made the failure go away.
>> After reverting this patch, CPU_FREQ_PMAC is once again operating
>> successfully, so far.
>
> Hrm.. which cpufreq method is used on both your machines ? If it's the
> one involving the PMU, it does involve a full hard reset of the
> processor (with appropriate cache flushes etc...), maybe something's
> going wrong in that area....

It's most likely a red herring, lots of config changes
make the bug go away on some kernel versions (but not
on others); the problem is very sensitive to changes in
memory layout.


Segher
