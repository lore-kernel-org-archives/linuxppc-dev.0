Message-Id: <5.1.0.14.2.20021115150906.0224ce08@falcon.si.com>
Date: Fri, 15 Nov 2002 15:16:16 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: NFS root manipulation without being superuser?
In-Reply-To: <0060C09C.C21188@nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How about this thought... on your development system, make a group "xroot"
(export root, or maybe name it "grub" to make a bad pun) and chown your NFS
files currently owned by "root" to "xroot".  You can add yourself into the
"xroot" group and make sure all the NFS exported root file system have
group r/w privileges.  Now you can play with the files to your heart's
content because you are part of the group that has write permissions.  When
you are happy with your NFS exported root file system, change the group
ownership of "xroot" back to "root".  With a little thought and a lot of
care ;-), you should be able to write a script that does the group change
back & forth.

gvb


At 01:58 PM 11/15/2002 -0500, jeffrey.d.kowing@nasa.gov wrote:

>Brian Waite writes:
>  > you could export the fs from the dev host as no_root_squash an insecure
>  > for example
>  > /home   *(rw,insecure,no_root_squash)
>  >
>  > That will allow the embedded host to modify files on the NFS filesystem as
>  > root. Does tha accomplish what you need?
>
>Thanks Brain for the reply.  No, that is not really what I mean.  I
>want to be able to manipulate/create/alter the target's root
>filesystem (exported from the development workstation) from the
>_development_ workstation.  I want to be able to do so without having
>to change to superuser privleges on the development workstation.
>
>For example, say I export an NFS root filesystem to my target.  This
>filesystem on my development machine is located within my home
>directory.  For example:
>
>/home/me/target
>/home/me/target/bin
>/home/me/target/root
>/home/me/target/lib
>/home/me/target/dev
>... you get the idea.
>
>Now, from my development workstation, as user "me", I would like to be
>able to install a program to the target's NFS root filesystem.  I
>would like that program to appear as having root ownership to the
>target.  For example, user "me" installs the program "foo" to:
>
>/home/me/target/bin/foo
>
>On the development machine this would look like:
>developmentt$ ls -l /home/me/target/bin/foo
>-rwxr-xr-x    1 me  me          48 Nov 15 10:59 foo
>
>On the target machine this would look like:
>target$ ls -l /bin/foo
>-rwxr-xr-x    1 root  root      48 Nov 15 10:59 foo
>
>I guess maybe I thought there might be a way to do some sort of NFS
>user/group mapping so that you could "trick" the target into thinking
>files were owned by root whereas on the development machine they are
>in reality owned by user "me".  Or some sort of tricks that could be
>played using fakeroot and those kinds of programs.
>
>I guess what I really want is a way, from my development workstation,
>to have the "power" of root to manipulate the target's filesystem
>(i.e., the files under /home/me/target directory) WITHOUT having the
>"power" to screw up the development workstation's system files.  Does
>this make sense to anyone or is the caffeine affecting my thinking?
>
>--
>Jeff Kowing
>jeffrey.d.kowing@nasa.gov
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
