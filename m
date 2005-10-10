Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep9.connect.com.au (fep9.mfe.bur.connect.com.au [203.63.86.9])
	by ozlabs.org (Postfix) with ESMTP id DFB6D68387
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 15:40:05 +1000 (EST)
Received: from [192.168.1.100] (cor12-ppp681.hay.dsl.connect.net.au
	[61.68.71.173])
	by mfep9.connect.com.au (Postfix) with ESMTP id 6F13AC1A8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Oct 2005 14:39:10 +1000 (EST)
Message-ID: <4349F072.6050309@rftechnology.com.au>
Date: Mon, 10 Oct 2005 14:39:14 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: cur_ppc_sys_spec is NULL
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have latest linux-2.6-denx (MPC8272ADS board) kernel and I have some 
questions, may be somebody knows:
Here is the kernel output

Linux version 2.6.14-rc3-g2f70d4fe ..
Motorola PQ2 ADS PowerPC port
Built 1 zonelists
Kernel command line: console=ttyCPM0,115200 /dev/ram rw
PID hash table entries: 512 (order: 9, 8192 bytes)
Warning: real time clock seems stuck!
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 62720k available (1628k kernel code, 388k data, 92k init, 0k 
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
<stuck here>

Using gdb and BDI2000 I have allocated the problem in ppc_sys_init(void) 
- cur_ppc_sys_spec is NULL. There are 3 functions to find an appropriate 
  spec:
identify_ppc_sys_by_id
identify_ppc_sys_by_name
identify_ppc_sys_by_name_and_id
None of them are called by pq2ads.c or from any other place for 8272. I 
am just wondering if anybody might know at what stage spec should be 
selected for 8272ADS?

Thank you,

Dimitry
