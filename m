Message-ID: <3ED517C5.1050102@mrv.com>
Date: Wed, 28 May 2003 22:10:45 +0200
From: Eran Mann <emann@mrv.com>
MIME-Version: 1.0
To: "Brian S. Park" <brian@corelis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: getting Linux working on IBM Walnut demo board
References: <5.1.1.6.2.20030527160449.0128b868@corelis.com> <Your message of "Tue, 27 May 2003 11:49:51 PDT." <5.1.1.6.2.20030527114004.01282240@corelis.com> <5.1.1.6.2.20030527160449.0128b868@corelis.com> <5.1.1.6.2.20030528113157.012b1008@corelis.com>
In-Reply-To: <5.1.1.6.2.20030528113157.012b1008@corelis.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian, see some suggestions below.

Brian S. Park wrote:

> Now to the next problem. I'm booting with NFS root file system. Below
> is the bootargs that I'm using.
>
> >bootargs=root=/dev/nfs rw nfsroot=192.168.1.78:/home/ELDK/ppc_4xx
> console=ttyS0,115200
> >              console=tty0
> ip=192.168.1.146:192.168.1.78:192.168.1.2:255.255.255.0:netusb::off
>
> exports file on my development station has
> >/home/ELDK/ppc_4xx      netusb(rw,no_root_squash)
>
> /home/ELDK/ppc_4xx is where ELDK installed the target file system on
> my development machine.
> Even though I can now ping the target, I can't telnet to it. I get the
> following error.
>
> >telnet netusb
> >Trying 192.168.1.146...
> >Connected to netusb.
> >Escape character is '^]'.
> >telnetd: All network ports in use.
> >Connection closed by foreign host.
>
> Is this normal? Do I now need to configure the target file system to
> enable telnet?
> Or is there still something wrong with my bootargs?

It's not normal. Perhaps it's a problem with inetd or xinetd
configuration? is there any more information in the logs or in dmesg
(well, once you get a working console..)?

> Also, after the kernel comes up, I can no longer type any command
> through the serial terminal.
> The following the message at the end of kernel boot. It says it was
> unable to open the console.
>
> >IP-Config: Complete:
> >      device=eth0, addr=192.168.1.146, mask=255.255.255.0,
> gw=192.168.1.2,
> >     host=192.168.1.146, domain=, nis-domain=(none),
> >     bootserver=192.168.1.78, rootserver=192.168.1.78, rootpath=
> >NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> >Looking up port of RPC 100003/2 on 192.168.1.78
> >Looking up port of RPC 100005/1 on 192.168.1.78
> >VFS: Mounted root (nfs filesystem).
> >Freeing unused kernel memory: 76k init
> >Warning: unable to open an initial console.

Perhaps you dont have a proper /dev/ttyS0 device in the nfsroot?

>
> Any help will be appreciated.
>
> Thank you
>
> Brian
> ===============================================================
> Brian S. Park  brian@corelis.com  (562) 926-6727 x143
> ---------------------------------------------------------------
> Everything we do helps our customers get to market
> FASTER with HIGHER quality and LOWER cost
> ===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
