Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A3DDF67A86
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 06:01:03 +1100 (EST)
Date: Tue, 18 Jan 2005 10:54:19 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050118185418.GA31308@gate.ebshome.net>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 18, 2005 at 11:25:33AM -0500, Dan Malek wrote:
> There are three reasons.  You don't want to use an I2c rtc clock at
> all in these functions because they get can get called from the
> clock interrupt to update the time in the rtc.  If it does happen to 
> work,
> it creates long latencies in the timer interrupt.  If the i2c requires 
> an
> interrupt, they system will crash or hang.
> 
> A system using an I2C RTC should find some way to access the
> clock from application space as a standard I2C device and manage
> time/clock from the application, not from the kernel.

Well, it was discussed numerous times before with solutions how to use 
i2c based RTC as well.

I use i2c RTC which requires interrupt and guess what, my kernel 
doesn't crash when timer_interrupt calls ppc_md.set_rtc_time.

It's just a matter of writing correct i2c RTC driver.

Dan, please, stop spreading "i2c-RTC" FUD :).

--
Eugene
