Date: Tue, 29 Jan 2002 08:49:02 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200201291649.g0TGn2x09346@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: BUG: udp socket, getsockopt + setsockopt
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've found a very strange bug in linux ppc 2.4.17, I think. I'm pulling
udp packets off the LAN and reading them in a user space program. They come
in sets of about 60k bytes all together, then pause for a while. I only can
read the first 48k successfully, then they get lost.

If I have a setsockopt call on the socket, setting SO_RCVBUF to 65535,
then I don't lose any data. But if I do a getsockopt beforehand on
SO_RCVBUF, it reports 65535. Without the setsockopt I get the packet loss,
with it I don't lose any. It is strange because the value doesn't appear
to be changing.

What can be causing this mysterious behaviour?

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
