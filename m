Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id B48702BDB2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Sep 2004 04:51:14 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Sep 2004 13:21:16 EDT."
	<Pine.LNX.4.60.0409281317590.11302@localhost.localdomain>
Date: Wed, 29 Sep 2004 16:22:35 +0200
Sender: wd@denx.de
Message-Id: <20040929142240.AC2C5C1430@atlas.denx.de>
Resent-Message-Id: <20040929174103.D2F31C1430@atlas.denx.de>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: I2C/SPI/SMC relocation patch works for both SMC 1 and 2? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409281317590.11302@localhost.localdomain> you wrote:
> 
> > It relates to the SMC which parameter RAM  location  is  in  conflict
> > with the SPI/I2C parameter RAM, i. e. SMC1.
> 
> huh?  what does SMC1 relocation have to do with either of I2C or SPI? 

Ooops. You are right. Please s/SPI\/I2C/SCC2  ethernet/  !  Before  I
tell  more  such  nonsense  let's  quote  the  description that comes
included with  the  patch:  "model  allows  concurrent  operation  of
Ethernet  and  SMC(UART)  and  I2C/SPI  by  solving the parameter RAM
conflict caused by the fact that  some  of  the  Ethernet  parameters
overlay the SMC(UART) and I2C/SPI parameters."

> i don't see how SMC1 can be "in conflict with the SPI/I2C parameter 
> RAM" as you claim.  can you explain that?

If you use SCC2 for ethernet, it's parameter RAM will use  the  DPRAM
from  offset  3E00  to  offset  3EA4;  without  relocation  the  SMC1
parameter RAM uses offsets 3E80 to 3EB4, thus you have a conflict for
the 3E80...3EA4 area.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.
