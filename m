Date: Thu, 29 Nov 2001 15:27:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
Message-ID: <20011129152741.L29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011129082625.R29541@cpe-24-221-152-185.az.sprintbbd.net> <30560.1007072360@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <30560.1007072360@ocs3.intra.ocs.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 30, 2001 at 09:19:20AM +1100, Keith Owens wrote:
> On Thu, 29 Nov 2001 08:26:25 -0700,
> Tom Rini <trini@kernel.crashing.org> wrote:
> >On Thu, Nov 29, 2001 at 10:48:46PM +1100, Paul Mackerras wrote:
> >> The only reason for having include/asm-ppc/platforms under
> >> include/asm-ppc is so that serial.h can include the right
> >> blah_serial.h file.  We can get around that by using
> >> early_serial_setup except that that doesn't work if the serial driver
> >> is built as a module.  The boot stuff also needs to get at the first
> >> serial port but we can manage that by requiring the platform.h file to
> >> define e.g. BOOT_SERIAL_ADDRESS, BOOT_SERIAL_REG_SHIFT, etc., if it
> >> wants to use a serial port in the boot wrapper.  The boot wrapper code
> >> then just does #include <platform.h>.
> >
> >What would <asm/serial.h> contain here?  Keep in mind that some ports
> >'just work' with the default <asm/serial.h>.
>
> The make rules I sent to Paul automatically generate platform.h and
> platform_serial.h by copying the platform specific files to arch/ppc
> under standard names.  If the platform has no *_serial.h file then
> platform_serial.h is a zero length file.  So ppc code can always
>
> #include <platform.h>
> #include <platform_serial.h>

So <asm/serial.h> just has the above two lines and all platforms need a
platform/platform_serial.h file for serial to work with this scheme?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
