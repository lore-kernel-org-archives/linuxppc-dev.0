Message-ID: <36B4BB67.B795BFAC@eos.ncsu.edu>
Date: Sun, 31 Jan 1999 15:21:59 -0500
From: Scott Sams <sbsams@eos.ncsu.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: BUG in dmasound.c, allocating buffers
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am running linux-2.2.0 and I noticed that the kernel crashed 4 times
in one day when I was playing mp3s (mpg123-p, gqmpeg-0.4.5), always when
a new song was going to be played, and usually after 30 minutes of
continuous play. There was absolutely no warning message on the screen
or in the logs, just the entire system froze, with the exception of the
console cursor appearing and blinking in the upper left corner of the
screen.

This got me digging into dmasound.c and looking at the cvs log. The last
version I used, this problem did not occur. This was linux-2.1.125 using
dmasound.c version 1.29. Since then, there have been several updates,
notably 1.33:

>Patch from Jes/Andreas to make it only allocate buffers when opened.

I think that the bug must lie in there, maybe in the sq_allocate_buffers
or sq_release_buffers functions.

I also saw a patch, 1.37, which said it fixed a couple of bugs that let
the user crash the kernel. I applied these by hand to my version of
dmasound.c, just to be safe, but the same crash happened later.

I don't have the knowledge to fix this bug, but I'll bet if someone who
is knowledgable looked over the code I have isolated, they will find out
what is going on.

At the very least, someone can insert some debugging output that may
help discover the problem. I will be glad to test anything.

Thanks,

Scott Sams

-- 
 ____ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~      Scott Sams         
(____  _  _-|-|-                    sbsams@eos.ncsu.edu      
_____)(__(_)| |        http://www.catt.ncsu.edu/~sbsams
~~~~~~~~~~~~~~~~

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
