Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 9D66C67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 21:39:19 +1100 (EST)
To: "Jean Nicollerat MD" <jean.nicollerat@microdev.ch>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Mar 2005 10:27:07 +0100."
	<HMECJAKDCPLOGPDHNAHEAEKHCAAA.jean.nicollerat@microdev.ch>
Date: Thu, 17 Mar 2005 11:39:02 +0100
Sender: wd@denx.de
Message-Id: <20050317103907.185B1C1510@atlas.denx.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RTC with TQM823L 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <HMECJAKDCPLOGPDHNAHEAEKHCAAA.jean.nicollerat@microdev.ch> you wrote:
>
> I'm used to program on processor without OS. I want try linux to use linux

That was what I expected from your posting.

> I have to read message that comme on the CAN bus every 2ms. Then I have to
> show values on the LCD and transfers some message on the RS232.

Ok.

> I need a timer to the check the reception of the messages.

No. This is fundamentally wrong. You do NOT need a timer to check  if
a device driver has data available.

This is exactly what I meant when sayin you will have to get used  to
working  in  a Unix environment., Under Unix, you will not use a time
triggered control loops which polls all your drivers,  but  you  will
use select() or poll() to wait for events from your drivers. It's the
incoming data which triggers your control loop, not a timer.

> I seem it is difficult with linux. I will try with the RTAI.

DO NOT DO IT. This will only make things worse. You are on the  wrong
track.  Don't  try to stick with a software design which does not fit
any more. Change your  design  to  take  advantage  of  the  services
provided by a Unix operating system.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Never call a man a fool.  Borrow from him.
