Message-ID: <36983326.EA43D05F@jlc.net>
Date: Sat, 09 Jan 1999 23:57:11 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.muc.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MBX860: How to boot with initrd ?
References: <199901082349.AAA13864@denx.muc.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:

> ....  But  I  must be missing something, because such an image will
> not boot; all I see is:

Hmmm.  I know initrd works because I use it quite often.  All of the
memory relocation looks OK.  Cort had a good suggestion, can you
build a kernel that boots using NFS (or at least boots to the point of
trying to mount the root fs).


>         Linux/PPC load: console=tty0 console=ttyS0,9600n8

This looks a little weird.  It should not be necessary and I
don't know what happens when it is used.


> Any help appreciated...

Look for  'log_buf' in your System.map.  It will have an address
something like 'c00daa78'.  When you reset the MBX, use the
EPPC-Bug to dump the memory starting at daa78 (in this example).
This is the text of the kernel printk until the serial device is
initialized.  It may hold some clues.

You could also use 'noinitrd' on the command line to determine
if the problem is related to initrd or something else.


> Let's assume that I want to populate the `initrd'  with  exactly  the
> same  files  as  included  in the `mbxroot.min.tgz' example. [This is
> what I'm  testing  with,  additionally  I  have  only  added  a  link
> `/linuxrc' which points to `/bin/sh'].

That should work fine.


> What might be missing? I'm sure it's just  a  minor  detail,  however
> critical :-(

They always are :-).  One wrong bit can screw up everything......
and you have a 50% change of getting it right :-).


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
