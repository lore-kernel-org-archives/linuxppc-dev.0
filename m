Date: Tue, 29 Jan 2002 17:05:48 -0700
From: Val Henson <val@nmt.edu>
To: David Ashley <dash@xdr.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BUG: udp socket, getsockopt + setsockopt
Message-ID: <20020129170548.J2050@boardwalk>
References: <200201291649.g0TGn2x09346@xdr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200201291649.g0TGn2x09346@xdr.com>; from dash@xdr.com on Tue, Jan 29, 2002 at 08:49:02AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When you set SO_RCVBUF with setsockopt, the kernel allocates twice the
memory you set.  This has something to do with BSD compatibility and
storing internal kernel structures in the memory allocated for the
recv buf.  Try getsockopt after you setsockopt.

This is ostensibly a feature, not a bug.  Search the linux-kernel
archives for "so_rcvbuf" and "David Miller".  Hint: you probably won't
convince Dave to change his mind.

-VAL

On Tue, Jan 29, 2002 at 08:49:02AM -0800, David Ashley wrote:
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
