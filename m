Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 90394DE2EC
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:07:50 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id D932A150E65
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 16:07:46 +0200 (CEST)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3K6yvFmKVj3q for <linuxppc-dev@ozlabs.org>;
	Tue, 20 May 2008 16:07:44 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id A7541150E37
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 16:07:44 +0200 (CEST)
Date: Tue, 20 May 2008 16:07:44 +0200
From: Philippe De Muyter <phdm@macqel.be>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc + i2c/rtc : where is the 11 min update ?
Message-ID: <20080520140744.GA6427@frolo.macqel>
References: <20080520105844.GA694@frolo.macqel>
	<18482.45473.866954.385654@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18482.45473.866954.385654@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CCing lkml

On Tue, May 20, 2008 at 09:10:25PM +1000, Paul Mackerras wrote:
> Philippe De Muyter writes:
> 
> > I have a ARCH=powerpc linux-2.6.25-rc6 linux running with an i2c rtc chip,
> > and synchronized to a ntp server.
> > 
> > I noticed that my rtc chip does not get updated by the kernel, just like
> > it would be on all other architectures (included ppc).
> 
> That is now supposed to be done by the code inside #ifdef
> CONFIG_GENERIC_CMOS_UPDATE in kernel/time/ntp.c.
> 
> Paul.

Thanks.  I agree that is a good place.

But, here CONFIG_GENERIC_CMOS_UPDATE is defined and an i2c clock also,
and my rtc clock is not updated.  I see kernel/time/ntp.c::sync_cmos_clock
calling arch/powerpc/kernel/time.c::update_persistent_clock, where
ppc_md.set_rtc_time is NULL.

Who is supposed to initialize ppc_md.set_rtc_time to use an i2c clock and
when in the boot process may that happen ?

Or alternatively, should update_persistent_clock not be part of the rtc
subsystem ?

Philippe
