Message-Id: <199901192207.QAA08969@wolfram.com>
To: "Ian K. Erickson" <ian@ns0.ipeg.com>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 15 partitions max prob revisited 
In-reply-to: <Pine.LNX.3.96.990119114919.10611D-100000@ns1.ipeg.com> 
References: <Pine.LNX.3.96.990119114919.10611D-100000@ns1.ipeg.com>
Date: Tue, 19 Jan 1999 16:07:52 -0600
From: Brian Downing <bdowning@wolfram.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 19 Jan 1999 11:51:15 -0800 (PST), "Ian K. Erickson" writes:
 > On Tue, 19 Jan 1999, Brad Boyer wrote:
 > > No, this is a Linux problem.  You cannot have more than 15 partitions
 > > on a drive because there are not device numbers allocated for anything
 > > higher than partition number 15.
 > 
 > Not that know anything about it, but out of curiosity: couldn't you use
 > mknod to create >15 [hs]da's? Or could you recompile the kernal to allow
 > them?

No.  It works like this:

brw-rw----   1 root     wheel      8,   0 Sep 12  1994 /dev/sda
brw-rw----   1 root     wheel      8,   1 Sep 12  1994 /dev/sda1
brw-rw----   1 root     wheel      8,   2 Sep 12  1994 /dev/sda2
...
brw-rw----   1 root     wheel      8,  14 Sep 12  1994 /dev/sda14
brw-rw----   1 root     wheel      8,  15 Sep 12  1994 /dev/sda15

...so partition 16 would be major 8 minor 16, except:

brw-rw----   1 root     wheel      8,  16 Sep 12  1994 /dev/sdb
brw-rw----   1 root     wheel      8,  17 Sep 12  1994 /dev/sdb1
brw-rw----   1 root     wheel      8,  18 Sep 12  1994 /dev/sdb2

If we had more device nodes to play with, we could have devices that
work per SCSI id instead of the dynamically allocated ones we have now.
It's a huge pain when you remove a disk on a server and sdf-sdk fall
down to sde-sdj.  Or worse -- when a faulty disk falls off the chain,
and when the (unsupervised) machine reboots -- everything is mounted in
the wrong place!  :-)

-bcd
--
**               Brian Downing
**  UNIX Systems Administrator
**        bdowning@wolfram.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
