Date: Thu, 29 Nov 2001 16:18:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
Message-ID: <20011129161853.N29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011129154610.M29541@cpe-24-221-152-185.az.sprintbbd.net> <31270.1007075553@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <31270.1007075553@ocs3.intra.ocs.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 30, 2001 at 10:12:33AM +1100, Keith Owens wrote:
> On Thu, 29 Nov 2001 15:46:10 -0700,
> Tom Rini <trini@kernel.crashing.org> wrote:
> >On Fri, Nov 30, 2001 at 09:38:36AM +1100, Keith Owens wrote:
> >> Tom Rini <trini@kernel.crashing.org> wrote:
> >> >and all platforms need a
> >> >platform/platform_serial.h file for serial to work with this scheme?
> >>
> >> No, an empty one is automatically generated if necessary.
> >
> >So yes, for CONFIG_SERIAL to work, the file needs to exist.  Which has
> >the downside that at least a handful of platforms will need to cp
> >all_ppc_serial.h.
>
> Are the *_serial.h files intended as extensions for asm-ppc/serial.h or
> as complete replacements for it?

They could be <asm/serial.h> yes.

> If they are extensions then adding
> #include <platform_serial.h> to asm-ppc/serial.h is enough.  If they are
> complete replacements then the code is a little harder, but not much.
>
> *.c files include only <asm/serial.h>.  In platform *_serial.h files,
> #define REPLACES_PPC_SERIAL_H.  In asm-ppc/serial.h,
>
> #include <platform_serial.h>
> #ifndef REPLACES_PPC_SERIAL_H
> ... default ppc serial definitions
> #endif

That would probably work best, yes.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
