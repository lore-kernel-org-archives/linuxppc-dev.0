Message-ID: <4046697E.1090003@sonartech.com.au>
Date: Thu, 04 Mar 2004 10:25:50 +1100
From: David Gardiner <daveg@sonartech.com.au>
MIME-Version: 1.0
To: "Hager, Johannes, HRD/AB" <johannes.hager@lfk.eads.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Some questions regarding - ppcbug booting
References: <2D9AB865A49FD511914700105A0EF679016C48EF@morse.smart.lfk.eads.net>
In-Reply-To: <2D9AB865A49FD511914700105A0EF679016C48EF@morse.smart.lfk.eads.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hager, Johannes, HRD/AB wrote:

>I´m working on a similar project, but my problem is, that I can´t
>get the kernel, I´ve compiled, working. How do I have to compile the
>kernel/which options do I have to set, that it can be started with
>motorolas PPCBug? Which commands do I have to use to boot the Kernel
>with the PPCBug. Until now I used NBO, but I always got an error
>message! I am using the MVME3604 board.
>
>>-----Ursprüngliche Nachricht-----
>>Von:	David Gardiner [SMTP:daveg@sonartech.com.au]
>>Gesendet am:	Mittwoch, 25. Februar 2004 00:25
>>Betreff:	ppcbug booting
>>
>>I'm currently running Linux system (linuxppc_2_4 from monta vista,
>>thanks to all those who have worked on it) that comprises of a
>>motorolla mvme5100 that has a promise ide pmc with a compact flash and
>>was hoping to get the compact flash to hold the entire OS+kernel ...
>>At the moment the system can be booted via nfs / prep boot (if running
>>with a scsi disk) and bugboot. But what I was hoping to do was boot
>>of a kernel on the compact flash. My assumption is that using u-boot
>>to do this would be a heavy handed approach (please point out if I'm
>>wrong) and I haven't seen anything in my googling. Has anyone ever
>>tried anything like this? if not can I please get some pointers on the
>>best way to go about this.

Maybe a bit of broad question but I'll try to answer some bits,mainly
the ppcbug

To ppcbug boot, I use the bugboot kernel which when compiled is at:
arch/ppc/boot/images/zImage.bugboot
it is just the normal kernel wrapped up with some extra bits, which is
done by a binary found in:
linux/arch/ppc/boot/utils/mkbugboot

To get this onto the machine, in ppcbug I setup niot to tftpboot the
kernel image onto the machine, to the location specified by:
Boot File Load Address         =
which is done using:
nbh

I then pflash(which is basically a copy) this to a different location:
i.e. pflash from:(from+lgth) to

I then use ppcbug's env command to set it to rom boot the kernel,
the bits, I know you have to change are:
Network PReP-Boot Mode Enable [Y/N] = N
ROM Boot Enable [Y/N]            = Y?
and the address,
ROM Boot Direct Starting Address = ....
is the address that you pflashed the kernel to

ps: the addresses that I use have been left out purposly (as they might
not be right for your machine) and I would like to note it's pretty easy
to stuff up a machine using the ppcbug if you use the "wrong" addresses
(speaking from experience).

also take a look at Mat Porters, description which is at:
http://www.debian.org/ports/powerpc/inst/prep

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
