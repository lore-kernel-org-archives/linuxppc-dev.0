Subject: Re: firewire in 2.4.21-ben2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: daRonin <daronin@digimerc.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.56.0307141313050.1861@daronin.digimerc.com>
References: <Pine.LNX.4.56.0307141313050.1861@daronin.digimerc.com>
Content-Type: text/plain
Message-Id: <1058261452.628.36.camel@gaston>
Mime-Version: 1.0
Date: 15 Jul 2003 11:30:52 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-07-14 at 21:19, daRonin wrote:
> Hi,
>
>   I just upgraded to 2.4.21-ben2 kernel. And I can't mount my firewire
> HDDs any longer.
>
>   These are the commands I am executing:
>
>   modprobe -k ieee1394
>   modprobe -k ohci1394
>   modprobe -k sbp2
>   modprobe -k raw1394
>   modprobe -k sd_mod
>   mount /dev/sda2 /mnt/fire
>
>   Judging by the logs everything seems to go fine up to inserting sd_mod.
> sbp2 module seems to see the device and such.
>
>   But after inserting sd_mod absolutely nothing happens. I tried rmmod'ing
> the modules and inserting them again, tried to switch the order around,
> etc. No luck...
>
>   After I reboot back in 2.4.20-ben10 everything works fine...

That's a change in the firewire layer, you have to trigger a scsi probe
yourself now. Either using the rescan-scsi-bus.sh script, or the scsiadd
command for example

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
