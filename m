Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18172.15699.359375.286439@cargo.ozlabs.ibm.com>
Date: Fri, 28 Sep 2007 09:31:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
In-Reply-To: <20070927191233.201980@gmx.net>
References: <20070927191233.201980@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard Pircher writes:

> I'm working on a 2.6.23 kernel for the AmigaOne. I implemented the device
> tree and the platform setup code, which all compiles fine. I built a
> cuImage target, loaded it on my target machine with TFTP and booted it.
> The kernel passes the platform setup code and then dies somewhere in the
> driver init code (AFAICT), but before the keyboard driver is initialized
> (thus magic sysrq key doesn't work). Can somebody help me to track down
> this problem?

You appear to have a working 16550-style serial port which the udbg
infrastructure sees.  Thus you should be able to use xmon, talking to
it via the serial port.  Put "xmon" on the kernel command line and the
kernel will drop into xmon early in the boot process (in setup_arch).
Then, either the kernel will oops at some point and drop into xmon,
and you can then inspect memory and registers and get a stack trace,
or it will hang at some point.  If it hangs, you can work out where it
hangs by putting in breakpoints at various points and seeing which
breakpoints you get to (this might take several boots).

Paul.
