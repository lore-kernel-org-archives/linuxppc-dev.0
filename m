Subject: Re: Kernel Gurus: Module insertion deadlock? [Was: SCSI system
	freeze w/2.4.18]
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Albrecht Dre? <albrecht.dress@arcor.de>
Cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020407143312.GA927@regulus>
References: <E16tZUq-00007a-00@piglet.grunz.lu>
	<20020407143312.GA927@regulus>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Apr 2002 00:32:29 +0200
Message-Id: <1018218750.1868.772.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2002-04-07 at 16:33, Albrecht Dre? wrote:
>
> I played a little more with this, and got the following picture:
>
> * scsi cd support built into the kernel: the access works without a cd in
>    the drive
>
> * scsi cd support built as module
>    - do a "modprobe sr_mod" (which inserts sr_mod.o and cdrom.o): access
>      works like support built fixed into the kernel;
>    - remove sr_mod (cdrom.o may still be loaded): access leads to the hang as
>      described.
>
> So I think there is some kind of deadlock between dd and the module
> insertion (which includes a disk access to read/load the module). As I do
> not see this on an iMac with a ide cd drive, it might be a problem either in
> sr_mod or in the scsi stuff. However, the iMac has two separate ide busses
> for the cd and the disk, so the hang might be "same bus" related.

Indeed, I've experienced the same problem on a Cube where both HD and CD-ROM
are on the first IDE bus. Used to work before around 2.4.10, don't remember
exactly.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
