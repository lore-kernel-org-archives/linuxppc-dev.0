Message-Id: <199907131537.IAA11494@meer.meer.net>
Subject: Test kernel for Newer Technology upgrade cards.
Date: Tue, 13 Jul 1999 10:40:55 -0500
From: David DeHaven <daved@trestle.com>
To: <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It took a while, but I think it may be done... maybe not bug free, but 
it's done. If you have a Newer Technology G3 upgrade card, ftp to 
206.53.121.114 (anonymous) and download the test kernel (only file in 
/pub). It's the 2.2.6 kernel compiled with the default PowerMac options, 
the only difference is the addition of code to detect which Newer 
Technology card is installed. In theory, it should configure your L2 
cache automatically.

Some simple instructions:

1> If you have the extension installed and are using BootX, disable the 
extension for the extent of the test.

2> Turn off any options to set the L2 cache, such as the checkbox on 
BootX and the L2CR=xxx kernel option.

3> Boot once to verify that the cache is _disabled_ using your normal 
kernel. You can verify this by typing "cat /proc/sys/kernel/l2cr" at the 
bash prompt, it should say "00000000: " followed by a textual 
description, if not, then something is still enabling the cache.

4> Once the system is set up so that the cache is not enabled, install 
the new kernal and reboot the system.

5> When the system boots, check to see if the cache was enabled using the 
same method as in step 3.

6> Email me directly at daved@trestle.com with the following information:

Name and email address
Type of machine
Type of Newer Technology upgrade
Symptom (if it crashed)
A dump of /proc/sys/kernel/l2cr and /var/logs/dmesg

/var/logs/dmesg could contain some diagnostic info I left in there for 
cases I haven't been able to test yet... which right now is everything 
but the MAXPowr G3-G3 cards.

If you have any questions, you can email me directly.

-DrD-

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
