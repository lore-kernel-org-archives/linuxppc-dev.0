Message-Id: <199906160420.VAA02733@magpie.prod.itd.earthlink.net>
Subject: Re: PRAM problem with the latest B&W G3s?
Date: Tue, 15 Jun 1999 21:20:46 -0700
From: "Conrad M. Hirano" <c.hirano@pobox.com>
To: "Kevin Puetz" <puetz@penguinpowered.COM>,
        <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I just got my hands on a 450 MHz B&W G3 and have run into problems
>> trying to install Linux. I'm wondering if Apple made some changes to the
>> PRAM which cause an incompatibility with Linux or BootX because of the
>> symptoms I see.
>>
>> First, I noticed that Techtool no longer reports the date of manufacture
>> or the number of hours the computer has been in use. It just lists "N/A"
>> for both. Apparently, Apple has changed the PRAM in some way.
>>
>> Second, the kernels for both R4, for the B&W G3, and R5, from the
>> installer, do not successfully let me get to the respective installers.
>> After the system hangs, it will not successfully boot the Mac OS off the
>> hard disk or the CD until I reset the PRAM. It begins to load the Mac OS
>> and the BootX window appears, but after I dismiss the window, it hangs
>> before the extension icons appear at the bottom of the screen. I've also
>> tried booting with no extensions, and the system still hangs.
>
>You can't OF-boot these machines - You have to use BootX, and you have to
>use the kernels from that are labeled for the blue&white G3's in the kernels
>folder of LinuxPPC 1999. They contain some unmerged patches that make them
>work.
>
>If the extension form of BootX is not working, try the application. I have a
>freind with a B&W G3/300 that works real nice ;-)

I wasn't trying to OF-boot; I was using BootX with one of the kernels for 
the B&W G3s. Initially, I thought there was some sort of problem with the 
kernel corrupting the PRAM because after resetting the system, the system 
still wouldn't boot the Mac OS successfully until I reset the PRAM. It 
turned out that something else just wasn't getting reset when I restarted 
the system. I later found that if I powered the system down completely, 
then the system would successfully boot the Mac OS on the next try. There 
was no need to reset the PRAM.

It appears that there's still a problem with IDE DMA. The kernel fails 
during the partition check with a DMA time-out. Someone who ran into the 
same problem as I did solved the problem by plugging the hard drive into 
the other IDE connector on the motherboard. When you do this, you see in 
the kernel messages that the hard drive is accessed using polled I/O 
rather than DMA. Because the kernel is no longer using DMA, the problem 
goes away and the system successfully boots.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
