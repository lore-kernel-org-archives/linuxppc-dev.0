Message-ID: <3A6854DD.A370D56B@matrox.com>
Date: Fri, 19 Jan 2001 09:53:18 -0500
From: Sébastien Côté <scote1@matrox.com>
MIME-Version: 1.0
To: mgreer@mvista.com
CC: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com> <3A6794B1.D0B70C1C@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:
>
> Where did you get this version of that kernel?  From the MontaVista CDK or from
> the website?  If from the website, when did you get it?

I'm pretty sure it came from the web..  I think it was downloaded at the
end of November but I can't be sure...  I could probably answer this
next week.

> Try this (if its not already done).  Go into arch/ppc/boot/head.S and add the
> following lines after the set up of r6 to hold the cmd_line.
>
>         /* r4,r5 have initrd_start, size */
>         lis     r2,initrd_start@h
>         ori     r2,r2,initrd_start@l
>         lwz     r4,0(r2)
>         lis     r2,initrd_end@h
>         ori     r2,r2,initrd_end@l
>         lwz     r5,0(r2)
>
> Go into arch/ppc/kernel/sandpoint_setup.c.  Find sandpoint_setup_arch() and add
> something like (again, if its not already there).
>
>      #ifdef CONFIG_BLK_DEV_INITRD
>              if (initrd_start)
>                      ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
>
>        #endif
>

I tried that patch that I found in the list archives but it didn't make
any difference.


Sébastien Côté

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
