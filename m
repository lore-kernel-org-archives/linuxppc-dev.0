Message-ID: <38221d223825dd81@andira.wanadoo.fr> (added by andira.wanadoo.fr)
Date: Fri, 05 Nov 1999 00:48:52 +0100
Subject: Re : Newworld OF boot
From: "Florent" <flobo@iname.com>
To: Ethan Benson <erbenson@alaska.net>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Has anyone succeeded in booting newworld macintoshes (ie the iMac or the B&W
>>G3) using OF ?
>
> no
>
>>I'm
>>sure there is a way to turn around.
>
> yup, we need a elf version of quik that works, then we can stick that
> on a tiny partition and not have to use msdosfs or hfs for the root
> filesystem
[...]
> let me know if you find out anything else, I want to fix this issue
> but it seems that everyone else just want to use bootx for eternity.
> it would be nice if you could find a way to make OF load a bootblock
> as that would be cleaner then a partition, if you can write code then
> perhaps fix the quik second stage loader (elf version) to work
> properly (it loads now but just says an error because it does not
> expect to be loaded like that)

I'm currently working on the second stage loader (version 2.0.0a). When it
is launched from OF, it detects the machine as a CHRP and fixes the root
partition as the second one (this part of the code seems to be a quick add).

Things I've changed :
-in main.c line 353: replaced fip->conf_part = 2; with my root partition
number.
-in disk.c line 59 : sprintf(bootdevice, "disk:0"); replaced disk:0 with hd
(or ultra0) to match the blueg3 firmware's aliases names.

Now it works better, but it fails when it tries to open /etc/quik.conf (call
to ext2fs_open() in file.c) : I get a Default Catch error and OF breaks.

Since the second stage loader relies on OF for raw disk access, and that
doesn't seems to work with newworld's OF, i think it will never boot this
way.
I think that there is no way else than make an OF-readable partition
containing the kernel and an elf program to load it...

I must boot MacOS to boot Linux, then I modify and compile quik, then I
reboot my computer to test it with OF, then it crashes, then I reboot under
MacOS, then Linux... I'm fed up with rebooting.


--
Il est maintenant temps de clore votre connection et de reprendre une vie
normale.
Mon e-mail : FloBo@iName.com (Florent Boudet)
Mon e-mail secondaire : FloBo@Rocketmail.com (je ne le regarde jamais)
Mon QG : http://www.multimania.com/flobo/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
