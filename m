From: Jeff Kowing <jeffrey.d.kowing@nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15829.20978.564041.583906@igor.jsc.nasa.gov>
Date: Fri, 15 Nov 2002 13:58:42 -0600
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS root manipulation without being superuser?
In-Reply-To: <200211151348.11492.waite@skycomputers.com>
References: <15829.8892.699280.307557@igor.jsc.nasa.gov>
	<200211151348.11492.waite@skycomputers.com>
Reply-To: jeffrey.d.kowing@nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Waite writes:
 > you could export the fs from the dev host as no_root_squash an insecure
 > for example
 > /home   *(rw,insecure,no_root_squash)
 >
 > That will allow the embedded host to modify files on the NFS filesystem as
 > root. Does tha accomplish what you need?

Thanks Brain for the reply.  No, that is not really what I mean.  I
want to be able to manipulate/create/alter the target's root
filesystem (exported from the development workstation) from the
_development_ workstation.  I want to be able to do so without having
to change to superuser privleges on the development workstation.

For example, say I export an NFS root filesystem to my target.  This
filesystem on my development machine is located within my home
directory.  For example:

/home/me/target
/home/me/target/bin
/home/me/target/root
/home/me/target/lib
/home/me/target/dev
... you get the idea.

Now, from my development workstation, as user "me", I would like to be
able to install a program to the target's NFS root filesystem.  I
would like that program to appear as having root ownership to the
target.  For example, user "me" installs the program "foo" to:

/home/me/target/bin/foo

On the development machine this would look like:
developmentt$ ls -l /home/me/target/bin/foo
-rwxr-xr-x    1 me  me          48 Nov 15 10:59 foo

On the target machine this would look like:
target$ ls -l /bin/foo
-rwxr-xr-x    1 root  root      48 Nov 15 10:59 foo

I guess maybe I thought there might be a way to do some sort of NFS
user/group mapping so that you could "trick" the target into thinking
files were owned by root whereas on the development machine they are
in reality owned by user "me".  Or some sort of tricks that could be
played using fakeroot and those kinds of programs.

I guess what I really want is a way, from my development workstation,
to have the "power" of root to manipulate the target's filesystem
(i.e., the files under /home/me/target directory) WITHOUT having the
"power" to screw up the development workstation's system files.  Does
this make sense to anyone or is the caffeine affecting my thinking?

--
Jeff Kowing
jeffrey.d.kowing@nasa.gov

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
