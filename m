Message-ID: <20020904144021.93425.qmail@web9502.mail.yahoo.com>
Date: Wed, 4 Sep 2002 07:40:21 -0700 (PDT)
From: Pete McCormick <pete261@yahoo.com>
Subject: RE: Linux on 8260 using ELDK..Help?!? 
To: Flavio Pereira <fpereira@azisa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1E354700654661418593A0D6B5A9D410A3618E@mail.azisa.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Flavio,

What do your file permissions look like on /dev/ttyS0?  Do you have read and
write access enabled?

Pete

P.S.  I am also using the linux 2.4.18 kernel on the MPC8260ADS board, so I
might be able to help on further issues...

--- Flavio Pereira <fpereira@azisa.com> wrote:
>
> Hi Wolfgang
>
> Firstly let me say thanks for your response.
>
> >Did you fix the IMMR mapping in PPCBoot? The  CFG_DEFAULT_IMMR  defi-
> >nition  will  NOT  work with LInux; see the Linux memory map require-
> >ments - You _must_ map the IMMR at 0xF0000000 or above.
>
> Yes I have fixed to IMMR mappings in PPCBoot to correspond to 0xF0000000
>
> > Are you sure this was done well?
>
> Well _no_ I'm not sure this was done well but I can tell you exactly
> what I have done. For uart.c I've completely removed SMC1 and SMC2 from
> serial_state rs_table and rs_brg_map[]. If I don't remove this my serial
> port does not come up at all initially. For tty_io.c I simply to do not
> call rs_8xx_init because it kills my serial port, i.e. if I let it this
> code execute there is no more output on my serial terminal.
>
> > Did you run the ELDK_MAKEDEV and ELDK_FIXPERM scripts as documented?
> I've run ELDK_MAKEDEV, so the dev/console file does exist and I've also
> run ELDK_FIXOWNER. I'm guessing that FIXOWNER = FIXPERM.
>
> Also in my var\log\messages I get the following...so init is trying to
> execute:
>
> Dec 31 19:00:13 192 kernel: Warning: unable to open an initial console.
> Dec 31 19:00:13 192 /sbin/mingetty[133]: /dev/ttyS0: Operation not
> permitted
> Dec 31 19:00:06 192 rc.sysinit: Mounting proc filesystem:  succeeded
> Dec 31 19:00:06 192 sysctl: net.ipv4.ip_forward = 0
> Dec 31 19:00:06 192 sysctl: net.ipv4.conf.all.rp_filter = 1
> Dec 31 19:00:07 192 sysctl: error: 'net.ipv4.ip_always_defrag' is an
> unknown key
> Dec 31 19:00:07 192 sysctl: error: 'kernel.sysrq' is an unknown key
> Dec 31 19:00:07 192 rc.sysinit: Configuring kernel parameters:
> succeeded
> Dec 31 19:00:07 192 date: Wed Dec 31 19:00:06 EST 1969
> Dec 31 19:00:07 192 rc.sysinit: Setting clock : Wed Dec 31 19:00:06 EST
> 1969 succeeded
> Dec 31 19:00:07 192 swapon: swapon: cannot open /etc/fstab: No such file
> or directory
> Dec 31 19:00:07 192 rc.sysinit: Activating swap partitions:  failed
> Dec 31 19:00:07 192 rc.sysinit: Setting hostname 192.168.1.246:
> succeeded
> Dec 31 19:00:10 192 rc.sysinit: Checking filesystems succeeded
> Dec 31 19:00:10 192 fsck: Checking all file systems.
> Dec 31 19:00:10 192 rc.sysinit: Mounting local filesystems:  failed
> Dec 31 19:00:10 192 fsck: WARNING: couldn't open /etc/fstab: No such
> file or directory
> Dec 31 19:00:10 192 mount: can't create lock file /etc/mtab~62:
> Permission denied (use -n flag to override)
> Dec 31 19:00:11 192 rc.sysinit: Enabling swap space:  succeeded
> Dec 31 19:00:11 192 init: can't open(/etc/ioctl.save, O_WRONLY):
> Permission denied
> Dec 31 19:00:13 192 /sbin/mingetty[134]: /dev/ttyS0: Operation not
> permitted
> Dec 31 19:00:11 192 init: Entering runlevel: 3
> Dec 31 19:00:14 192 /sbin/mingetty[135]: /dev/ttyS0: Operation not
> permitted
> Dec 31 19:00:14 192 /sbin/mingetty[136]: /dev/ttyS0: Operation not
> permitted
> Dec 31 19:00:14 192 /sbin/mingetty[137]: /dev/ttyS0: Operation not
> permitted
> Dec 31 19:00:14 192 /sbin/mingetty[138]: /dev/ttyS0: Operation not
> permitted
> Dec 31 19:00:14 192 /sbin/mingetty[139]: /dev/ttyS0: Operation not
> permitted
> Dec 31 19:00:14 192 /sbin/mingetty[140]: /dev/ttyS0: Operation not
> permitted
>
> Regards,
> Flavio
>
> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de]
> Sent: Wednesday, September 04, 2002 3:41 PM
> To: Flavio Pereira
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Linux on 8260 using ELDK..Help?!?
>
> Dear flavio,
>
> in message <1E354700654661418593A0D6B5A9D41008943B@mail.azisa.co.za> you
> wrote:
> >
> > I'm a _newbie_ to Linux and am busy porting Linux to a MPC8260ADS
> > board. PPCBoot is working fine and the Linux kernel seems to boot up
> > okay up and till the point where it begins to load init, it then
> > crashes. The trace is shown below. I've also tried forcing sh and
>
> Did you fix the IMMR mapping in PPCBoot? The  CFG_DEFAULT_IMMR  defi-
> nition  will  NOT  work with LInux; see the Linux memory map require-
> ments - You _must_ map the IMMR at 0xF0000000 or above.
>
> > bash as the start-up but these also fail with similar errors. I'm
> > using the binaries provided by the ELDK development package. Also my
> > changes to the base kernel code (2.4.4) are minimal and are limited
> > to uart.c (force SCC1 as serial port) and tty_io.c (don't call
> > rs_8xx_init). Can anyone please point me in the right direction...?
>
> Are you sure this was done well?
>
> > If the information above is not sufficient please let me know what
> > more I could provide. Something tries to restart the system and then
> > it crashes on trying to reboot. Someone please tell me what I should
> > be looking at?
>
> ...
> > Freeing unused kernel memory: 52k init
>
> Looks good so far.
>
> > Warning: unable to open an initial console.
>
> Did you run the ELDK_MAKEDEV and ELDK_FIXPERM scripts as documented?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> In C we had to code our own bugs, in C++ we can inherit them.
>
>

Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
