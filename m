Mime-Version: 1.0
Message-Id: <v04210104b4143d523d32@[206.173.234.127]>
In-Reply-To: <199909260638.IAA00291@piglet.cpu.lu>
References: <199909260638.IAA00291@piglet.cpu.lu>
Date: Sun, 26 Sep 1999 14:19:53 -0700
To: mlan@cpu.lu
From: Randall R Schulz <rrschulz@cris.com>
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
Cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel,

Thanks for the reply. So far, it's the first one with any meaningful 
content I've gotten on this topic.

Yes, I, too, have the hunch that the problem is data sensitive and 
may relate to checksum generation. There were 17 messages in 
LinuxPPC-Dev (topic: "TCPv4 checksum errors") late last December 
about checksum generation problems, but the thread ended and it 
appeared that either the problem was fixed or was deemed spurious to 
begin with.

I should note that my kernel is generating no complaints about 
checksum errors and ifconfig reports zero errors of any sort 
throughout many megabytes of transfers. I also tried sending a few 
large files out and those transfers never hung. Bringing them same 
files back in order to verify their integrity required repeated use 
of the FTP "reget" command.

I tried turning off the G3 cache just in case it was introducing a 
subtle error (i.e., I was "grasping at straws"), but that seemed to 
make no difference.

Yes, my system sends ACK packets. Here's an excerpt of the exchange 
once the circuit has stalled from my tcpdump log:

18:51:27.860000 207.96.122.8.1268 > 206.173.238.104.1039: P 3523084713:3523086161(1448) ack 728409552 win 32120 <nop,nop,timestamp 314786368 515764> (DF)
18:51:27.860000 206.173.238.104.1039 > 207.96.122.8.1268: . ack 3523086161 win 31856 <nop,nop,timestamp 516296 314786368,nop,nop, sack 1 {3523087605:3523090501} > (DF)
18:51:39.090000 207.96.122.8.1268 > 206.173.238.104.1039: P 3523084713:3523086161(1448) ack 728409552 win 32120 <nop,nop,timestamp 314787492 515764> (DF)
18:51:39.090000 206.173.238.104.1039 > 207.96.122.8.1268: . ack 3523086161 win 31856 <nop,nop,timestamp 517419 314787492,nop,nop, sack 1 {3523087605:3523090501} > (DF)
18:52:01.500000 207.96.122.8.1268 > 206.173.238.104.1039: P 3523084713:3523086161(1448) ack 728409552 win 32120 <nop,nop,timestamp 314789740 515764> (DF)
18:52:01.500000 206.173.238.104.1039 > 207.96.122.8.1268: . ack 3523086161 win 31856 <nop,nop,timestamp 519660 314789740,nop,nop, sack 1 {3523087605:3523090501} > (DF)

My host is 206.173.238.104, the remote is 207.96.122.8 (gwyn.tux.org, 
a.k.a. ftp.xemacs.org). There are several repetitions of this 
exchange and only my impatience ended it.

Thanks for the feedback.

Randy Schulz
Mountain View, CA USA


>Hi all,
>
>On  25 Sep, this message from Randall R Schulz echoed through cyberspace:
> > In my lonely quest to solve the problem I'm having with the stalling 
> > of inbound (only, it seems) TCP streams over PPP (but not local 
> > loopback, it seems), I'm reaching the grasping at straws stage.
>
>I've had that same problem repeatedly in the past; I don't see it now
>because I don't use PPP anymore.
>
>What was weired for me is that the problem seemed to depend on file
>content, so the actual data transfered did make a difference.
>
>For instance, I always had problems with the glibc RPM files.
>Downloading them to a different machine at my provider, gzip'ing them
>there, I was able to download them to my box without a problem.
>
>Does your box send out the ACK's for the incoming data? In that case,
>either these never reach the remote end, or the ACK packets contain
>some form of error...
>
>
>Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
