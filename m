Subject: Re: [YABOOT] Preliminary ofpath with 2.6 kernel support NEEDS TESTING
From: digger vermont <digver@verizon.net>
To: Ethan Benson <erbenson@alaska.net>
Cc: yaboot-users@lists.penguinppc.org,
	yaboot-devel@lists.penguinppc.org,
	Debian-powerpc <debian-powerpc@lists.debian.org>,
	Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>,
	yellowdog-general@lists.terrasoftsolutions.com,
	yellowdog-devel@lists.terrasoftsolutions.com,
	g5-test@lists.terrasoftsolutions.com
In-Reply-To: <20040322023536.GB21226@plato.local.lan>
References: <20040322023536.GB21226@plato.local.lan>
Content-Type: text/plain
Message-Id: <1080017723.2066.17.camel@myrna>
Mime-Version: 1.0
Date: Mon, 22 Mar 2004 23:55:24 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Ethan,
	The new ofpath gives the same dir's for 2.4.25 and 2.6.4.  It works
fine to boot linux and macosx on my powerbook.  I didn't try a cd.  I
never had any problems though and yaboot.conf used /dev/xxx statements
to begin with:

boot=/dev/hda9
device=hd:
partition=11
root=/dev/hda11
timeout=30
install=/usr/lib/yaboot/yaboot
magicboot=/usr/lib/yaboot/ofboot

macosx=/dev/hda16

/proc/cpuinfo

processor       : 0
cpu             : 7455, altivec supported
clock           : 667MHz
revision        : 2.1 (pvr 8001 0201)
bogomips        : 665.60
machine         : PowerBook3,4
motherboard     : PowerBook3,4 MacRISC2 MacRISC Power Macintosh
detected as     : 73 (PowerBook Titanium III)
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 512MB
pmac-generation : NewWorld

Thanks,

digger

On Sun, 2004-03-21 at 21:35, Ethan Benson wrote:
>
> As many are painfully aware ofpath in current yaboot does not function
> correctly under 2.6 systems, worse case it gives out bogus paths
> therefore causing the system to fail to boot.
>
> I have preliminary changes in current development version of yaboot
> which fixes ofpath to support 2.6.4 and above kernels.
>
> I need everyone with 2.6.4 or newer systems to test this version of
> ofpath and verify that it produces correct OpenFirmware paths to your
> devices (compare with ofpath output from a recent 2.4 kernel (2.4.23
> or newer))
>
> Prerequisites:
>
> * You must have 2.6.4 or newer, previous versions lack necessary sysfs
>   information.
>
> * You must have sysfs mounted (normally on /sys, but ofpath should be
>   able to detect where its mounted).
>
> * You must still have /proc/ide so if this becomes a configurable
>   option like /proc/scsi you must have it enabled (/proc/scsi is also
>   required for machines with SATA drives).
>
> The easiest way to test the new ofpath is download the current version
> from http://penguinppc.org/~eb/files/ofpath and install it manually:
>
> as root enter:
>
> 	which ofpath
>
> this will return the path of the active ofpath program, probably
> /usr/sbin/ofpath
>
> move it to safe place:
>
> 	mv `which ofpath` /root
>
> install the new version (put it in the same place as the old one was,
> see step 1):
>
> 	install -m 755 /home/youruser/ofpath /usr/sbin/ofpath
>
> run ofpath on all your disk devices and ensure its output is correct.
>
> then comment out any ofboot= lines in /etc/yaboot.conf and change your
> macos* entries back to /dev/ nodes, run ybin and ensure the bootloader
> functions correctly.
>
> MOST IMPORTANTLY:
>
> 	* REPORT SUCCESS *AND* FAILURE *
>
> I want to know what kind of machine you have, and that ofpath worked
> correctly, I will release yaboot 1.3.12 once I have enough success
> reports for enough differing machines, very new machines are most
> important, as they are the ones which old ofpath failed on.
>
> Thanks in advance, and thanks to Nick Lopez for granting me local
> shell access to his machine so I could get this done.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
