Return-Path: <xma@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05DE7679E7
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 05:44:18 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49JiFcg013065
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 15:44:15 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49JiE7r176936
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 13:44:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49JiDvK030015
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 13:44:14 -0600
In-Reply-To: <40FCD6B6-9135-43C1-8974-E9070475DB78@schihei.de>
To: Heiko J Schick <info@schihei.de>
MIME-Version: 1.0
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt
	handling	routines
Message-ID: <OF6CAB9865.804CAFBB-ON87257169.006C3DBC-88257169.00718277@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Tue, 9 May 2006 12:46:43 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 0071826F88257169_="
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	openib-general-bounces@openib.org,
	"Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0071826F88257169_=
Content-Type: text/plain; charset="US-ASCII"

openib-general-bounces@openib.org wrote on 05/09/2006 11:57:01 AM:

> On 09.05.2006, at 18:49, Michael S. Tsirkin wrote:
> 
> >> The trivial way to do it would be to use the same idea as the current
> >> ehca driver: just create a thread for receive CQ events and a thread
> >> for send CQ events, and defer CQ polling into those two threads.
> >
> > For RX, isn't this basically what NAPI is doing?
> > Only NAPI seems better, avoiding interrupts completely and avoiding 
> > latency hit
> > by only getting triggered on high load ...
> 
> Does NAPI schedules CQ callbacks to different CPUs or stays the callback
> (handling of data, etc.) on the same CPU where the interrupt came in?
> 
> Regards,
>    Heiko

My understanding is NAPI handle interrutps CQ callbacks on the same CPU. 
But you could implement NAPI differently, then it doesn't follow the 
native NAPI 
implementation.

Thanks
Shirley Ma
IBM Linux Technology Center
15300 SW Koll Parkway
Beaverton, OR 97006-6063
Phone(Fax): (503) 578-7638
--=_alternative 0071826F88257169_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>openib-general-bounces@openib.org wrote on 05/09/2006
11:57:01 AM:<br>
<br>
&gt; On 09.05.2006, at 18:49, Michael S. Tsirkin wrote:<br>
&gt; <br>
&gt; &gt;&gt; The trivial way to do it would be to use the same idea as
the current<br>
&gt; &gt;&gt; ehca driver: just create a thread for receive CQ events and
a thread<br>
&gt; &gt;&gt; for send CQ events, and defer CQ polling into those two threads.<br>
&gt; &gt;<br>
&gt; &gt; For RX, isn't this basically what NAPI is doing?<br>
&gt; &gt; Only NAPI seems better, avoiding interrupts completely and avoiding
&nbsp;<br>
&gt; &gt; latency hit<br>
&gt; &gt; by only getting triggered on high load ...<br>
&gt; <br>
&gt; Does NAPI schedules CQ callbacks to different CPUs or stays the callback<br>
&gt; (handling of data, etc.) on the same CPU where the interrupt came
in?<br>
&gt; <br>
&gt; Regards,<br>
&gt; &nbsp; &nbsp;Heiko<br>
</tt></font>
<br><font size=2 face="sans-serif">My understanding is NAPI handle interrutps
CQ callbacks on the same CPU. </font>
<br><font size=2 face="sans-serif">But you could implement NAPI differently,
then it doesn't follow the native NAPI </font>
<br><font size=2 face="sans-serif">implementation.</font>
<br><font size=2 face="sans-serif"><br>
Thanks<br>
Shirley Ma<br>
IBM Linux Technology Center<br>
15300 SW Koll Parkway<br>
Beaverton, OR 97006-6063<br>
Phone(Fax): (503) 578-7638</font>
--=_alternative 0071826F88257169_=--
