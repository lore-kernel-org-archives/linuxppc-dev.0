Message-Id: <200007242101.WAA16532@hyperion.valhalla.net>
Date: Mon, 24 Jul 2000 21:58:12 +0100
Subject: Re: Kernel build headers [was: Re: problems about __cli()]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Josh Huber <huber@mclx.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 24, 2000, Josh Huber wrote:
> On Mon, Jul 24, 2000 at 09:11:08AM +0100, Iain Sandoe wrote:
>> On 2.2.17pre10 (having done a make mrproper, menuconfig, dep):
[snip]

Thanks for the info. read & understood... guess I'll have to continue this
way until my distro settles into the new way (or I have time to change
distro)...

>> Also, as I am doing, if you have a user-land program that accesses a
>> kernel-maintained structure via a syscall - the layout of the kernel
>> structure is (properly) defined in a header in linux/include/asm - but you
>> also need to get at it when compiling the user-land program.
>
> In this case you should ship the corresponding header files that your
> user space program uses with that user-space utility.  This makes sure
> that it gets things right and doesn't depend on having a kernel tree
> around that you know the location of.  For example, for a program I'm
> working with, which uses an ioctl interface on a /dev entry (used to
> use system calls, but switched), I've set up a directory tree like:
> src    all the code
> include
>     linux  header files copied from the kernel tree (just the ones I
>            need)
>     other header files
>
> This way, when autoconf places a -Ibuild_root/include with each
> compile, it uses the local header files.
>
> Before I did this, building was hell -- it's SO much better being able
> to build the user-space code on any box without having to untar kernel
> source.
>
> Again, just my opinion, but I've found that this works very well.
>
> I believe in general, unless the program you're writing needs to track
> the kernel very closely, it's bad practice to include kernel headers
> in user-space code.

Well, the user space prog. (posting due in about an hour ;-) is mainly for
kernel/driver developers so they would naturally need to track the two
together - I'm entirely in agreement that it is a bad idea to have general
user programs that require kernel sources :-)

Thanks,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
