Return-Path: <ljaenicke@innominate.com>
Received: from home.innominate.com (host2.bln.innominate.com [77.245.32.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D36EAB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 04:09:57 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by home.innominate.com (Postfix) with ESMTP id 98E2B232D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 20:00:35 +0200 (CEST)
Received: from home.innominate.com ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id jkfKyK5l-5lI for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 20:00:35 +0200 (CEST)
Received: from lutz.bln.innominate.local (lutz.bln.innominate.local
	[10.1.0.160])
	by home.innominate.com (Postfix) with ESMTP id 7EBC5232D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 20:00:35 +0200 (CEST)
Date: Thu, 6 Aug 2009 20:00:35 +0200
From: Lutz Jaenicke <ljaenicke@innominate.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC8313 performance evaluation
Message-ID: <20090806180035.GA19088@lutz.bln.innominate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

I am currently evaluating the performance of the MPC8313E for firewall
(and VPN) purposes.
The results obtained do not match my expectations so I would be interested
in some discussion.

Test setup:
-----------
A linux 2.6.27 based firewall software is used. The software is the
same among
To be replaced: IXP42x custom made board (266MHz and 533MHz)
* MPC8343 custom made board (400MHz)
* MPC8313E-RDB Rev. C (333/333)
As a software firewall the throughput is determined by looking into
the routing information and IP headers, hence the performance is best
characterized by "frames/s" which is constant over the frame size
(as long as no limit is hit like the 100Mbit/s limit on the IXP42x).

With the MPC8343@400MHz I get a throughput of approx. 24500 frames/s
using the predefined firewall rules.
With the MPC8313 I get a significantly lower value:
MPC8313@250MHz          12500fps
MPC8313@333MHz          14500fps
MPC8313@416MHz          15500fps      (333MHz type, overclocked)
Kernel 2.6.27 with SKB recycling from later versions and the
e300c2/c3/c4 TLB errata workaround. Some pure computational benchmark
with small footprint (namely "openssl speed") which should fit into
the cache size indicates the perfect 3/4/5 ratio used.

Some discussion with the the freescale rep. lead to the CSB frequency
of the 8313 (166MHz) being significantly lower than that of the 8343.
Is the CSB the critical point here?
Note: the IXP42x uses an internal bus speed of 133MHz and operates
at frame rates similar to the 8343...

Does anybody else have numbers for a firewall scenario using 8313
and/or other processors of the family?

Best regards,
	Lutz
PS: Yes, I know that absolute numbers will be hard to compare with
other scenarios but relative values would be quite interesting as
well.
-- 
Dr.-Ing. Lutz Jänicke
CTO
Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.921028-200
fax: +49.30.921028-020
Rudower Chaussee 13
D-12489 Berlin, Germany
www.innominate.com

Register Court: AG Charlottenburg, HR B 81603
Management Board: Dirk Seewald
Chairman of the Supervisory Board: Volker Bibelhausen
