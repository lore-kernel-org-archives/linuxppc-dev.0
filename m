Date: Thu, 28 Mar 2002 12:28:27 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: DST flag in NVRAM revisited (was: Re: NVRAM stuck in DST?)
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011207213804.7802@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16qY53-0000Iw-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Back in December, I had problems with my clock always beeing wrong.

On   7 Dec, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>Hmmm... DST on? That's wrong; we're not in DST anymore! And the current
>>offset to GMT is one hour, not two hours. I'm wondering whether
>>something else besides MacOS sets those values.
>
> AFAIK, MacOS is the only one to set it.

Also my understanding.

>>If not, then I'll be stuck with whatever NVRAM values MacOS wrote there
>>when it was last booted. Which means that unless at every DST time
>>change, unless I bot MacOS once, I'll be stuck with the wrong time....
>
> Yup, we need a proper tool for that.

I've since tracked what happens to the GMT offset in nvram on bootup.

In arch/ppc/kernel/time.c, kernel time is set from the RTC, implicitly
taking RTC for GMT time. Under MacOS, however, it's localtime. On pmac,
we use the GMT offset MacOS stores in nvram to correct this, and correct
kernel time to real GMT. We also set kernel timezone info, but it's use
is discouraged (have a look at man settimeofday).

Now, when this offset is wrong (like when DST switched and you didn't
boot MacOS since), your intial kernel time will be wrong. However, the
rc files should set the kernel time once more on bootup (which is the
case now for me in Debian), and everything is peachy again.

So, my initial problem was caused by either my kernel lacking RTC
support or by my distribution (linuxppc at that time) not forcing the
clock.

The question, of course, is whether Linux should maintain this GMT
offset in nvram, since it uses it's information. If so, then who should
maintain it where?

- Userland tool: doesn't sound like a good idea; it's something very
  machine-specific.

- kernel: maybe, but when should the info be updated in nvram? Where
  does the kernel get the DST and offset info from (since it basically
  doesn't know anything about the local idea of wallclock time)

My proposition would be to correct this everytime that the RTC is
updated (since the GMT offset belongs logicaly to the RTC function
block). Debian does this on every system shutdown.

Remains to be seen if the kernel RTC driver should do the work, or a
useland tool:

> Actually, we need 2 things
>
>  - a way for /dev/nvram to let userland know about the partitioning
> of the nvram (expecially where the xpram is)

There is an ioctl defined for /dev/nvram in include/asm-ppc/nvram.h,
but it's not accessible from userspace (defined inside #idfdef
__KERNEL__). I'd say bug?

>  - then a tool using that to write to the MachineLocation record
> in nvram containing the tz offset and DST flag.

I have something working for OldWorld, but it's a _very_ ugly hack ;-)


Obviously, the easiest thing to do is do nothing and entirely rely on
the bootup scripts to set the correct time.

Comments anyone?

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
