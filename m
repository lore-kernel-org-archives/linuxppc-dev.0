Date: Mon, 25 Sep 2000 18:15:51 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: MTU and hung ssh connections
Message-ID: <Pine.LNX.4.21.0009251804190.16067-100000@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just found some really strange behavior leading me to believe
something is broken on G4 machines in the networking code.

If I execute the following command:

ssh -v hq.fsmlabs.com rpm -qi openssh

(or anything else that seems to cause ssh to send a large packet), the
data gets put in the send-q (reported via netstat) on hq.fsmlabs.com, but
my G4 mac never receives it.

If I set the MTU of eth0 on the G4 to 500, it works fine. If I use rinetd,
and use a G3 running linux (with bmac+) to redirect port 2222 from the G3
to hq.fsmlabs.com, it works fine.

This leads me to believe there is something strange going on only on the
G4 (which has a tulip chip).

I have no problems connecting from a G3, which is connected to the same
fast ethernet switch as my G4, and takes the same route to hq.fsmlabs.com


(included is a traceroute in case this might be some misconfigured router)


[hozer@narn linuxppc_2_5]$ /usr//sbin/traceroute hq.fsmlabs.com
traceroute to hq.fsmlabs.com (209.155.42.197), 30 hops max, 38 byte
packets
 1  dsl.73.32-63gateway.networkiowa.com (209.234.73.33)  28.073 ms  37.672
ms  41.610 ms
 2  gateway.networkiowa.com (209.234.64.250)  32.183 ms  31.744 ms  35.654
ms
 3  s10-0-0-13.chi-bb2.cerf.net (134.24.102.61)  75.233 ms  98.101 ms
76.723 ms 4  so6-1-0-155M.chi-bb5.cerf.net (134.24.29.209)  100.384 ms
97.618 ms  83.312 ms
 5  ser2-3-45M.phl-bb2.cerf.net (134.24.33.194)  97.724 ms
ser1-4-45M.phl-bb2.cerf.net (134.24.33.190)  102.089 ms
ser2-3-45M.phl-bb2.cerf.net (134.24.33.194)
81.356 ms
 6  pos6-0-0-155M.nj-bb1.cerf.net (134.24.46.114)  108.623 ms
pos4-0-0-155M.nj-bb1.cerf.net (134.24.46.169)  65.635 ms  95.520 ms
 7  ny-nap.crl.com (192.157.69.56)  92.481 ms  125.058 ms  111.724 ms
 8  nynap-ord1.ATM.us.crl.net (165.113.0.225)  79.929 ms  84.549 ms
90.015 ms
 9  ord1-sfo2.ATM.us.crl.net (165.113.0.241)  143.063 ms  139.818 ms
148.325 ms10  E0-CRL-SFO-04-E0X0.US.CRL.NET (165.113.55.4)  144.362 ms
153.341 ms  155.615 ms
11  abq-sfo.C.us.crl.net (165.113.50.233)  213.930 ms  275.370 ms  196.040
ms
12  165.113.97.19 (165.113.97.19)  200.023 ms  220.240 ms  198.700 ms
13  scorpio.sdc.org (209.155.42.3)  235.784 ms  212.834 ms  246.366 ms
14  hq.fsmlabs.com (209.155.42.197)  219.882 ms  208.760 ms  231.145 ms


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
