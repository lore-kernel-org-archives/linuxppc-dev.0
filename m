Date: Tue, 5 Mar 2002 10:12:09 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: problems with smbfs on 2.4.18 kernel (ppc)
In-Reply-To: <1015293079.1830.55.camel@dozo>
Message-ID: <Pine.LNX.4.33.0203050945100.21791-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 5 Mar 2002, Bastien Nocera wrote:

> On Sun, 2002-03-03 at 17:28, Urban Widmark wrote:
> >
> > Has smbfs worked for you with previous versions? A patch was added late to
> > 2.4.18 and it has caused a lot of crashes for people. I don't think it is
> > related, but since you mention 2.4.18 ...
>
> I never tried the previous versions of it.

Maybe you should.

> $ cat /proc/mounts  | grep smb
> //kara/Backup1 /mnt/backup smbfs rw,file_mode=0755,dir_mode=0755 0 0
>
> It seems to be mounted. dmesg says:
> smbfs: Unrecognized mount option noexec

Does it make any difference if you mount it like:
mount -t smbfs -o username=...,password=... //kara/Backup1 /mnt/backup

(should stop the "Unrecognized mount option" error)


> > The entry in mtab is written by smbmnt and one way to get this would be if
> > the mount fails, but after smbmnt has written and then for some reason it
> > fails to cleanup.
>
> smb definetaly works, as I can browse it with the smb gnome-vfs module,
> as well as smbclient. I'm failing to see why the /mnt/backup directory
> just "disappears from there".

It can disappear if the request for attributes on that directory fails.
Try getting a network trace with ethereal and see what the response to the
QUERY_PATH_INFORMATION request is.

/Urban


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
