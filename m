Message-ID: <3BC497A8.9AE64225@mvista.com>
Date: Wed, 10 Oct 2001 13:47:04 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Root login...
References: <35C119252057D511BB9F0003476BF8A208E5E2@freexc01.smartm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Prasad, Siva" wrote:
>
> I used HHL Journeyman 2.0 PPC 7xx to build ramdisk for our custom PPC 750
> board. When I try to execute, it gives the login prompt. But when I type
> 'root' and hit enter, it gives me back login prompt again. Basically it is
> not logging in.
>

It looks like you are missing /bin/login.  Assuming the initscripts
started up properly, take a look at the various logs in "/var/log" and
you should see an error message from getty explaining what is wrong.

Once you add in /bin/login, you will need the pam shared lib,
/etc/pam.d/login and the assorted pam "module" (/lib/security/pam_*) for
what is specified in /etc/pam.d/login.

However, if you don't care about security then you can just create a
file /etc/pam.conf with the following:

# Permit an open system [Dangerous!]
other   account         required        pam_permit.so
other   auth            required        pam_permit.so
other   password        required        pam_permit.so
other   session         required        pam_permit.so

And make sure that you copy /lib/security/pam_permit.so

--Mark


> /bin
> bash cat cp date echo ls mount ping ps sh stty umount
>
> /dev
> console ram0 tty ttyS0
>
> /sbin
> fsck getty halt ifconfig init insmod lsmod modprobe reboot shutdown sulogin
>
> /etc
> fstab (with /dev/root, /dev/ram0 and /proc)
> passwd
> group
> inittad (as is from HHL Journeyman)
> rc.d (as is from HHL Journeyman)
> init.d (as is from HHL Journeyman)
> default (as is from HHL Journeyman)
>
> and create few other directories...
> /root /proc /mnt /usr /tmp /var
>
> -- Siva
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
