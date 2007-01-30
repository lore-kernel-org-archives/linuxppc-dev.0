Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8190CDDF4F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 06:33:05 +1100 (EST)
In-Reply-To: <17854.32201.131104.928581@cargo.ozlabs.ibm.com>
References: <m1hcuaohqj.fsf@ebiederm.dsl.xmission.com>
	<20070128.153707.30184351.davem@davemloft.net>
	<m1tzyammv0.fsf@ebiederm.dsl.xmission.com>
	<20070128.212554.23015561.davem@davemloft.net>
	<1170050737.26655.233.camel@localhost.localdomain>
	<m1sldukxwm.fsf@ebiederm.dsl.xmission.com>
	<1170102158.26655.273.camel@localhost.localdomain>
	<17854.32201.131104.928581@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A6651BCA-2975-4C5C-9A2C-1B4461B0FEEA@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/6] MSI portability cleanups
Date: Tue, 30 Jan 2007 20:32:19 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: tony.luck@intel.com, grundler@parisc-linux.org, jeff@garzik.org,
	mingo@elte.hu, linux-kernel@vger.kernel.org,
	kyle@parisc-linux.org, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>, greg@kroah.com,
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

> I just got an answer from the hypervisor architects.  It turns out
> that the hardware _does_ prevent the device from sending MSI messages
> to another partition.  The OS _can_ write whatever it likes to the MSI
> address and data registers.  It can potentially lose interrupts (or, I
> expect, get the device isolated by EEH) but it can't disrupt another
> partition.

The OS however has to write the values the HV wants to
the device, or things won't work -- so the HV can just
as well do it itself.  Also, pulling all the work into
the HV makes for a cleaner, more generic design (who
knows what hardware will show up within the next few
years, the HV interface had better be prepared).


Segher
