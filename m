Return-Path: <xma@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DAD9679E9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 09:33:44 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.boulder.ibm.com [9.17.249.41])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49IPr0x027839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:25:53 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49IPn3T017354
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:25:49 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49IPnUi243762
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:25:49 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49IPmah032467
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:25:49 -0600
In-Reply-To: <20060509164919.GC5063@mellanox.co.il>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
MIME-Version: 1.0
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling
	routines
Message-ID: <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Tue, 9 May 2006 11:27:29 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 006A41A288257169_="
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	openib-general-bounces@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 006A41A288257169_=
Content-Type: text/plain; charset="US-ASCII"

openib-general-bounces@openib.org wrote on 05/09/2006 09:49:19 AM:

> Quoting r. Roland Dreier <rdreier@cisco.com>:
> > The trivial way to do it would be to use the same idea as the current
> > ehca driver: just create a thread for receive CQ events and a thread
> > for send CQ events, and defer CQ polling into those two threads.

I have done some patch like that on top of splitting CQ. The problem I 
found that hardware interrupt favors one CPU. Most of the time these two 
threads are running on the same cpu according to my debug output. You can 
easily find out by cat /proc/interrupts and /proc/irq/XXX/smp_affinity. 
ehca has distributed interrupts evenly on SMP, so it gets the benefits of 
two threads, and gains much better throughputs.

The interesting thing is the UP results are much better than SMP results 
with this approach on mthca.

> For RX, isn't this basically what NAPI is doing?
> Only NAPI seems better, avoiding interrupts completely and avoiding 
> latency hit
> by only getting triggered on high load ...
> 
> -- 
> MST

According to some results from different resouces, NAPI only gives 3%-10% 
performance improvement on single CQ.
I am trying a simple NAPI patch on splitting CQ now to see how much 
performance there.

Thanks
Shirley Ma
IBM Linux Technology Center
15300 SW Koll Parkway
Beaverton, OR 97006-6063
Phone(Fax): (503) 578-7638
--=_alternative 006A41A288257169_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>openib-general-bounces@openib.org wrote on 05/09/2006
09:49:19 AM:<br>
<br>
&gt; Quoting r. Roland Dreier &lt;rdreier@cisco.com&gt;:<br>
&gt; &gt; The trivial way to do it would be to use the same idea as the
current<br>
&gt; &gt; ehca driver: just create a thread for receive CQ events and a
thread<br>
&gt; &gt; for send CQ events, and defer CQ polling into those two threads.<br>
</tt></font>
<br><font size=2><tt>I have done some patch like that on top of splitting
CQ. The problem I found that hardware interrupt favors one CPU. Most of
the time these two threads are running on the same cpu according to my
debug output. You can easily find out by cat /proc/interrupts and /proc/irq/XXX/smp_affinity.
ehca has distributed interrupts evenly on SMP, so it gets the benefits
of two threads, and gains much better throughputs.</tt></font>
<br>
<br><font size=2><tt>The interesting thing is the UP results are much better
than SMP results with this approach on mthca.</tt></font>
<br><font size=2><tt><br>
&gt; For RX, isn't this basically what NAPI is doing?<br>
&gt; Only NAPI seems better, avoiding interrupts completely and avoiding
<br>
&gt; latency hit<br>
&gt; by only getting triggered on high load ...<br>
&gt; <br>
&gt; -- <br>
&gt; MST<br>
</tt></font>
<br><font size=2><tt>According to some results from different resouces,
NAPI only gives 3%-10% performance improvement on single CQ.</tt></font>
<br><font size=2><tt>I am trying a simple NAPI patch on splitting CQ now
to see how much performance there.</tt></font>
<br>
<br><font size=2><tt>Thanks</tt></font>
<br><font size=2 face="sans-serif">Shirley Ma<br>
IBM Linux Technology Center<br>
15300 SW Koll Parkway<br>
Beaverton, OR 97006-6063<br>
Phone(Fax): (503) 578-7638</font>
--=_alternative 006A41A288257169_=--
