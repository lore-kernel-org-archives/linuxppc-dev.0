Message-Id: <200005240551.HAA00630@piglet.grunz.lu>
Date: Wed, 24 May 2000 07:51:06 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: partition size funkiness
To: ericpeden@homemail.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <B550A5BA.464A%ericpeden@homemail.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  23 May, this message from Eric Peden echoed through cyberspace:
> I've begun to suspect that my problems are due to the method I used to
> "re-partition" the drive; I simply used pdisk to re-arrange the partition
> map, thus doing a non-destructive repartitioning.

I'm sure that is your problem right there. I bet 1.4 gig was the size of
your root partition before extending the partition?

> The cause is different, and of course no solution is offered, but the
> symptoms are the same. Is partition information stored somewhere other than
> the partition map? Is df just reading this information incorrectly, or is
> the extra space on /dev/sda7 truly unusable? Is there some low-level
> information I could modify to properly reflect the size of root?

Partition information is only stored in the partition map, however no
partition is usable as-is. You need to create a filesystem on a
partition before it is usable to any OS (well, in general at least ;-).
Your problem is that you didn't recreate the filesystem when you made
your partition larger. It worked for you (sortof...) only because the
starting block of your partition:

> 7:     Apple_UNIX_SVR2 /                        5529600 @ 2098358 (  2.6G)
this number:                                                ^^^^^^^

stayed at the same place as one of your previous partitions.

The only solution is to back up your data again, and re-create the
filesystem on all affected partitions:

mke2fs /dev/sda7 (your new root partition)

If you moved your swap partition as well, you might want to do a:

mkswap /dev/sda8

but I've run successfully without that part.... It can't hurt, though.

Hope this helps, and good luck


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
