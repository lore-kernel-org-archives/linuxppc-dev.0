Message-Id: <199909260638.IAA00291@piglet.cpu.lu>
Date: Sun, 26 Sep 1999 08:38:05 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
To: rrschulz@cris.com
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04210101b4132312764f@[206.173.234.57]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  25 Sep, this message from Randall R Schulz echoed through cyberspace:
> In my lonely quest to solve the problem I'm having with the stalling 
> of inbound (only, it seems) TCP streams over PPP (but not local 
> loopback, it seems), I'm reaching the grasping at straws stage.

I've had that same problem repeatedly in the past; I don't see it now
because I don't use PPP anymore.

What was weired for me is that the problem seemed to depend on file
content, so the actual data transfered did make a difference.

For instance, I always had problems with the glibc RPM files.
Downloading them to a different machine at my provider, gzip'ing them
there, I was able to download them to my box without a problem.

> By using tcpdump, I have discovered what seems to be a relevant fact: 
> When the stream stalls, the sending side (always the remote) is 
> resending the same range of bytes (sequence numbers) over and over 
> again with an inter-packet arrival time that increases gradually 
> until it reaches about two minutes where it holds until one side or 
> the other gives up and closes the stream. Each such packet has the 
> PUSH flag set and elicits an ACK from my system, but for whatever 
> reason, the remote just keeps sending repetitions of a packet 
> containing the same range of sequence numbers (with a total of 1448 
> data bytes each).

Does your box send out the ACK's for the incoming data? In that case,
either these never reach the remote end, or the ACK packets contain
some form of error...


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
