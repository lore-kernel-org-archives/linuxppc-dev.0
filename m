Message-ID: <3DAA73C1.31FC2758@imc-berlin.de>
Date: Mon, 14 Oct 2002 09:35:29 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	dhinds <dhinds@sonic.net>
Subject: [Pcmcia-cs-devel]request/release region in ide-cs.c ???
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I have a problem regarding PCMCIA CS and ide-cs.c.
Please stay calm while I explain why I send this question to this list:

My CS with IDE seems to work fine. But I stumbled over the
request/release_region in
ide-cs.c:
Apparently release_region is called in ide_config() and request_region is called
in ide_release()!?!? Shouldn't it be the other way round?

After the first "insert"

root@dab4k_64937:~# cardctl insert
ide0 at 0x100-0x107,0x10e on irq 9
root@dab4k_64937:~# cat /proc/ioports

there's no (!) requested ioport. But after the first "eject":

root@dab4k_64937:~# cardctl eject
root@dab4k_64937:~# cat /proc/ioports
00000100-0000010f : ide-cs

Repeating insert/eject adds a requested region every time!!!

root@dab4k_64937:~# cardctl insert
ide0 at 0x110-0x117,0x11e on irq 9
root@dab4k_64937:~# cat /proc/ioports
00000100-0000010f : ide-cs
root@dab4k_64937:~# cardctl eject
root@dab4k_64937:~# cat /proc/ioports
00000100-0000010f : ide-cs
00000110-0000011f : ide-cs
root@dab4k_64937:~# cardctl insert
ide0 at 0x120-0x127,0x12e on irq 9
root@dab4k_64937:~# cat /proc/ioports
00000100-0000010f : ide-cs
00000110-0000011f : ide-cs
root@dab4k_64937:~# cardctl eject
root@dab4k_64937:~# cat /proc/ioports
00000100-0000010f : ide-cs
00000110-0000011f : ide-cs
00000120-0000012f : ide-cs

So for me this is a problem!!! The beast is eating up ioport resources!
Now I said I noticed that release_region is called in ide_config() and
request_region is called in ide_release(). When I swap this (as one might
expect) everything works fine!

root@dab4k_64937:~# cat /proc/ioports
root@dab4k_64937:~# cardctl insert
ide0 at 0x100-0x107,0x10e on irq 9
root@dab4k_64937:~# cat /proc/ioports
00000100-0000010f : ide-cs
root@dab4k_64937:~# cardctl eject
root@dab4k_64937:~# cat /proc/ioports
root@dab4k_64937:~# cardctl insert
ide0 at 0x100-0x107,0x10e on irq 9
root@dab4k_64937:~# cat /proc/ioports
00000100-0000010f : ide-cs
root@dab4k_64937:~# cardctl eject
root@dab4k_64937:~# cat /proc/ioports
root@dab4k_64937:~#

So I asked on Pcmcia-cs-devel mailing list and the Godfather himself answered:

dhinds wrote:
>
> On Thu, Oct 10, 2002 at 03:43:50PM +0200, Steven Scholz wrote:
> >
> > Could someone please explain to me why release_region is called in
> > ide_config() and request_region is called in ide_release()???
> > Shouldn't it be the other way round?
>
> The region is allocated for the socket in the PCMCIA core.  The ide-cs
> driver releases the region because the kernel IDE driver refuses to
> talk to the device if the IO region is already allocated.  After the
> IDE driver shuts down, we re-reserve the region so that the PCMCIA
> core can free it when it shuts down the socket.
>
> As for why this misbehaves on PPC, I'm not sure.  It would seem that
> the core code is not reserving (and freeing) the region as expected.
>
> -- Dave

???

So is PPC misbehaving? In which way? Why?

Is it a problem of PCMCIA CS (on PPC) or is it a general problem of
request/release_region on PPC?

BTW: I am using the kernel version of PCMCIA CS compiled into the kernel not as
modules...
(Kernel 2.4.19-rc3, pcmcia-cs-3.2.1)

Thanks a million!

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
