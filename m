Return-Path: <arnon.kaufman@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by ozlabs.org (Postfix) with ESMTP id C832EDDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 00:24:44 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so991270fkz.9
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 05:24:43 -0800 (PST)
Message-ID: <47652712.60006@gmail.com>
Date: Sun, 16 Dec 2007 15:24:34 +0200
From: Arnon Kaufman <arnon.kaufman@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [MPC5200] problem running FEC and ATA 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

does any one succeed running a functional FEC and ATA (pata) running 
together ?
If so which version (2.6.x...) and with which architecture (powerpc or 
ppc)?.

The machine I'm working on based on v2.6.21-rc6 and another one based on 
v2.6.24-rc1, both configured with ARCH=powerpc.

my FEC introduce itself as: "PHY: f0003000:01", and not as f0003000:00, 
I've fix it by adjusting the dts file, is that ok?

I'm getting the following, when pinging the machine:

64 bytes from xxx.xxx.xxx.xxx: icmp_seq=4401 ttl=64 time=0.249 ms
64 bytes from xxx.xxx.xxx.xxx: icmp_seq=4402 ttl=64 time=0.285 ms
wrong data byte #52 should be 0x34 but was 0xa
#8      8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 
20 21 22 23 24 25 26 27
#40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 a 35 36 37
64 bytes from xxx.xxx.xxx.xxx: icmp_seq=4403 ttl=64 time=0.233 ms
wrong data byte #20 should be 0x14 but was 0x0
#8      8 9 a b c d e f 10 11 12 13 0 15 16 17 18 19 1a 1b 1c 1d 1e 1f 
20 21 22 23 24 25 26 27
#40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37
64 bytes from xxx.xxx.xxx.xxx: icmp_seq=4404 ttl=64 time=0.232 ms
64 bytes from xxx.xxx.xxx.xxx: icmp_seq=4405 ttl=64 time=0.237 ms

-----

The offsets and values of the corrupted data are constant (can it be the 
  microcode?)

when enabling the PATA driver and doing some Compact flash access 
operation the amount of packets corruption is getting worse.

does the pata driver needs to wait on the TIP indicator? cause it 
doesn't seems to do it.
