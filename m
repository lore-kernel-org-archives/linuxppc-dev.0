Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Subject: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
Date: Thu, 19 Jun 2008 17:53:51 +1000
MIME-Version: 1.0
Message-Id: <200806191753.51495.markn@au1.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following are new versions of copy_tofrom_user, memcpy and copy_4K_page
which have been written specifically for Cell. All the hard work for these
routines was done by Gunnar von Boehn - I used his new memcpy to create
copy_4K_page and just added the exception handling code to
copy_tofrom_user.

Using these new routines give a big performance improvement for Cell
(tested on QS22 Cell blade):

Test				unpatched kernel		new routines
---------------------------------------------------------------------------------
iperf				2.3 GBits/sec			5.8 GBits/sec

netperf (TCP)		2.5 GBits/sec			5.3 GBits/sec

netperf (UDP)		318 MBits/sec			351 MBits/sec

kernel used was 2.6.25.7

tests were run as follows (final result is mean of 4 runs):
numactl --cpunodebind=0 --membind=0 ./iperf -s
-> numactl --cpunodebind=0 --membind=0 ./iperf -c 127.0.0.1 -t 30 -l 64k

numactl --cpunodebind=0 --membind=0 ./netserver
-> numactl --cpunodebind=0 --membind=0 ./netperf -l 30 -H 127.0.0.1 -c -t UDP_STREAM -- -m 1024
-> numactl --cpunodebind=0 --membind=0 ./netperf -l 30 -H 127.0.0.1 -c -t TCP_STREAM -i 10,2 -I 99,5 -- -m 32768


The plan is to use Michael Ellerman's code patching work so that at runtime
if we're running on a Cell machine the new routines are called but otherwise
the existing memory copy routines are used.

It would be good to get some more (fresh) eyes looking at this. Any and all
comments are welcome.

Thanks!
Mark
