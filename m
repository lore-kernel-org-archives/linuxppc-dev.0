Message-ID: <8D7C5F56B409554D9D46AC22195807F3061B6D@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'Chris Hallinan'" <clh@net1plus.com>, jeffrey.d.kowing@nasa.gov,
	Brian Waite <waite@skycomputers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: NFS root manipulation without being superuser?
Date: Sat, 16 Nov 2002 13:31:34 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I do this for all our developers they each have a target directory under
their home directory.  It is shared as rw no_root_squash you login as root
on the target but can only stuff up your home directory.
The target directory is created when I create a new user account.  This
works well for us.  We have about 12 developers using the same machine for
development and their target machines for testing.  The server does not have
to be reboot very often but sometime you get a rogue application.
We use the standard RH user groups if a user makes a stuff up in this target
directory then I chown it back to his user or copy from the skel directory
over the top and perform a chown.


Rod



 -----Original Message-----
From: 	Chris Hallinan [mailto:clh@net1plus.com]
Sent:	Friday, November 15, 2002 12:25 PM
To:	jeffrey.d.kowing@nasa.gov; Brian Waite
Cc:	linuxppc-embedded@lists.linuxppc.org
Subject:	RE: NFS root manipulation without being superuser?


Maybe this is just too simple, but I always have my target file
system under my home directory or under /opt with user:group ==
me:swdev, or something like that, and who cares what the target
thinks the user:group is, because I always login as root on my
target.  So, that way, I can do what you seek: 1) have the Power of
God on my own development workstation's 'target file system' to make
changes as I see fit, 2) not risk wiping out something on my
workstation (which I've done, yes :) and 3) modify the target fs
from my target, as well!

I *NEVER, NEVER, NEVER work routinely as root!  <grin>

Does that make sense?

-Chris Hallinan
DS4.COM, Inc.

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Jeff
> Kowing
> Sent: Friday, November 15, 2002 2:59 PM
> To: Brian Waite
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: NFS root manipulation without being superuser?
>
>
>
> Brian Waite writes:
>  > you could export the fs from the dev host as
> no_root_squash an insecure
>  > for example
>  > /home   *(rw,insecure,no_root_squash)
>  >
>  > That will allow the embedded host to modify files on
> the NFS filesystem as
>  > root. Does tha accomplish what you need?
>
> Thanks Brain for the reply.  No, that is not really what
> I mean.  I
> want to be able to manipulate/create/alter the target's root
> filesystem (exported from the development workstation) from the
> _development_ workstation.  I want to be able to do so
> without having
> to change to superuser privleges on the development workstation.
>
> For example, say I export an NFS root filesystem to my
> target.  This
> filesystem on my development machine is located within my home
> directory.  For example:
>
> /home/me/target
> /home/me/target/bin
> /home/me/target/root
> /home/me/target/lib
> /home/me/target/dev
> ... you get the idea.
>
> Now, from my development workstation, as user "me", I
> would like to be
> able to install a program to the target's NFS root filesystem.  I
> would like that program to appear as having root ownership to the
> target.  For example, user "me" installs the program "foo" to:
>
> /home/me/target/bin/foo
>
> On the development machine this would look like:
> developmentt$ ls -l /home/me/target/bin/foo
> -rwxr-xr-x    1 me  me          48 Nov 15 10:59 foo
>
> On the target machine this would look like:
> target$ ls -l /bin/foo
> -rwxr-xr-x    1 root  root      48 Nov 15 10:59 foo
>
> I guess maybe I thought there might be a way to do some
> sort of NFS
> user/group mapping so that you could "trick" the target
> into thinking
> files were owned by root whereas on the development
> machine they are
> in reality owned by user "me".  Or some sort of tricks
> that could be
> played using fakeroot and those kinds of programs.
>
> I guess what I really want is a way, from my development
> workstation,
> to have the "power" of root to manipulate the target's filesystem
> (i.e., the files under /home/me/target directory) WITHOUT
> having the
> "power" to screw up the development workstation's system
> files.  Does
> this make sense to anyone or is the caffeine affecting my
> thinking?
>
> --
> Jeff Kowing
> jeffrey.d.kowing@nasa.gov
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
