Date: Sat, 11 Nov 2000 13:43:38 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: booting with quik off hard disk on 7220
Message-ID: <20001111134337.A4931@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

well I got past the problem with the video mode thanks to ethan benson's
suggestions of using a hex editor to set vmode.

Anyway the problem I now have is that I cant get the machine to boot off
hard disk with quik. (BootX worked when I used the machine with macos and
ydl, however I wanted to get rid of macos now I have debian)

I have the quik.conf
partition=6
root=/dev/hda6
timeout=1
image=/boot/vmlinux-2.2.17
label=linux
read-only
append="video=atyfb:vmode:6"

the only real change from the quik.conf deb install generated is I added the
append line and I changed the image to point to /boot/vmlinux-2/2/17 rather
than /vmlinux as I read in a post ethan benson wrote to debian-powerpc (in
the archive somewhere) saying that symlinks are not reliable with quik on
these computers.

I have got a debian base install on the machine now but cant continue with
the install as I am still booting off the hfs debian boot floppy and root
floppy.

So I have a file I run when i boot off floppy that does some nvsetenv stuff
this is
nvsetenv boot-device ata/ata-disk@0:0
nvsetenv input-device kbd
nvsetenv output-device screen
nvsetenv boot-file ' /boot/vmlinux-2.2.17 root=/dev/hda6'
quik

the boot device seems to be correct, although that ofpath script when I run
./ofpath /dev/hda reports "This machine is not suhpported: AAPL,e826"
I looked through /proc/device-tree myself and the ata and ata-disk things
are there where it seems they should be.

I dont get output from OF on this machine when I enter OF at bootup (7200
dont get OF display or something) but if I dont set the input and output
device I dont see anything from quik, when they are set I see the grey
screen for the quik second stage loader.

If I dont have the boot-file set quik asks me every time to enter the
boot-file argument. I have the space infront of /boot as I read in some post
to debian-powerpc that the 7200 series needed the space there.

the partition map for the machine has hda[1234] as the apple partitions for
drivers and such. Then it has Swap on hda5
/dev/hda5 Apple_UNIX_SVR2 Swap 262144 @ 704 (128.0M) Linux Swap
and / on hda6
/dev/hda6 Apple_UNIX_SVR2 Linux_Root 2097152 @ 262848 ( 1.0G) Linux Native

and then some free space after that.

Now when I boot up I get the quik second stage loader and it has a spinning
| / - \ thing briefly and then the screen goes entirely blank wnad there is
no hard disk activity or anything.

I am wondering how to get the machine to boot.

I have seen in many places mentions of the 7200 with scsi not spinning the
disks up fast enough for booting and the quik boot fails, so there are small
scripts to make it wait around on maling lists, however I have seen mention
of the fact this only affects scsi and that ide doesnt have the slow spin up
problem. So for now I have discounted that as being the cause.

I am guessing I may need to get a serial cable link up to have a look and
play around in OF to get this running. (unless someone can tell me how to
get it running with out this) Though it would be good to be able to see OF I
suppose and thus I am wondering what cables I need to hook up the little
round modem or printer port on the back of the machine to an x86 box, I have
a null modem cable and all, but not something that will speak to the little
modem or printer ports on the mac. I saw the details in some list post
yesterday arvo but didnt make a note of it and now cant find that post again
searching for likely keywords on google.

I am using google a lot more than the new search capability on debian
mailing lists it seems as the debian mailing list searcher seems to return
no matches more often than not for most searches. And yet I find those same
things often when reading through the debian powerpc archives manually.
Alas...

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
