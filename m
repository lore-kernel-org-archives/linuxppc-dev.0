Date: Thu, 29 Nov 2001 08:26:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org, kaos@ocs.com.au
Subject: Re: include/asm-ppc/platforms/
Message-ID: <20011129082625.R29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <15363.31192.101536.919771@gargle.gargle.HOWL> <3C2B376F.9070508@embeddededge.com> <15364.32906.728532.676746@gargle.gargle.HOWL> <3C0482F6.1050307@embeddededge.com> <15366.8350.416601.229303@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15366.8350.416601.229303@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 29, 2001 at 10:48:46PM +1100, Paul Mackerras wrote:

> The only reason for having include/asm-ppc/platforms under
> include/asm-ppc is so that serial.h can include the right
> blah_serial.h file.  We can get around that by using
> early_serial_setup except that that doesn't work if the serial driver
> is built as a module.  The boot stuff also needs to get at the first
> serial port but we can manage that by requiring the platform.h file to
> define e.g. BOOT_SERIAL_ADDRESS, BOOT_SERIAL_REG_SHIFT, etc., if it
> wants to use a serial port in the boot wrapper.  The boot wrapper code
> then just does #include <platform.h>.

What would <asm/serial.h> contain here?  Keep in mind that some ports
'just work' with the default <asm/serial.h>.

> Alternatively we can add a -Iarch/$(ARCH) flag for cc and put
> platform.h in arch/ppc and the platform headers in
> arch/ppc/platforms.  This is Keith's preferred solution and it feels
> right to me too.

This would probably be better.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
