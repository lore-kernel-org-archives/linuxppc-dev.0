Message-ID: <01C07705.46376070.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: TCP Server stops accepting after 10mins
Date: Fri, 5 Jan 2001 10:50:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone.  I would very much appreciate help with the following problem:

The Unit Under Test (UUT) has Redhat's embedded Linux kernel (based on Linux
kernel 2.2.13), from the Redhat EDK 1.0, running on an embedded MPC860 uP
with 8M of RAM, and is connected to a LAN.

For my test, I have a TCP Client (Microsoft) on a PC, also connected to the
LAN, connect to the TCP Server (linux) on the UUT at the following intervals
(50/s = "50 connects per sec", 1/5s = "1 connect every 5 secs"):

       50/s, 1/5s, 1/20s, 1/30s, and 1/60s.

For 50/s, 1/5s, 1/20s, and 1/30s, approx. 10 minutes (+/- 1 connect period) is the
constant time when the TCP Client fails to connect to the Server.

But, whenever the connect frequency = 1/60s, or longer, then the problem goes
away and the TCP Client can connect forever at this rate.


Test Results:

50/s:	stopped connecting                 @  10:00		(over 29,500 connect()s.)

1/5s:	stopped connecting on next try @ 10:05

1/20s:	stopped connecting on next try @ 9:40

1/30s:	stopped connecting on next try @ 10:30

1/60s:   connects forever (several hours in test)


The fact that regardless of whether the connects occur at a very high frequency
(50/s) or low frequency (1/30s), the TCP Client fails to connect after 10 mins.
(I think 1min and 10 mins are key info). I would think that this would indicate
that the problem is not one of running out of allocated memory.
It appears that something happens once a minute, some type of cleanup, maybe?
And if that goes on for 10 times, then connects are denied.  As
long as at least 1 min is allowed to go by without accepting a connect from a
client, then there is no problem, and another 10 min period is allowed to occur.

This is very repeatable.  Note that if I pause the Client from connecting just before
the 10 minute time period connect() failure is to occur, and wait at least 1 minute
(can't be less), and then allow the Client to continue connecting, then the Client
is able to connect for another 10 minutes before the connect() failure occurs.

This problem occurs even when I have no threads running, and the TCP Server is
executing in the main() func.

Thanks a million for anybody's help or suggestions,

ShutEye Thinkin
Roanoke, Virginia  USA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
