Message-ID: <3ED392E0.7060101@mvista.com>
Date: Tue, 27 May 2003 11:31:28 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Phill Treddenick <Phillip.Treddenick@colorado.edu>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem booting kernel on EP405
References: <1054052583.3ed390e734f93@webmail.colorado.edu>
In-Reply-To: <1054052583.3ed390e734f93@webmail.colorado.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Phill Treddenick wrote:
> Hi,
>   I am trying to run Monta Vista Linux PE 2.1 on an EP405 with Solaris 2.7 as
> the host.  When I boot the kernel on the EP405 though, I get a couple of boot
> error messages.  The kernel continues booting however and gets to a login
> prompt, if I try to login though it fails.  Can anyone provide me with
> information about the errors I'm getting.  Specifically, the "modprobe:
> modprobe: Can't locate module char-major-4" and the "mknod: `/dev/ptmx':
> Operation not permitted" errors.  I would like to know where I would find the
> char-major-4 module or why the kernel can't find it.  Here are the boot messages
> and a failed login attempt. Thanks guys.

You can safely ignore the modprobe message.. it's not an error bug really a
warning. Now for the other issue.. the mknod error and the unable to login.. See
below:

> IP-Config: Complete:
>       device=eth0, addr=128.138.189.65, mask=255.255.255.0, gw=255.255.255.255,
>      host=sme, domain=, nis-domain=colorado.edu,
>      bootserver=128.138.189.51, rootserver=128.138.189.51, rootpath=

> VFS: Mounted root (nfs filesystem).

> mknod: `/dev/ptmx': Operation not permitted

> login[82]: unable to change tty `/dev/console' for user `root'
>
> Unable to change tty /dev/console: Illegal seek

The above shows that you are NFS rooted.  On your NFS root, it was unable to
mknod /dev/ptmx.  Either you have a RO NFS export on your slowlaris box, or
somehow you are exporting a system in which you are unable to create device
nodes.  /dev/ptmx is required for the multi-user login to work.  It controls the
PTYs.

The second error if that it is unable to change the tty for /dev/console to
root.  This again indicates that there is a problem with device nodes over your
NFS mount.  Make sure the NFS mount is RW.

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
