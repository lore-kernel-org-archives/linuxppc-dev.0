Message-ID: <4016F657.8020706@246tNt.com>
Date: Wed, 28 Jan 2004 00:37:59 +0100
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on a Motorola MPC5200 ?
References: <20040127191442.3B541C108D@atlas.denx.de>
In-Reply-To: <20040127191442.3B541C108D@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

>>well, their 'special DMA fancy stuff' ;) ), ATA, DDR, I2S, AC97 mainly.
>>
>>
>
>ATA: OK as long as you don't enable DMA writes (*)
>
>
>
Are DMA Read supported ? ( I mean possible to just use DMA for the reads
? My application is about 95 % reads ;)
What's the performance impact ?

>DDR: OK (use icecube_5200_DDR configuration in U-Boot); the LOWBOOT
>     option is not working yet (we are working on this)
>
>I2S: simultaneous reading and writing is impossible (*)
>AC97: ditto
>
>
>
Ok, not a problem for me I only do audio out.
But just in case, if I do In and Out on different PSC, does this works ?

>(*) to fix these issues we're waiting for a  bugfix  release  of  the
>    BestComm CAPI which might become availabe by mid February.
>
>
Cool !

>> - I'd really like to run a 2.6 kernel on it. If it's not yet ported to
>>
>>
>
>Forget it. Why would you want to  do  that?  Which  features  do  you
>expect from 2.6 which are not available in 2.4?
>
>
>
>
Well things like *:
 -  Pluggable I/O Scheduler
 -  Kernel preemption
 -  Better IPSec / Encryption support
 -  udev stuff ( in fact userspace but may depend on some kernel
interface, have to check. Primarly done for the 2.6 AFAIK )
 -  Native ALSA

And also because when I start a new project I like to use "new" stuff ;)
That's were a majority of new nifty features are ...



(*) I'm not sure they are all only and 2.6 and not backported/already in
2.4, I have to check.

>Our current stuff is on our CVS  server,  in  the  linuxppc_2_4_devel
>tree.  As  far  as the 5200 is concerned this includes stuff that was
>submitted but not yet added to the linux-2.4-mpc5xxx  tree  (but  Tom
>promised to add our patches).
>
>
>
I've just downloaded it but ran into a problem when compiling the kernel
with the icecube default config.

In arch/ppc/boot/common/misc-simple.c :
 - the decompress_kernel routine is used before being defined/declared
 - the decompress_kernel defined there takes 3 args, the one used in
load_kernel func ( same file ), gives 4 args to it ...


Sylvain Munaut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
