Date: Wed, 14 Jul 1999 15:13:47 +1000
Message-Id: <199907140513.PAA21479@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: joe_julicher@macktrucks.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <3.0.5.32.19990713083902.0080d910@mailhost.bulldog.com> (message
	from Joe Julicher on Tue, 13 Jul 1999 08:39:02 -0400)
Subject: Re: Interesting Beige G3 Storage Stuff
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <3.0.5.32.19990713083902.0080d910@mailhost.bulldog.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joe Julicher <joe_julicher@macktrucks.com> wrote:

> IDE HD.  The drive gives > 12mb/sec under MacOS.  Runs great and I have
> used it to record movies at 30fps.  Not bad.  However, under linux a hdparm
> -t /dev/hda gives 1.96mb/s  If I do a hdparm -T /dev/hda (to measure cache
> performance) it gives 64mb/s.  The drive speed seems VERY slow using this
> simple benchmark.  I would expect much better.  There are parameters to
> adjust with hdparm, but I haven't messed with them.

Do `hdparm -u1 -m16 -p /dev/hda' and you should get around 10MB/s out
of it.

> The kernel probes the ID's correctly and establishes a sync connection to
> each except for the Exabyte tape drive.  Later when the kernel probes for
> partitions on the 40mb drive, it times out and eventually reboots.  I
> haven't recorded the information in the big MESH dump that is provided.  If
> somebody wants that, I will get it.
> 
> I swapped the 40mb with a 250mb Quantum (pull from 7100).  This establishes
> a sync connection at 10mb/s and runs great.  I don't mind ditching the 40mb
> but I would like to understand the problem.  It seems that the MESH driver
> could still use some work OR, I need to recompile a kernel that does not do
> sync. transfers.  Perhaps I need to blacklist this 40mb drive.  Is there a
> no-sync blacklist?

Not as such.  There is a word in the driver with one bit per target
which says whether the driver can do sync connections with that
target.  You could edit the source and recompile to get a kernel where
the mesh driver won't do sync with that target.  A bit gross, I know.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
