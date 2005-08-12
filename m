Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 7D69367F10
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 18:01:27 +1000 (EST)
To: cajus.hahn@de.abb.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 Aug 2005 09:49:05 +0200."
	<OF29EF0D8D.F0A40A5C-ONC125705B.0028FA70-C125705B.002AF212@de.abb.com>
Date: Fri, 12 Aug 2005 10:01:13 +0200
Sender: wd@denx.de
Message-Id: <20050812080113.AA881352B36@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx: i2c-algo-8xx - fixed timeout detection and transmission
	errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <OF29EF0D8D.F0A40A5C-ONC125705B.0028FA70-C125705B.002AF212@de.abb.com> you wrote:
> 
> Then I set the SCL line to ground to simulate a longer bus disturbance.
> After some timeouts my SPI bus, yes the SPI bus, reportet transmission
> errors. Both bus-interfaces use the CPM. It looks like the SPI buffer gets
> garbaged by the I2C interface.

This is "normal". We see similar problems even with  perfectly  legal
operations  on  the CPM. The SPI is running at lowest priority on the
CPM, and anything that  causes  higher  CPM  load  will  starve  SPI.
Obviously  your  operation  causes  the  CPM  to go into some strange
state.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are certain things men must do to remain men.
	-- Kirk, "The Ultimate Computer", stardate 4929.4
