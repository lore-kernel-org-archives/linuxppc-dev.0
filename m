Return-Path: <xma@us.ibm.com>
In-Reply-To: <20060821.173225.68047257.davem@davemloft.net>
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
To: David Miller <davem@davemloft.net>
Message-ID: <OFF5798F90.C3D3FCBB-ON872571D3.0007EC7F-882571D2.0072BA84@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Tue, 22 Aug 2006 18:29:37 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBFB40DF946AEF8f9e8a93df938690918c08BBFB40DF946AEF"
Cc: akpm@osdl.org, arnd@arndb.de, Jens.Osterkamp@de.ibm.com,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	linuxppc-dev-bounces+xma=us.ibm.com@ozlabs.org,
	jgarzik@pobox.com, rdreier@cisco.com, shemminger@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBFB40DF946AEF8f9e8a93df938690918c08BBFB40DF946AEF
Content-type: text/plain; charset=US-ASCII





> > This is a digression from spidernet, but what if a device is able to
> > generate separate MSIs for TX and RX?  Some people from IBM have
> > suggested that it is beneficial for throughput to handle TX work and
> > RX work for IP-over-InfiniBand in parallel on separate CPUs, and
> > handling everything through the ->poll() method would defeat this.
>
> The TX work is so incredibly cheap, relatively speaking, compared
> to the full input packet processing path that the RX side runs
> that I see no real benefit.
>
> In fact, you might even get better locality due to the way the
> locking can be performed if TX reclaim runs inside of ->poll()

We are still comparing these two approaches IPoIB performance under
different configurations. Hopefully the performance work can be done soon.
So we can have some data to share.

Thanks
Shirley Ma
IBM Linux Technology Center
15300 SW Koll Parkway
Beaverton, OR 97006-6063
Phone(Fax): (503) 578-7638



--0__=08BBFB40DF946AEF8f9e8a93df938690918c08BBFB40DF946AEF
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt; &gt; This is a digression from spidernet, but what if a device is able to<br>
&gt; &gt; generate separate MSIs for TX and RX? &nbsp;Some people from IBM have<br>
&gt; &gt; suggested that it is beneficial for throughput to handle TX work and<br>
&gt; &gt; RX work for IP-over-InfiniBand in parallel on separate CPUs, and<br>
&gt; &gt; handling everything through the -&gt;poll() method would defeat this.<br>
&gt; <br>
&gt; The TX work is so incredibly cheap, relatively speaking, compared<br>
&gt; to the full input packet processing path that the RX side runs<br>
&gt; that I see no real benefit.<br>
&gt; <br>
&gt; In fact, you might even get better locality due to the way the<br>
&gt; locking can be performed if TX reclaim runs inside of -&gt;poll()<br>
</tt><br>
<tt>We are still comparing these two approaches IPoIB performance under different configurations. Hopefully the performance work can be done soon. So we can have some data to share.</tt><br>
<br>
Thanks<br>
Shirley Ma<br>
IBM Linux Technology Center<br>
15300 SW Koll Parkway<br>
Beaverton, OR 97006-6063<br>
Phone(Fax): (503) 578-7638<br>
<br>
<br>
<br>
</body></html>
--0__=08BBFB40DF946AEF8f9e8a93df938690918c08BBFB40DF946AEF--
