Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC5D7DDF2B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 10:40:52 +1100 (EST)
Subject: Re: [PATCH 0/6] MSI portability cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17854.33603.655565.110084@cargo.ozlabs.ibm.com>
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
	<20070128.212554.23015561.davem@davemloft.net>
	<1170050737.26655.233.camel@localhost.localdomain>
	<m1sldukxwm.fsf@ebiederm.dsl.xmission.com>
	<1170065487.19887.91.camel@concordia.ozlabs.ibm.com>
	<17854.33603.655565.110084@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 30 Jan 2007 10:40:03 +1100
Message-Id: <1170114003.26655.291.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	greg@kroah.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	David Miller <davem@davemloft.net>, brice@myri.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> It's possible that the device can do MSI(X), but that using MSI(X)
> requires other platform resources (e.g. interrupt source numbers) and
> there are none free.  I believe the platform guarantees a minimum
> number of MSI(X) interrupts per function, but a pci_enable_msix() call
> may not be able to give the driver as many MSI-X interrupts as it is
> requesting even if the function can handle that many.

However, the ibm,req#msi(-x) properties contain the number as requested
by the device, and thus I expect them to be identical to the config
space value. So if you are confident enough that our HV won't play any
tricks there in the future, reading the config space is as good as
hooking that check() callback, though it might not be vs. some other HV
for some other platform that might be more strict.

We cannot know in advance how much max the HV will give us without
actually trying ibm,change-msi and see the result code for it
unfortunately.

Ben.
