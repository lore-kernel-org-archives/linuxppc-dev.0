Return-Path: <chandru@in.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55F8BDDEE9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 16:21:46 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m486LJ9r014244
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 16:21:19 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m486Plhw166802
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 16:25:47 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m486Li7b021187
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 16:21:44 +1000
Received: from [9.124.31.71] ([9.124.31.71])
	by d23av02.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m486Lg9M021102
	for <linuxppc-dev@ozlabs.org>; Thu, 8 May 2008 16:21:43 +1000
Message-ID: <48229BF5.9090602@in.ibm.com>
Date: Thu, 08 May 2008 11:51:41 +0530
From: Chandru <chandru@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: device tree in open firmware on power6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

When I set linux 2.6.26-rc1 as default kernel to boot in 
/etc/yaboot.conf, then the device tree in open firmware shows only one 
memory node ( the same memory node appears in /proc/device-tree/memory@0 
).  But when RHEL5.2 kernel is set as default in /etc/yaboot.conf then 
the device tree in open firmware shows plenty of memory nodes. Following 
is the open firmware output..

linux-2.6.26-rc1:

<snip>
0 > dev / ls
...
000000caf1b8:   /PowerPC,POWER6@6
000000cb0120: /memory@0
000000cb83d8: /ibm,dynamic-reconfiguration-memory
000000cbcd60: /options
...

0 > dev /memory@0  ok
0 > .properties
name                    memory
device_type             memory
reg                     00000000 00000000  00000000 08000000
available               00000000 00004000 00000000 00bfc000 00000000 02020000
00000000 05fe0000
#address-cells          00000001
#size-cells             00000000
ibm,phandle             fffffffa
ibm,associativity       00000004 00000000 00000000 00000000 00000000

<snip-end>




when default=RHEL5.2:

0 > dev / ls 
000000c8d200: /ibm,serial
000000c8dff8: /chosen
...
000000cae2c0:   /PowerPC,POWER6@4
000000caf1b8:   /PowerPC,POWER6@6
000000cb0120: /memory@0
000000cb5af0: /memory@8000000
000000cb5ce0: /memory@c000000
000000cb5ed0: /memory@10000000
000000cb60c0: /memory@14000000
000000cb62b0: /memory@18000000
000000cb64a0: /memory@1c000000
000000cb6690: /memory@20000000

...


The open firmware environment variable "ibm,fw-new-mem-def" is false for 
rhel5.2 kernel where as it is 'true' for 2.6.26-rc1 as default kernel to 
boot.  Any inputs if the one memory node in 2.6.26-rc1 should show the 
size of available system memory ?, or there should be many memory nodes 
for 2.6.26-rc1 ?.

Thanks,
Chandru
