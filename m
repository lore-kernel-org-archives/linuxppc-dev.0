Date: Mon, 10 Dec 2001 09:11:30 -0500
Mime-Version: 1.0 (Apple Message framework v475)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: unkillable zombies from using gdb and kernel 2.4.15 and higher?
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <CF1E527E-ED77-11D5-8C12-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been debugging a glibc-2.2.4 issue that involves forking and
reaping and threads using gdb.  Unfortunately, every time I run things
under gdb I create an "unkillable" zombie process that (even after gdb
has gone away) is impossible to remove.

ps -Af | grep idlc
kbhend   25532     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25529     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25541     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25543     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25540     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25552     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25554     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25551     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   14796 10716  0 09:11 pts/4    00:00:00 grep idlc

[root@localhost program]# kill -9 25530 25532 25529
[root@localhost program]# ps -Af | grep idlc
....
kbhend   25530     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25532     1  0 Dec08 ?        00:00:00 [idlc]
kbhend   25529     1  0 Dec08 ?        00:00:00 [idlc]

So these zombies are ignoring kill -9  signals which I thought was a big
no-no?

Did something change in signal handling lately that allows this to
happen?

Thanks,

Kevin

----
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London Ontario, CANADA  N6A 3K7
khendricks@ivey.uwo.ca

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
