Message-ID: <001701c07b15$cc85bbe0$e3e8b2c6@hawk>
From: "Mike Hill" <mhill@bustech.com>
To: <svacca@valcom.com>,
        "LinuxEmbeddedMailList \(E-mail\)" <linuxppc-embedded@lists.linuxppc.org>
References: <01C07ADF.1FDC97A0.svacca@valcom.com>
Subject: Re: TCP Server Boogie
Date: Wed, 10 Jan 2001 09:57:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have some vague recollection of a similar problem.

I was performing pings to our embedded system, and after some number of
pings, I don't remember how many, they would begin to timeout.  This would
only occur if I was pinging at a high rate (about 1200 pings per sec)  At
the time, I thought it was some sort of DoS feature in the kernel, but that
did not turn out to be the case.

I was able to track the failure to the function "sock_alloc_send_skb" in
./net/core/sock.c (see code snippet below)

/***********************
  skb = sock_wmalloc(sk, try_size, 0, sk->allocation);
  if (skb)
   break;

  /*
   * This means we have too many buffers for this socket already.
   */

  sk->socket->flags |= SO_NOSPACE;
  err = -EAGAIN;
************************/
Apparently, the socket had too many buffers allocated to it.

After a couple of more days chasing this, I found it to be a result of a bug
in the Ethernet driver I was using (de4x5.c v0.544).  Under heavy load, the
TX SKB ring in the driver was getting out of sync.  As a result, SKB's were
not being returned to the system.  After a while, the socket would reach
it's max, and further SKBs would not be allocated.

So, if you are using the DE4x5 driver, I think there is a good chance that
you are experiencing the same problem I saw.

Good Luck,
Mike


----- Original Message -----
From: "Steven Vacca" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, January 10, 2001 8:27 AM
Subject: TCP Server Boogie


>
> Friends! Friends!   Help! Help! Help!!!!
>
> Here's the updated representation of my problem.  I am in
> dire need of some suggestions.  Please, please, please!
>
>
> Important Question:
> (See Problem info below) Why would a TCP Server do a
> Denial-of-Service (DoS) to a TCP Client after exactly 10 min
> (600s) while allowing another TCP Client, at another IP addr
> and PC, which has been simultaneously connecting for less
> than 10 mins, to continue connecting (for a total of 10 min)?
>
> The 2 TCP Clients have different IP addrs and are on different
> PCs.  The DoS must be based in the TCP Client's source IP
> addr.
>
> If both TCP Clients are at the same IP addr (same PC), then they
> both experience DoS at exactly 10 min.
>
>
>
> file://*******************************************************************
> Updated re-statement of my Problem:
> The Unit Under Test (UUT) has Redhat's embedded Linux
> kernel (based on Linux kernel 2.2.13), from the Redhat
> EDK 1.0, running on an embedded MPC860 uP with 8M of RAM,
> and is connected to a LAN.
>
> For my test, I have a TCP Client (Microsoft) connect to the
> TCP Server (linux) on the UUT once every 5 secs.  5 mins
> later I have a 2nd TCP Client (Microsoft) on a different
> PC start connecting to the same TCP Server.
>
> After almost exactly 10 mins (+/- a connect period), the 1st
> TCP Client gets connect() failures, but the 2nd TCP Client
> continues on connecting.
>
> Several mins later (1 minute min), I start the 1st TCP Client
> connecting again, once every 5 secs as usual.
>
> After the 2nd TCP Client has been connecting for 10 mins, it
> also gets connect() failures, but the 1st TCP Client
> continues on connecting.
>
> ...and so on and so forth.
>
> NOTE: If both the 1st and 2nd TCP Client are at the same IP
> addr, then even though they start connecting at different times,
> they both stop connecting at exactly 10 mins after the 1st TCP
> Client started.
>
> 10 minutes is the constant time when a TCP Client fails to
> connect to the Server.
>
>
> But, whenever the connect frequency = once every 60s, or longer,
> then the problem goes away and the TCP Client can connect
> forever at this rate.
>
>
> Some Test Results at various connect() freqs.:
>
> 50/s: stopped connecting                    @  10:00 (over 29,500
connect()s.)
>
> 1/5s: stopped connecting on next try    @ 10:05
>
> 1/20s: stopped connecting on next try    @ 9:40
>
> 1/30s: stopped connecting on next try    @ 10:30 (only 20 connects)
>
> 1/60s:   connects forever (several hours in test)
>
>
>
> This is very repeatable.  Note that if I pause the Client
> from connecting just before the 10 minute time period
> connect() failure is to occur, and wait at least 1 minute
> (can't be less), and then allow the Client to continue
> connecting, then the Client is able to connect for another
> 10 minutes before the connect() failure occurs.
>
> This problem occurs even if I have no created threads running,
> and the TCP Server is executing in the main() func.
>
> Thanks a million for anybody's help or suggestions,
>
> ShutEye Thinkin
> Roanoke, Virginia  USA
>
>
> Here's a good test for someone to try with Redhat EDK 1.0
> on an MBX860 unit:
>
> Test scenario #1, connecting at once every 5s:
>
> On another PC:
> Client:   while (1)
>                {
>                socket()
>                connect()
>                close()
>                5 sec delay        (120 connects in 10 mins)
>                }
>
> On Embedded EDK unit:
> Server:   socket()
>              bind()
>              listen()
>
>              while (1)
>                {
>                accept()
>                close()
>                }
>
>
>
>
>
> Test scenario #2, connecting 50 times per sec:
>
> On another PC:
> Client:   while (1)
>                {
>                socket()
>                connect()
>                close()
>                1/50 sec delay        (30,000 connects in 10 mins)
>                }
>
> On Embedded EDK unit:
> Server:   socket()
>              bind()
>              listen()
>
>              while (1)
>                {
>                accept()
>                close()
>                }
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
