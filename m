Mime-Version: 1.0
Message-Id: <v0420553fb3abf4c843cd@[206.163.71.146]>
In-Reply-To: 
 <Pine.LNX.3.96.990709020727.21556D-200000@newhope.terraplex.com>
References: 
 <Pine.LNX.3.96.990709020727.21556D-200000@newhope.terraplex.com>
Date: Fri, 9 Jul 1999 11:58:42 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Joel Klecker <jk@espy.org>
Subject: Re: QuickTime Streaming Server for Linux.. on x86
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 02:34 -0600 1999-07-09, Dan Burcaw wrote:
>--- StreamingServer-2/RhapServer/UDPSocket.cpp.o	Fri Jul  9 
>02:05:48 1999
>+++ StreamingServer-2/RhapServer/UDPSocket.cpp	Fri Jul  9 02:07:41 1999
>@@ -40,7 +40,11 @@
> #endif
>
> #if __linux__
>+#if __GLIBC__ >= 2
>+#include <bits/socket.h>
>+#else
> #include <socketbits.h>
>+#endif

Ugh, that is so wrong it's not even funny, both of those are internal 
headers to glibc, and should not be included directly. The portable 
way is <sys/socket.h> (which in the glibc implementation includes the 
appropriate internal header). Whoever's responsible for the linux 
patches ought to be shot.
-- 
Joel Klecker (aka Espy)                    Debian GNU/Linux Developer
<URL:mailto:jk@espy.org>                 <URL:mailto:espy@debian.org>
<URL:http://web.espy.org/>               <URL:http://www.debian.org/>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
