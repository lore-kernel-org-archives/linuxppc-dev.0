Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9B4C0B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 05:17:12 +1000 (EST)
Message-Id: <8731B515-14B1-4580-A196-75E57543C3F9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Lutz Jaenicke <ljaenicke@innominate.com>
In-Reply-To: <20090806180035.GA19088@lutz.bln.innominate.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: MPC8313 performance evaluation
Date: Thu, 6 Aug 2009 14:16:55 -0500
References: <20090806180035.GA19088@lutz.bln.innominate.local>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 6, 2009, at 1:00 PM, Lutz Jaenicke wrote:

> Hi!
>
> I am currently evaluating the performance of the MPC8313E for firewall
> (and VPN) purposes.
> The results obtained do not match my expectations so I would be  
> interested
> in some discussion.
>
> Test setup:
> -----------
> A linux 2.6.27 based firewall software is used. The software is the
> same among
> To be replaced: IXP42x custom made board (266MHz and 533MHz)
> * MPC8343 custom made board (400MHz)
> * MPC8313E-RDB Rev. C (333/333)
> As a software firewall the throughput is determined by looking into
> the routing information and IP headers, hence the performance is best
> characterized by "frames/s" which is constant over the frame size
> (as long as no limit is hit like the 100Mbit/s limit on the IXP42x).
>
> With the MPC8343@400MHz I get a throughput of approx. 24500 frames/s
> using the predefined firewall rules.
> With the MPC8313 I get a significantly lower value:
> MPC8313@250MHz          12500fps
> MPC8313@333MHz          14500fps
> MPC8313@416MHz          15500fps      (333MHz type, overclocked)
> Kernel 2.6.27 with SKB recycling from later versions and the
> e300c2/c3/c4 TLB errata workaround. Some pure computational benchmark
> with small footprint (namely "openssl speed") which should fit into
> the cache size indicates the perfect 3/4/5 ratio used.
>
> Some discussion with the the freescale rep. lead to the CSB frequency
> of the 8313 (166MHz) being significantly lower than that of the 8343.
> Is the CSB the critical point here?
> Note: the IXP42x uses an internal bus speed of 133MHz and operates
> at frame rates similar to the 8343...
>
> Does anybody else have numbers for a firewall scenario using 8313
> and/or other processors of the family?
>
> Best regards,
> 	Lutz
> PS: Yes, I know that absolute numbers will be hard to compare with
> other scenarios but relative values would be quite interesting as
> well.

What DDR frequencies (and width) are you running the 8343 vs 8313 at.   
This can have a significant impact on performance.

- k
