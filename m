Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17854.33603.655565.110084@cargo.ozlabs.ibm.com>
Date: Tue, 30 Jan 2007 10:29:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH 0/6] MSI portability cleanups
In-Reply-To: <1170065487.19887.91.camel@concordia.ozlabs.ibm.com>
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
	<20070128.212554.23015561.davem@davemloft.net>
	<1170050737.26655.233.camel@localhost.localdomain>
	<m1sldukxwm.fsf@ebiederm.dsl.xmission.com>
	<1170065487.19887.91.camel@concordia.ozlabs.ibm.com>
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	David Miller <davem@davemloft.net>, greg@kroah.com,
	linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
	linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	mingo@elte.hu, brice@myri.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> You can read config space, but it's not clear to me if the HV is allowed
> to filter it and hide things. It's also possible that the device

It appears that the HV does not prevent us from reading or writing any
config space registers for functions that are assigned to us.

> supports MSI, but for some reason the HV doesn't allow it on that device
> etc. so you really have to ask the HV if it's enabled. So pci_find_cap()
> shouldn't crash or anything, but it may lie to you.

It's possible that the device can do MSI(X), but that using MSI(X)
requires other platform resources (e.g. interrupt source numbers) and
there are none free.  I believe the platform guarantees a minimum
number of MSI(X) interrupts per function, but a pci_enable_msix() call
may not be able to give the driver as many MSI-X interrupts as it is
requesting even if the function can handle that many.

Paul.
