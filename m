Date: Sat, 11 Nov 2000 15:27:02 +1100
From: Steven Hanley <sjh@svana.org>
To: Ethan Benson <erbenson@alaska.net>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: booting with quik off hard disk on 7220
Message-ID: <20001111152702.A5146@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20001111134337.A4931@wibble.net> <20001110180924.Q4577@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20001110180924.Q4577@plato.local.lan>; from erbenson@alaska.net on Fri, Nov 10, 2000 at 06:09:24PM -0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 10, 2000 at 06:09:24PM -0900, Ethan Benson wrote:
> > nvsetenv boot-file ' /boot/vmlinux-2.2.17 root=/dev/hda6'
>
> this is redunant, when you have a proper quik.conf you don't need the
> boot-file variable, in fact it seems to bork things up in my
> experience helping someone with a 7200.  i would null out the
> boot-file variable.

hmm so what should be in quik.conf instead? With my current quik.conf if I
dont have that variable set quik stops on the grey screen where the boot:
prompt is and asks me to enter a [device:][partno]/path which if I enter
device and boot-file vairable settings in will then boot into the blank
screen with no hard disk activity just like it does now.

> > quik
> >
> > the boot device seems to be correct, although that ofpath script when I run
> > ./ofpath /dev/hda reports "This machine is not suhpported: AAPL,e826"
> > I looked through /proc/device-tree myself and the ata and ata-disk things
> > are there where it seems they should be.
>
> yeah that is basically what ofpath does, would it be possible for you
> to give me temporary shell access so i could add support to ofpath for
> it?  if not i can ask you some questions and figure it out. more then
> likely its exactly the same as a 7200 or a 7300 but has a different
> compatible entry.

yeah happy to give you shell access to the machine as soon as I have debian
installed and working, I can take the computer and put it online somewhere
for a while.

> > I dont get output from OF on this machine when I enter OF at bootup (7200
> > dont get OF display or something) but if I dont set the input and output
> > device I dont see anything from quik, when they are set I see the grey
> > screen for the quik second stage loader.
>
> hmm im not sure i understand this...

oh well the grey screen with the second stage boot loader and the
boot: prompt for quik, this doesnt show up unless I set the output device,
the computer on power on or reboot without setting theoutput device after I
have done a command option p r just sits there with a black screen and no
disk activity (kind of like I am either in OF or have gotten past the quik
boot: prompt and have that blank screen there.)

> > If I dont have the boot-file set quik asks me every time to enter the
> > boot-file argument. I have the space infront of /boot as I read in some post
> > to debian-powerpc that the 7200 series needed the space there.
>
> really?  i have a friend booting a 7200 with no boot-file variable set
> and it boots just fine.  boot-file overrides /etc/quik.conf iirc.
>
> > the partition map for the machine has hda[1234] as the apple partitions for
> > drivers and such. Then it has Swap on hda5
>
> just a note you don't need all that driver crap with quik booting.

oh good, when I still had macos on the machine I thought it was probably
safer to leave it there, but now I dnt need bootx I wont need them anymore
either it seems :)

> > /dev/hda5 Apple_UNIX_SVR2 Swap 262144 @ 704 (128.0M) Linux Swap
> > and / on hda6
> > /dev/hda6 Apple_UNIX_SVR2 Linux_Root 2097152 @ 262848 ( 1.0G) Linux Native
>
> its better to name these `swap' and `root' respectivly as that is what
> the kernel actually looks for, but if you specify root= in quik.conf
> it doesn't really matter.

hmm okay well I shall try changing them anyway as there could be some need
for them to be set if quik is not interacting as well as it should with this
machine.

> > Now when I boot up I get the quik second stage loader and it has a spinning
> > | / - \ thing briefly and then the screen goes entirely blank wnad there is
> > no hard disk activity or anything.
>
> ah it sounds like its loading the kernel but the kernel is hanging.
> that is how my friends 7200 always failed with 2.2.15/16 kernels.

hmm, okay well I just tried a 2.2.18pre18 kernel I had compiled (that worked
on the machine with bootx) rsynced from paulus' stable tree a few days ago
and it also gave me a black screen and no disk activity.

I will try to track down a tarball of 2.2.10 (I believe there is still one
on ftp.linuxcare.com.au) and try it next and home it works. Will also try
the changing of the partition labels to swap and root.

> i think you just need an ordinary mac serial cable, like you use for
> printers and such, then use a comm program like minicom or Zterm if
> your stuck with MacOS on the other box.

hmm I dont have another mac around, I am wondering what sort of cables I
have to go to a cable place and ask for to have one I can hook up to a null
modem cable or something and speak to minicom on an x86 box.

Thanks

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
