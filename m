Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC] powerpc: experimental of serial port driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1165588888.3328.8.camel@hades.cambridge.redhat.com>
References: <200612072140.47405.arnd@arndb.de>
	<1165553018.1103.23.camel@localhost.localdomain>
	<1165588888.3328.8.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 07:50:04 +1100
Message-Id: <1165611004.1103.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-12-08 at 14:41 +0000, David Woodhouse wrote:
> On Fri, 2006-12-08 at 15:43 +1100, Benjamin Herrenschmidt wrote:
> > I'd rather call it 8250_of.c and have it be specific to 8250's.
> 
> Didn't we already do that once?

Not really, right now, we use a platform driver (though it should work,
again, I'm not completely sure why we need that at all).

legacy_serial.c should be detecting all 8250 type ports at boot, init
them, setup a udbg console for them, and later on, register them as
platform devices with the 8250 driver. The problem right now is that the
code in there will only do that for known busses, which doesn't include
opb. So we should just fix it for opb and things should work.

Ben.
