Message-Id: <3C56D4D3.CC3E7D03@motorola.com>
Date: Tue, 29 Jan 2002 10:58:59 -0600
From: Josh Horvath <Josh_Horvath-AJH051@email.mot.com>
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BUG: udp socket, getsockopt + setsockopt
References: <200201291649.g0TGn2x09346@xdr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is just a guess, but is SO_RCVLOWAT getting set somewhere?  The receive
call will block until it gets the number of bytes set with this option.  I
think it defaults to 1, so it should normally return when any data is
available on the socket.  But if it has been bumped up to a big number, it
might account for the behavior you're seeing.

-Josh

David Ashley wrote:
>
> I've found a very strange bug in linux ppc 2.4.17, I think. I'm pulling
> udp packets off the LAN and reading them in a user space program. They come
> in sets of about 60k bytes all together, then pause for a while. I only can
> read the first 48k successfully, then they get lost.
>
> If I have a setsockopt call on the socket, setting SO_RCVBUF to 65535,
> then I don't lose any data. But if I do a getsockopt beforehand on
> SO_RCVBUF, it reports 65535. Without the setsockopt I get the packet loss,
> with it I don't lose any. It is strange because the value doesn't appear
> to be changing.
>
> What can be causing this mysterious behaviour?
>
> -Dave
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
