Date: Thu, 9 Mar 2000 10:45:21 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.48 hang on starting init?
In-Reply-To: <200003090638.HAA00445@piglet.grunz.lu>
Message-ID: <Pine.HPX.4.10.10003091039110.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

> Yet another quirk I've found with 2.3:
>
> Sometimes, when booting, the kernel would hang just after freeing init
> kernel memory, before starting init.
>
> I've booted 4-5 times now without a problem, but it seems to happen
> every time when the root partition is not marked as clean (i.e. after a
> crash).

I saw something similar with 2.3.4x up to 2.3.45, then I could not test
later versions because they would not boot with root on NFS. The pattern
was that a shutdown -r would always hang but it would work if power was
cycled for some mysterious reason. This was solved this by clearing all
free memory in my bootloader (on MVME2400/MVME2600 boards).

Now I'm happily running 2.3.50 (Linus'tree with some patches available on
my ftp server) without any problems, but I did not try to remove my hack.

> It seems to be related either to init not starting, or to the kernel
> not being able to deal with the non-clean root partition. The problem
> appears way before fsck gets a chance at the partition.

Since I was exclusively testing wit hroot on nfs, non clean rooot
partition is not an option ;-)

> Anybody seen something similar? Any idea what I should look at?
>
> Hmmm, my init is 2.74 from my old R4 install; maybe I should give R5 or
> 2000 a try?

I'm using init from R5.

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
