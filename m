To: Ron Flory <ron.flory@adtran.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: embedded gcc PPC toolchain questions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 29 May 2003 10:38:52 CDT."
             <3ED6298C.3070901@adtran.com>
Date: Thu, 29 May 2003 18:22:38 +0200
Message-Id: <20030529162243.ED346C5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Ron,

in message <3ED6298C.3070901@adtran.com> you wrote:
>
>   I have several low-level gcc toolchain questions.  I'm not new to

Umm... did you read the info files for GCC and the GNU linker?

>   Apologies in advance if these appear to be a little off-subject.
> I welcome redirection to online FAQs or code snippets.  Thanks.

It is definitely useful to read existing code, too. The Linux  kernel
or the U-Boot bootloader are good places to start.

> 1.  How does one declare distinct data regions with GCC?  Consider

Use __attribute__ ((section("<name>")))

>     the case where a separate non-cached memory region is needed
>     for CPM/FEC use, I would do something like the following under
>     GreenHills C/C++:
>
>      #pragma ghs section data = ".nocacheram"
>         static char fec_rbd_alloc[ <some length> ] = { 0 };
>         static char fec_tbd_alloc[ <some length> ] = { 0 };
>      #pragma ghs section

static char fec_rbd_alloc[ <some length> ] __attribute__ ((section(".nocacheram"))) = { 0 };

etc.

It probably makes sense to define some macros, like this:

#define ___NOCACHERAM__ __attribute__ ((section(".nocacheram")))
...
static char fec_rbd_alloc[ <some length> ] ___NOCACHERAM__ = { 0 };


>      Such distinct regions are generally collected and combined
>     across modules, so the FEC and CPM drivers would place their
>     buffers in the same non-cached area.

Same here.

> 2.  Once I have defined and declared such regions, how does one
>     instruct the linker to align and padd such regions?  Under
>     Greenhills, this would be done in a linker control file, such
>     as:
>
>      .nocacheram  align(0x1000)   :
>      .evtdata     align(0x1000)   :

With GNU ld you will use a linker control file, too.

Something like this:

...
. = ALIGN(4 * 1024);
.nocacheram	:
{
	*(.nocacheram)
}
. = ALIGN(4 * 1024);
...

>        This would align ".nocacheram" on a 4kb boundary, and would
>       ensure 4Kb length as well (since the following group was also
>       4Kb aligned).

Same here.

> 3.  Once I have defined, declared, and aligned these special memory
>     regions, how would I determine their base/length?  Again, under
>     GreenHills, we would declare:
>
>       extern char __ghsbegin_nocacheram[];
>       extern char __ghsend_nocacheram[];
>
>      Which would provide the 'begin' and 'end' address of the region,
>     allowing us to set the appropriate MMU attributes for this user-
>     defined area.

You can define symbols in the linker script, too. Like this:

...
. = ALIGN(4 * 1024);
begin_nocacheram	:
{
	*(.nocacheram)
}
end_nocacheram:
. = ALIGN(4 * 1024);
...

> 4.  I know the question of embedded libc comes up often.  For
>     the most part, we basically need the 'strxxx' and 'memxxx'
>     functions, but 'sprintf' is quite a different critter.  Since
>     we are running an 860, we won't have FP support (and we don't
>     want to deal with emulation).  Do most folks use a hand-patched
>     'sprintf' source file, manually removing the floating-point ops?
>     I've looked into this a few years ago (the gcc sprintf source
>     file is a horror).  Has the 'ulibc' that i've heard about been
>     used with success by anybody on this list for embedded non-linux
>     projects?

Again, have a look at U-Boot and Linux. (U-Boot reuses the Linux code.)

> 5.  We have access to many Macraigor 'Raven' BDM interfaces.  I've
>     downloaded the x86 Linux support tools for this device.  Has
>     anybody had good results with this device and support tools
>     under Linux?

We prrefer the BDI2000.

> 6.  OK, please don't flame me on this stupid question.  Does 'as'
>     (the assembler) run its source input through the 'cpp' C
>     PreProcessor?  I can always pipe through cpp myself with an
>     implicit 'make' target if I need to...

"as" does not use "cpp". If you want  to  use  "cpp",  then  you  can
either  use "cpp" in a separate step, or use "gcc" which knows how to
deal with "*.S" source files.

Again, see Linux and U-Boot code for examples.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If I can have honesty, it's easier to overlook mistakes.
	-- Kirk, "Space Seed", stardate 3141.9

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
