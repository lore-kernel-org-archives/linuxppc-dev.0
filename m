Message-ID: <01C07729.CF3B0510.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "'Ruhland, Paul'" <pruhland@microwavedata.com>,
        "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: How to disable Denial-of-Service safeguard in Linux Kernel?
Date: Fri, 5 Jan 2001 15:11:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Paul,

I have run this test previously making sure that the Client always called close()
1st.  If I understand correctly, the 1st to close() is the only one to go into TIME-WAIT.
But, I also set TCP_TIMEWAIT_LEN = 0.

But, anyway, regarding the test where the Client connected 29,500 times with no problem
until exactly 10 min expired would seem to discount any resource problem, wouldn't it? :-)
It doesn't seem to matter if the freq. of connects is 50/s (29,500 in 10min) or 1/30s (20 in 10min).
How could it work so well almost 30,000 times, and then die like that?

Connecting at a freq, of 1/52 secs works, but 1/48secs doesn't.  So, I wonder if 50 secs is
another key number.

I've tried playing with the func in net/core/utils.c called net_ratelimit() which seems to be
some kind of safeguard against DoS, but it doesn't appear to help.

For test purposes, this is a very simple, barebones, generic Client/Server setup.

Client:   while (1)
                {
               socket()
               connect()
               close()
               5 sec delay (or could be 30 sec, or could be 50 per sec)
               }

Server:   socket()
             bind()
             listen()

             while (1)
                {
               accept()
               close()
               }


Puzzled,

ShutEye Thinkin


-----Original Message-----
From:	Ruhland, Paul [SMTP:pruhland@microwavedata.com]
Sent:	Friday, January 05, 2001 2:47 PM
To:	svacca@valcom.com; LinuxEmbeddedMailList (E-mail)
Subject:	RE: How to disable Denial-of-Service safeguard in Linux Kernel?

Without knowing anything about your linux tcp server I will take a guess at
what is happening.

When the client disconnects from the server the server port may not be
closing...it may be in a TIME WAIT state.  So when the next connection
request comes in it cannot accept because the port is still open.  The
server ports will eventually timeout which is why the longer time between
connections works.

Try this...after your client disconnects, do a 'netstat --inet' on the
server.  My guess is you'll see the port your server uses is still open.




> -----Original Message-----
> From: Steven Vacca [mailto:svacca@valcom.com]
> Sent: Friday, January 05, 2001 2:30 PM
> To: LinuxEmbeddedMailList (E-mail)
> Subject: How to disable Denial-of-Service safeguard in Linux Kernel?
>
>
>
> I am suspecting the the problem stated below is due to
> Denial-of-Service safeguards
> incorporated into the Linux Kernel.  Would anyone know how to
> diable this feauture?
>
> Thanks,
>
> ShutEye Thinkin
>
> -----Original Message-----
> From:	Steven Vacca [SMTP:svacca@valcom.com]
> Sent:	Friday, January 05, 2001 10:50 AM
> To:	LinuxEmbeddedMailList (E-mail)
> Subject:	TCP Server stops accepting after 10mins
>
> Hi everyone.  I would very much appreciate help with the
> following problem:
>
> The Unit Under Test (UUT) has Redhat's embedded Linux kernel
> (based on Linux
> kernel 2.2.13), from the Redhat EDK 1.0, running on an
> embedded MPC860 uP
> with 8M of RAM, and is connected to a LAN.
>
> For my test, I have a TCP Client (Microsoft) on a PC, also
> connected to the
> LAN, connect to the TCP Server (linux) on the UUT at the
> following intervals
> (50/s = "50 connects per sec", 1/5s = "1 connect every 5 secs"):
>
>        50/s, 1/5s, 1/20s, 1/30s, and 1/60s.
>
> For 50/s, 1/5s, 1/20s, and 1/30s, approx. 10 minutes (+/- 1
> connect period) is the
> constant time when the TCP Client fails to connect to the Server.
>
> But, whenever the connect frequency = 1/60s, or longer, then
> the problem goes
> away and the TCP Client can connect forever at this rate.
>
>
> Test Results:
>
> 50/s:	stopped connecting                 @  10:00
> (over 29,500 connect()s.)
>
> 1/5s:	stopped connecting on next try @ 10:05
>
> 1/20s:	stopped connecting on next try @ 9:40
>
> 1/30s:	stopped connecting on next try @ 10:30
>
> 1/60s:   connects forever (several hours in test)
>
>
> The fact that regardless of whether the connects occur at a
> very high frequency
> (50/s) or low frequency (1/30s), the TCP Client fails to
> connect after 10 mins.
> (I think 1min and 10 mins are key info). I would think that
> this would indicate
> that the problem is not one of running out of allocated memory.
> It appears that something happens once a minute, some type of
> cleanup, maybe?
> And if that goes on for 10 times, then connects are denied.  As
> long as at least 1 min is allowed to go by without accepting
> a connect from a
> client, then there is no problem, and another 10 min period
> is allowed to occur.
>
> This is very repeatable.  Note that if I pause the Client
> from connecting just before
> the 10 minute time period connect() failure is to occur, and
> wait at least 1 minute
> (can't be less), and then allow the Client to continue
> connecting, then the Client
> is able to connect for another 10 minutes before the
> connect() failure occurs.
>
> This problem occurs even when I have no threads running, and
> the TCP Server is
> executing in the main() func.
>
> Thanks a million for anybody's help or suggestions,
>
> ShutEye Thinkin
> Roanoke, Virginia  USA
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
