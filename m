Message-Id: <199909271957.VAA00313@piglet.cpu.lu>
Date: Mon, 27 Sep 1999 21:57:52 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
To: rrschulz@cris.com
cc: Paul.Mackerras@cs.anu.edu.au, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04210100b415499d9a1c@[206.173.234.127]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  27 Sep, this message from Randall R Schulz echoed through cyberspace:
> At Paul M.'s suggestion, I tried using the "novj" option (only) in my 
> ~/.ppprc file. I made several tests against a few files on a couple 
> of different servers.
> 
> The good news (at least as far as it offers a work-around): It does 
> appear that disabling Van Jacobsen compression alleviates the symptom.

Aha...

> However, I did also discover that even with VJ compression left 
> enabled, not all remote hosts experience this problem.
[snip]
> On the other hand, transferring files from "ftp.xemacs.org" (a.k.a. 
> "gwyn.tux.org") is virtually impossible while VJ compression is 
> enabled but works just fine with VJ disabled. In this case, my guess 
> is that this host *does* run Linux.
> 
> It does also appear to be data related (not surprising if it's a 
> problem with the implementation of the compression algorithm, whether 
> in LinuxPPC 2.2.6 or whatever's running on ftp.xemacs.org). In 
> particular this file: 
> <ftp://ftp.xemacs.org/pub/xemacs/docs/letter/internals-letter.pdf.gz> 
> will stall the TCP circuit after just a few K have been transferred. 
> I repeated this twice and (like every file I tried) and it does 
> transfer fine with VJ off.

OK, I saw similar things as well. I had more trouble with the
ftp.linuxppc.org server at that time (running some 2.1.x kernel), than
with my provider's HP server...

> So, it may be the case that the LinuxPPC code in my kernel is OK (as 
> evidenced by the fact that connecting to ftp.cris.com works OK) but 
> that the implementation on ftp.xemacs.org is not correct or fully 
> compliant with the VJ specification. It's also possible that my 
> kernel's VJ code has a bug that is somehow tolerated by 
> ftp.cris.com's VJ code.

EEeeeepppp.... wrong conclusion here ;-). VJ compression is only active
on your PPP link, not end-to-end. So the remote server knows nothing of
the VJ copmpression your machine negotiates with the access server at
your provider.

Which brings us to another variable in the connection chain: the access
server at your provider. In my case, it was a Cisco 2509 with
USRobotics modems. You might want to check with your provider, just in
case... If it really is a VJ problem, then the provider's box could
have an influence, too.

> One last question: Can I turn VJ compression on and off while a PPP 
> link is active, or must I choose before connecting?

I don't think Linux's PPP can renegotiate link parameters. In any case,
the remote end must then be prepared to renegotiate as well...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
