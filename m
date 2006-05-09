Return-Path: <xma@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0344679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 07:26:03 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49LPxc8017532
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 17:25:59 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49LPwUi265194
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 15:25:58 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49LPwnE018852
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 15:25:58 -0600
In-Reply-To: <20060509202041.GB24713@mellanox.co.il>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
MIME-Version: 1.0
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt
	handling	routines
Message-ID: <OFD1053717.15B4F49A-ON87257169.007531E1-88257169.007AD29E@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Tue, 9 May 2006 14:28:26 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 007AD29488257169_="
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
--=_alternative 007AD29488257169_=
Content-Type: text/plain; charset="US-ASCII"

"Michael S. Tsirkin" <mst@mellanox.co.il> wrote on 05/09/2006 01:20:41 PM:

> Quoting r. Shirley Ma <xma@us.ibm.com>:
> > My understanding is NAPI handle interrutps CQ callbacks on the same 
CPU.
> 
> My understanding is NAPI disables interrupts under high RX load. No?
> 
> -- 
> MST

Yes, NAPI disables the interrupts based on the weight. In IPoIB case, it 
doesn't 
send out the next completion notification under heavy loading. 
The similiar CQ polling is still in NAPI on same CPU, but it's not a 
callback
anymore. 

What I find that the send completion and recv completion are not 
that fast, which means RX load is not that heavy in IPoIB. That might be
the reason compared to multiple threads implementation NAPI is not good.

Thanks
Shirley Ma
IBM Linux Technology Center
15300 SW Koll Parkway
Beaverton, OR 97006-6063
Phone(Fax): (503) 578-7638
--=_alternative 007AD29488257169_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>&quot;Michael S. Tsirkin&quot; &lt;mst@mellanox.co.il&gt;
wrote on 05/09/2006 01:20:41 PM:<br>
<br>
&gt; Quoting r. Shirley Ma &lt;xma@us.ibm.com&gt;:<br>
&gt; &gt; My understanding is NAPI handle interrutps CQ callbacks on the
same CPU.<br>
&gt; <br>
&gt; My understanding is NAPI disables interrupts under high RX load. No?<br>
&gt; <br>
&gt; -- <br>
&gt; MST<br>
</tt></font>
<br><font size=2><tt>Yes, NAPI disables the interrupts based on the weight.
In IPoIB case, it doesn't </tt></font>
<br><font size=2><tt>send out the next completion notification under heavy
loading. </tt></font>
<br><font size=2><tt>The similiar CQ polling is still in NAPI on same CPU,
but it's not a callback</tt></font>
<br><font size=2><tt>anymore. </tt></font>
<br>
<br><font size=2><tt>What I find that the send completion and recv completion
are not </tt></font>
<br><font size=2><tt>that fast, which means RX load is not that heavy in
IPoIB. That might be</tt></font>
<br><font size=2><tt>the reason compared to multiple threads implementation
NAPI is not good.</tt></font>
<br>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">Shirley Ma<br>
IBM Linux Technology Center<br>
15300 SW Koll Parkway<br>
Beaverton, OR 97006-6063<br>
Phone(Fax): (503) 578-7638</font>
--=_alternative 007AD29488257169_=--
