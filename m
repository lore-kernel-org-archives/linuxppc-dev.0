Date: Fri, 3 May 2002 09:42:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'acurtis@onz.com'" <acurtis@onz.com>
Subject: Re: linuxppc_2_4_devel - Walnut compile
Message-ID: <20020503164242.GB894@opus.bloom.county>
References: <FA06AA2C99BCD511951200005A99441043863E@irvexch1.sextantifs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FA06AA2C99BCD511951200005A99441043863E@irvexch1.sextantifs.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, May 02, 2002 at 04:06:46PM -0700, Curtis, Allen wrote:

> 1. make menuconfig (xconfig - does not work)
>     and stripped out all of the extra junk
>

I hopefully just fixed xconfig.  Now I need to talk to Keith Owens to
get the proper fix pushed onto Marcelo.

> 2. linker error - early_serial* symbols undefined
>    modified drivers/char/Makefile - to include serial.c

Turn on CONFIG_SERIAL.  No one has tested any of the 4xx configs w/o
CONFIG_SERIAL, so it's not supprising it didn't work.  I've pushed a few
small things which might help however.

> 3. linker error - serial_close() undefined
>    reviewed the source code in arch/ppc. I believe that I need serial_sicc.c

This is odd.  Where was the linker error?  serial_close() is also in the
bootwrapper stuff.

> 4. Reviewed arch/ppc/config.in and discovered the following

Fix this as well (missing space was the actual problem).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
