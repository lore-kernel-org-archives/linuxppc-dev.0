Return-Path: <kylo@kylo.net>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.89])
	by ozlabs.org (Postfix) with ESMTP id 489E767A2E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 03:22:08 +1000 (EST)
Message-ID: <4259615E.2070608@kylo.net>
Date: Sun, 10 Apr 2005 10:24:46 -0700
From: Kylo Ginsberg <kylo@kylo.net>
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
References: <Pine.LNX.4.61.0504101046030.8150@localhost.localdomain>
	<42594D18.4070403@kylo.net>
	<Pine.LNX.4.61.0504101302010.28010@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0504101302010.28010@localhost.localdomain>
Content-Type: text/html; charset=ISO-8859-1
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: how to get busybox shell prompt on console port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Fwiw, I explicitly created the CPM devices; note that the major/minor
match those of your NULL nodes.&nbsp; I'm running 2.6.11.&nbsp; I'm fuzzy re
if/how these devices should be automagically created by the kernel.<br>
<br>
<pre>  mknod ttyCPM0 c 204 46
  mknod ttyCPM1 c 204 47
  chmod 660 ttyCPM*
  
</pre>
<br>
<br>
Robert P. J. Day wrote:
<blockquote
 cite="midPine.LNX.4.61.0504101302010.28010@localhost.localdomain"
 type="cite">
  <pre wrap="">On Sun, 10 Apr 2005, Kylo Ginsberg wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">I use this line in /etc/inittab (assuming you've built busybox to include sh):

ttyCPM0::respawn:-/bin/sh
    </pre>
  </blockquote>
  <pre wrap=""><!---->
(first, a caveat: even though this is the 2.6 kernel, i'm still using
devfs for historical reasons.  that will change shortly but may be
part of my problems.)

i'm pretty sure i tried that combo, and several others like it, and i
finally had success with the following entry in /etc/inittab:

  ::respawn:/bin/sh &lt; /dev/console &gt; /dev/console 2&gt; /dev/console

yes, it's disgusting but it works.  once i got a prompt, i noticed
that these are the contents of /dev:

crw-------    1 root     root     204,  46 Dec 31  1969 &lt;NULL&gt;0
crw-------    1 root     root     204,  47 Dec 31  1969 &lt;NULL&gt;1
crw-------    1 root     root       5,   1 Oct  2 08:56 console
crw-rw-rw-    1 root     root       1,   7 Dec 31  1969 full
drwxr-xr-x    1 root     root            0 Dec 31  1969 input
crw-r-----    1 root     root       1,   2 Dec 31  1969 kmem
crw-r--r--    1 root     root       1,  11 Dec 31  1969 kmsg
drwxr-xr-x    1 root     root            0 Dec 31  1969 loop
crw-r-----    1 root     root       1,   1 Dec 31  1969 mem
drwxr-xr-x    1 root     root            0 Dec 31  1969 misc
crw-rw-rw-    1 root     root       1,   3 Dec 31  1969 null
crw-r-----    1 root     root       1,   4 Dec 31  1969 port
crw-rw-rw-    1 root     root       5,   2 Dec 31  1969 ptmx
drwxr-xr-x    1 root     root            0 Dec 31  1969 pts
drwxr-xr-x    1 root     root            0 Dec 31  1969 pty
crw-r--r--    1 root     root       1,   8 Dec 31  1969 random
drwxr-xr-x    1 root     root            0 Dec 31  1969 rd
lr-xr-xr-x    1 root     root            4 Sep 25  1969 root -&gt; rd/0
drwxr-xr-x    1 root     root            0 Dec 31  1969 shm
crw-rw-rw-    1 root     root       5,   0 Dec 31  1969 tty
crw-r--r--    1 root     root       1,   9 Dec 31  1969 urandom
crw-rw-rw-    1 root     root       1,   5 Dec 31  1969 zero


  in other words, no /dev/ttyCPM0 which may be why that first solution
never worked (i'm still fuzzy on support for the serial/console ports
so i'm reading up on that now.)  but given that i have a /dev/console,
i'll stick with that for now until i have a better fix.

  and what's the two "NULL" entries up there?  those are new to me.

rday

  </pre>
</blockquote>
<br>
</body>
</html>
