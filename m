Date: Mon, 27 Sep 1999 10:14:35 +1000
Message-Id: <199909270014.KAA25683@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: rrschulz@cris.com
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-reply-to: <v04210101b4132312764f@[206.173.234.57]> (message from Randall R
	Schulz on Sat, 25 Sep 1999 18:49:14 -0700)
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <v04210101b4132312764f@[206.173.234.57]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Randall R Schulz <rrschulz@cris.com> wrote:

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

This sounds like the remote system isn't getting the ACKs (or they are
getting corrupted).  Try putting the `novj' option in your ~/.ppprc
file and see if that makes any difference.

> I have captured the tcpdump output from one of these "sessions" 
> (beginning when I clicked a FTP URL link in Navigator through until I 
> cancelled the stalled transfer after several repetitions at the 
> two-minute inter-packet arrival time. There are 140 lines of tcpdump 
> output. If anybody can make use of this in diagnosing the problem, 
> I'd be happy to send it...

I would be interested to see it.

> This problem is easily repeated,

Hopefully we can track it down then.

> I'd like to try changing my PPP MTU from 1500 to 1514, but I don't 
> know where to control it under kppp and the documentation doesn't 
> mention it.

Try making yourself a ~/.ppprc file containing the line `mru 1514'.
In fact the MTU is determined by the MRU (max receive unit) that the
peer asks for so you can't directly control it except to give a
maximum value with the mtu option.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
