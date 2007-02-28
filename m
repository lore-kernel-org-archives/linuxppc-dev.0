Return-Path: <SRS0+b55b16f95c203484ea50+1284+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26D2CDDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 21:13:32 +1100 (EST)
Subject: Re: Make sure we populate the initroot filesystem late enough
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1172644987.11949.90.camel@localhost.localdomain>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<1172518068.15970.6.camel@localhost> <20070226222724.GA13182@keitarou>
	<1172558897.11949.43.camel@localhost.localdomain>
	<3ac1a55a11baddefb903f24b988566fe@kernel.crashing.org>
	<1172644987.11949.90.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 10:13:04 +0000
Message-Id: <1172657584.3452.51.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: john stultz <johnstul@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul TBBle Hampson <Paul.Hampson@Pobox.com>,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-28 at 07:43 +0100, Benjamin Herrenschmidt wrote:
> I wouldn't be that sure ... I've had problems in the past with PMU based
> cpufreq... looks like flushing all caches and hard-resetting the
> processor on the fly when there can be pending DMAs might be a source of
> trouble... especially on CPUs that don't have working cache flush HW
> assist. 

I've seen it on a PowerMac3,1 (400MHz G4) where we don't have cpufreq.
I've also seen it on the latest 1.5GHz Mac Mini, and on my shinybook.
They all fall over with the latest kernel, although the shinybook only
does so immediately when booted with mem=512M. The shinybook does crash
later with new kernels though; I don't yet know why. It could be the
same thing, or it could be something different. That one seemed to
appear between Fedora's 2.6.19-1.2913 and 2.6.19-1.2914 kernels, where
we did nothing but turned CONFIG_SYSFS_DEPRECATED on.

I don't blame cpufreq. At various times I've been equally convinced that
it was due to CONFIG_KPROBES, and Linus' initrd-moving patch.

-- 
dwmw2
