Mime-Version: 1.0
Message-Id: <v04210100b415499d9a1c@[206.173.234.127]>
In-Reply-To: <199909270014.KAA25683@tango.anu.edu.au>
References: <v04210101b4132312764f@[206.173.234.57]>
 <199909270014.KAA25683@tango.anu.edu.au>
Date: Mon, 27 Sep 1999 09:35:53 -0700
To: Paul.Mackerras@cs.anu.edu.au
From: Randall R Schulz <rrschulz@cris.com>
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, Everybody,

Thanks to Paul and all the others who responded with information and 
suggestions.

At Paul M.'s suggestion, I tried using the "novj" option (only) in my 
~/.ppprc file. I made several tests against a few files on a couple 
of different servers.

The good news (at least as far as it offers a work-around): It does 
appear that disabling Van Jacobsen compression alleviates the symptom.

However, I did also discover that even with VJ compression left 
enabled, not all remote hosts experience this problem. As one of my 
tests, I transferred a 2.2 Mbyte file from my private ISP's personal 
web page site (via the FTP interface to that file area). Two attempts 
to transfer that file both succeeded flawlessly even with VJ 
compression turned on. That server is "ftp.cris.com."  I don't know 
for a fact, but I'm guessing that host does *not* run Linux.

On the other hand, transferring files from "ftp.xemacs.org" (a.k.a. 
"gwyn.tux.org") is virtually impossible while VJ compression is 
enabled but works just fine with VJ disabled. In this case, my guess 
is that this host *does* run Linux.

It does also appear to be data related (not surprising if it's a 
problem with the implementation of the compression algorithm, whether 
in LinuxPPC 2.2.6 or whatever's running on ftp.xemacs.org). In 
particular this file: 
<ftp://ftp.xemacs.org/pub/xemacs/docs/letter/internals-letter.pdf.gz> 
will stall the TCP circuit after just a few K have been transferred. 
I repeated this twice and (like every file I tried) and it does 
transfer fine with VJ off.

So, it may be the case that the LinuxPPC code in my kernel is OK (as 
evidenced by the fact that connecting to ftp.cris.com works OK) but 
that the implementation on ftp.xemacs.org is not correct or fully 
compliant with the VJ specification. It's also possible that my 
kernel's VJ code has a bug that is somehow tolerated by 
ftp.cris.com's VJ code.

Right now, I'm content that I can successfully access the net. 
Naturally, the maximum throughput I can get is reduced without VJ 
compression, but that's far better than dealing with constantly 
stalling connections.

One last question: Can I turn VJ compression on and off while a PPP 
link is active, or must I choose before connecting?

Thanks again. If there's anything else I can do for people wishing to 
investigate further, please just let me know.

Randy Schulz
Mountain View, CA USA


At 10:14 +1000 9/27/99, Paul Mackerras wrote:
>Randall R Schulz <rrschulz@cris.com> wrote:
>
> >...
>
>This sounds like the remote system isn't getting the ACKs (or they are
>getting corrupted).  Try putting the `novj' option in your ~/.ppprc
>file and see if that makes any difference.
>
>Paul.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
