Return-Path: <SRS0+e745ee24513501df0a3a+1203+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [RFC] powerpc: experimental of serial port driver
From: David Woodhouse <dwmw2@infradead.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <457AE7D6.4060503@ru.mvista.com>
References: <200612072140.47405.arnd@arndb.de>
	<200612081612.28385.arnd@arndb.de>
	<1165611049.1103.37.camel@localhost.localdomain>
	<200612090042.58601.arnd@arndb.de>
	<1165630432.1103.107.camel@localhost.localdomain>
	<457AE7D6.4060503@ru.mvista.com>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 17:39:10 +0000
Message-Id: <1165685950.5253.456.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-12-09 at 19:44 +0300, Sergei Shtylyov wrote:
> Then it should be something like "nc16750\0ns16550\0ns16450\08250". 

Those aren't particularly interesting distinctions -- they're dead easy
to probe for. The really interesting one is the type of SuperIO chip
it's compatible with -- which specifies how you get baud rates above
115200. For some chips (SMSC iirc) you have a 'magic multiplier'; by
setting the divisor to 0x8001 or 0x8002 you get 230400/460800 baud resp.
For NatSemi type chips you have baud rate divisors in an alternate bank,
and you get a higher baud_base if you use those but if you use the
registers in bank zero it reverts to 115200, etc. 

-- 
dwmw2
