Subject: Re: problems with smbfs on 2.4.18 kernel (ppc)
From: Bastien Nocera <hadess@hadess.net>
To: Urban Widmark <urban@teststation.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.33.0203050945100.21791-100000@cola.teststation.com>
References: <Pine.LNX.4.33.0203050945100.21791-100000@cola.teststation.com>
Date: 01 May 2002 16:49:08 +0100
Message-Id: <1020268150.25255.195.camel@dozo>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I'm quite ashamed of the time it took me to gather the info, been
busy...

On Tue, 2002-03-05 at 09:12, Urban Widmark wrote:
>
> On 5 Mar 2002, Bastien Nocera wrote:
>
> > On Sun, 2002-03-03 at 17:28, Urban Widmark wrote:
> > >
> > > Has smbfs worked for you with previous versions? A patch was added late to
> > > 2.4.18 and it has caused a lot of crashes for people. I don't think it is
> > > related, but since you mention 2.4.18 ...
> >
> > I never tried the previous versions of it.
>
> Maybe you should.
>
> > $ cat /proc/mounts  | grep smb
> > //kara/Backup1 /mnt/backup smbfs rw,file_mode=0755,dir_mode=0755 0 0
> >
> > It seems to be mounted. dmesg says:
> > smbfs: Unrecognized mount option noexec
>
> Does it make any difference if you mount it like:
> mount -t smbfs -o username=...,password=... //kara/Backup1 /mnt/backup
>
> (should stop the "Unrecognized mount option" error)

It did, the error doesn't appear anymore

> > > The entry in mtab is written by smbmnt and one way to get this would be if
> > > the mount fails, but after smbmnt has written and then for some reason it
> > > fails to cleanup.
> >
> > smb definetaly works, as I can browse it with the smb gnome-vfs module,
> > as well as smbclient. I'm failing to see why the /mnt/backup directory
> > just "disappears from there".
>
> It can disappear if the request for attributes on that directory fails.
> Try getting a network trace with ethereal and see what the response to the
> QUERY_PATH_INFORMATION request is.

I'm seeing this in ethereal:
from laptop to SMB server: Transaction2 Request QUERY_PATH_INFORMATION,
Path: \
from SMB server back to laptop: Transaction2 Response
QUERY_PATH_INFORMATION, Error: Directory not found

However, smbclient seems to find it:

smbclient //kara/backup1 -U hadess
added interface ip=192.168.1.2 bcast=192.168.1.255 nmask=255.255.255.0
Password:
Domain=[IDORU] OS=[Unix] Server=[Samba 2.2.2]
smb: \> ls
  mp3s                                D        0  Wed Apr  3 06:38:08
2002

I'm running out of things to test...

Cheers

--
/Bastien Nocera
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
