Message-Id: <200007240811.JAA05417@hyperion.valhalla.net>
Date: Mon, 24 Jul 2000 09:11:08 +0100
Subject: Kernel build headers [was: Re: problems about __cli()]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since, I don't actually have a problem with finding the __cli() function
;-))

My installation was based on LinuxPPC 1999 Q3.  I decided to re-try the
actions that caused me to make my rash "vital" statement (as I said I'm not
immune from 'finger trouble' :-)

===

OK - I deleted the "linux" symlink in /usr/src (let's not get hung up about
where the kernel sources actually reside - I accept that con be anywhere one
chooses)....

On 2.2.17pre10 (having done a make mrproper, menuconfig, dep):

[root@athena stable-dma-int]# make vmlinux
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
In file included from /usr/include/errno.h:36,
                 from scripts/split-include.c:26:
/usr/include/bits/errno.h:25: linux/errno.h: No such file or directory

On 2.4.0-test4 (just to see if the build script makes *any* difference):

[root@athena linux-2.4.0-t4-wrk]# make vmlinux
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include scripts/split-include.c
In file included from /usr/include/errno.h:36,
                 from scripts/split-include.c:26:
/usr/include/bits/errno.h:25: linux/errno.h: No such file or directory

more below ====>>>

 Sat, Jul 22, 2000,  Martin Costabel wrote:
> Geert Uytterhoeven wrote:
>>
>> On Thu, 20 Jul 2000, Josh Huber wrote:
>>
>> You don't have to put your kernel in /usr/src, and you DON'T have to
>> symlink /usr/src/linux to it before you build.  The symlinks (on
>> broken RedHat derivatives) in /usr/include should point to the kernel
>> headers that your libc was built againt, otherwise you risk breaking
>> binary compatibility.
>
> This is an argument I have heard several times, but I never understood:
> If this risks breaking binary compatibility, then your kernel (compiled
> with its own headers, after all) might not be binary compatible with
> your glibc. Not nice.

So, if you are (habitually) building different kernels what *is* the right
solution?  Point to the source for the delivered kernel? (this won't work if
you make new headers in asm-ppc BTW) Point to the current source? Maintain
several parallel installations? (not sure how practical that is)...

>> > On Thu, Jul 20, 2000 at 02:45:56PM +0100, Iain Sandoe wrote:
>> > > I guess I *must* have one of those broken derivatives... and it doesn't
work
>> > > for me without that step...  Admittedly, this is mostly an issue between
>> > > 2.2.xx and 2.4.0 - but I do have to remember to change it back between
>> > > whiles... a better way would be ?
>> >
>> > Well...hmm, what doesn't work?  You mean you can't build a kernel
>> > unless you make /usr/src/linux point to the kernel source you're
>> > building?  This is odd, as I haven't done that...ever!  In fact,
>> > there's no directories in /usr/src on my machine.
>>
>> IIRC, there was a time (long before 2.0) that kernel builds did look for
>> includes in /usr/include/, so you had to unpack (or symlink) your kernel in
>> /usr/src/linux/. Fortunately the include path was changed to put
>> root_of_build/include first.
>
> There *are* situations where you need /usr/src/linux to point to your
> current kernel sources. This is when you compile modules for the current
> kernel, a prominent example being MOL.

Also, as I am doing, if you have a user-land program that accesses a
kernel-maintained structure via a syscall - the layout of the kernel
structure is (properly) defined in a header in linux/include/asm - but you
also need to get at it when compiling the user-land program.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
