Subject: RE: Debugging Network Performance
To: <acurtis@onz.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF93B8F461.B08FA3A3-ON85256BCE.004FA168@raleigh.ibm.com>
From: "Mark Wisner" <markwiz@us.ibm.com>
Date: Tue, 4 Jun 2002 10:35:19 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen,
KGDB may be a good start. netif_rx() is where the packet gets passed to the
stack. It basically throws the packet on a linklist for ip_rcv() in
ip_input.c to pick up and start processing it through the stack until it
passes the results to the application. This is tough stuff. Let me know how
you make out.

I would guess the IP stack has not changed much between kernels. I would be
more concerned about how the scheduler is working and other kernel tasks.

Mark K. Wisner
Advisory Software Engineer
IBM Microelectronics
3039 Cornwallis Rd
RTP, NC 27709
Tel. 919-254-7191
Fax 919-543-7575


"Allen Curtis" <acurtis@onz.com>@lists.linuxppc.org on 06/04/2002 09:30:16
AM

Please respond to <acurtis@onz.com>

Sent by:    owner-linuxppc-dev@lists.linuxppc.org


To:    Mark Wisner/Raleigh/IBM@IBMUS
cc:    <linuxppc-dev@lists.linuxppc.org>
Subject:    RE: Debugging Network Performance




> Netperf can give you a vary detailed report about network performance. If
> you think your problem is related to network hardware problems,
> look at the
> errors listed in "ifconfig". This should tell you if you are getting bad
> packets or dropping packets.

I did fix a problem in the driver and now there are no error reported by
ifconfig.

> If you think it is a kernel problem some benchmarks may help you narrow
> down the problem. Networks are pretty fluid and sometimes hard to get
> reproducible results. When I try to determine driver/kernel network
> perfomance I try to use an isolated network where I have control over all
> traffic or I use test hardware such as IXIA or Smartbits.

All testing is done on an isolated network. I do not believe that the
problem is in the driver itself. The driver has not changed significantly.
I
do need to check the error path since it appears that errors actually help
performance.

What is the best way to track packet processing through the kernel?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
