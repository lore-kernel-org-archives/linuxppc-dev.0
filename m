Return-Path: <linuxppc-dev+bounces-28202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC02C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:48:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrr983tyvz30VL;
	Fri, 25 Sep 2026 22:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790340508;
	cv=none; b=MFqY9q0CCTnWoUZnkLw7YT/Oe0J0/hqPU2G+4QSQYix1MNZLG7yq8QEft7SJjoJvu2QyTye30FVA+kwBZqfATUnZ4sLB4Vi+28kB9YFyXnzh6VH6YscIMgAI5rTamDmC0y+ySw0NL8G3hkp04PgsSizsrIvcFWjlzCryz95j5t5HmvaWcpzckCwDt9QORNul0NUnN6z+UwsZfc4N2951YBpTUp3I8+L956uzuSBVcmlWOlq9zd1AWLOaCOahSxtm36aZv3pU6Ox4LP9xvlh54D7+TMEVEUFa7lZ386aLasBO7/D9Qvh5HWSYAZqcSnOfNQjQKO95qS6v8QyecK9c7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790340508; c=relaxed/relaxed;
	bh=dticQziE3F2u2vbIRugd3OC1IfgoYBq9NWncWnr2phg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/muBnL17VHJa5pCcRCAFj6ldWFakafqcMZpr0E8cLo4XbAvPFIDDtmcJdnmIwgoeCpLd0LICfM2rB1smGjczk4IdKLF8vK9k8o2+jyHH6ACgSOoxpvLPKxe/l/sumLhKM/V2p9ejv4qGBZ/M1Eg7DVRtEDf1jkSKBQQnBnvvVD9wZueizfjS1gYO31UT/9ByfefN4FBcljpAbsEfHG0uinK3JVlHDnwYPpuSXtZtY4obxqb8y9HAjPkn75nKtxwXhCICF2b31JBXKw7FNlZnFzr7Mb2XcadyLHpNRflD6cLuCZhotxWPwT/1xiE2skiSO8mYy8a3mluqp/ynp2AUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h7HmEDIM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h7HmEDIM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrr965Znrz2yQ9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 22:48:26 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4aOtI2393772;
	Fri, 25 Sep 2026 12:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dticQz
	iE3F2u2vbIRugd3OC1IfgoYBq9NWncWnr2phg=; b=h7HmEDIMdAnTduW8i/cd2d
	W1MZvI+0hkwPULZVfkWgJfpL6zQtVDyOyC6FeW8LXtK7/MxKEt+HbyYWTy2sGOfJ
	hrISygouNsRCnEHjaobTMu6dwe9re6ZUcWM3XOIZ3Os63F3LrKKBtJk+Coo0Ea6E
	j/ebxFjLGl1B+U1WUrYmHfskcbPJyyJb3he3Wz/vWsOxS/dNrMpmErvPiX9AdvdO
	/EZMNMcJI05l9g7oAsybXQ4P9D33nXyVXBVIJT+4J9q3S7bQHbRTrfXYgPjho3s6
	f+MDnDpW5Eg9f7GUNwcgmW2PaYd8OL2LEZmTyLLuhD8TN63p/P9IXtxB6HMTntdQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske272jt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:48:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA1AK51960465;
	Fri, 25 Sep 2026 12:48:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7eemss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 12:48:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PCmLqe46531008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:48:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0FC2004B;
	Fri, 25 Sep 2026 12:48:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05AF320040;
	Fri, 25 Sep 2026 12:48:20 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 12:48:19 +0000 (GMT)
Message-ID: <8112c9c7-3cad-4305-9d8d-b343857fd61d@linux.ibm.com>
Date: Fri, 25 Sep 2026 18:18:18 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Stuck CPUs after kexec() on PowerNV
To: Timothy Pearson <tpearson@raptorengineering.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <203407354.16057.1786980540348.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <203407354.16057.1786980540348.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: O_FoSOr3gSwmXprThNe5i-iavOy3n5OW
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab66d98 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=3_uRt0xjAAAA:8
 a=xNf9USuDAAAA:8 a=hpzXcQxZjYuN5D_VUjcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=z1SuboXgGPGzQ8_2mWib:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfXxEslG7tElsdf
 CYj9YVD5nnfMTd4gqAAOmEh1dIYTj8vQmMNf08L0oF4cAX7SwYCyIERyqjSQW3cmhEkEGEsT3wZ
 hOEBe7GjxjyOvFvg2Ztw0ZbzEwU+Y/M=
X-Proofpoint-GUID: IH-gBUaPazlaeBtr9qYKYZgWIlteLdhE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MCBTYWx0ZWRfX+FkTCDuw6v+h
 +DuFAuSvxVQt9O9zx/x0m/1mSBOIgmZ8rby6XJ+LivI6Pf8bZ7ZFMCwqIwswrf48FtfCT9nCvYj
 DxEZOZr3B5Jqb5g/msgdCth7aJGM/2DSt6CaWg3uboJkm6MXLfTcq6KvNgnuDnCbJvREr7Ie7gK
 QW1ZMHTn4jgujZHOLS37zHV/suTOGcK77ovhIW1XM7qZkvKg1xvkkVaGX4HxDcJna01MhpcXEfd
 3GnbmBAddwEAz3x9rU6I4bUj0Vsawh8aWQxiZ2isWbwLshR+QAS/KN7D19DnwBfuLti1j3Ybud6
 6/bcOUHnAHfBg6llH7fcFxysLktYUbpseStdNcQG7ac1ofuASOUpzFAwFlHEYejiDBCpbclI5Da
 i1ORjLtervrtYtzlieSy9M7MuHNfYT28B94kEkViPvRbGZH6tbtJUZfgtlcjyBLlwa2Lj2mPE6J
 O3rrnuyYprGrlcOALpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250050

Hello Timothy,

I am not able to reproduce this issue on a Power9/PowerNV
system with the same guest image you used.

Since you didn't mentioned the mode in which you booted the guest,
I tried both KVM and TCG modes, but I was not able to reproduce the
issue in either mode.

Here is my configuration:

Host: Power9/PowerNV (Fedora 43 running 6.19.7-200.fc43.ppc64le kernel)
Guest image: debian-13-generic-ppc64el-20260706-2531.qcow2
Image Source: 
https://cloud-image-finder.debian.net/i/debian-13-generic-ppc64el-20260706-2531

qemu-system-ppc64 --version
QEMU emulator version 10.1.5 (qemu-10.1.5-1.fc43)
Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers

[    0.000000] Linux version 6.12.95+deb13-powerpc64le 
(debian-kernel@lists.debian.org) (powerpc64le-linux-gnu-gcc-14 (Debian 
14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP Debian 
6.12.95-1 (2026-07-04)
[...]
[    0.003276] smp: Bringing up secondary CPUs ...
[    0.159291] smp: Brought up 1 node, 100 CPUs
[    0.159313] numa: Node 0 CPUs: 0-99

As shown in the above log, I assigned 100 CPUs to the guest. I also
tried with 160 CPUs, but I was still not able to reproduce the issue.

The QEMU command I used to boot the guest is:
KVM Guest:
qemu-system-ppc64 -accel kvm -M pseries -smp 100 -m 8G -drive 
file=debian-13-generic-ppc64el-20260706-2531.qcow2,format=qcow2,if=virtio 
-nographic

 From the logs you shared, it is clear that the problem occurs
during kernel boot, when the primary CPU tries to bring up the
other CPUs through powerpc's __cpu_up().

However, if I can reproduce the issue, it would be much easier to
identify the root cause and fix it.

Could you please share your configuration so that I can try to
reproduce the issue on my system?

For example:
- The QEMU command you used to boot the guest.
- qemu-system-ppc64 --version
-  Host distribution and kernel version.
-  Any other information that you think might help me reproduce the issue.

Thanks,
Sourabh Jain


On 17/08/26 20:59, Timothy Pearson wrote:
> On a POWER9/PowerNV dual CPU host, when launching a pSeries VM via QEMU which exposes more than around 8 guest CPU cores, there is a rapidly increasing probability of a stuck CPU after kexec() runs, which is highly sensitive to the number of cores available in the guest VM.  If an attempt is made to pass through all cores on a 144 core system, multiple stuck CPUs are effectively guaranteed along with an associated boot failure of the guest.
>
> Here is a typical guest dmesg after kexec(), note the CPU 8 stuck message:
>
> [    0.000000] random: crng init done
> [    0.000000] radix-mmu: Page sizes from device-tree:
> [    0.000000] radix-mmu: Page size shift = 12 AP=0x0
> [    0.000000] radix-mmu: Page size shift = 16 AP=0x5
> [    0.000000] radix-mmu: Page size shift = 21 AP=0x1
> [    0.000000] radix-mmu: Page size shift = 30 AP=0x2
> [    0.000000] Activating Kernel Userspace Access Prevention
> [    0.000000] Activating Kernel Userspace Execution Prevention
> [    0.000000] radix-mmu: Mapped 0x0000000000000000-0x0000000002600000 with 2.00 MiB pages (exec)
> [    0.000000] radix-mmu: Mapped 0x0000000002600000-0x0000000040000000 with 2.00 MiB pages
> [    0.000000] radix-mmu: Mapped 0x0000000040000000-0x0000008000000000 with 1.00 GiB pages
> [    0.000000] lpar: Using radix MMU under hypervisor
> [    0.000000] Linux version 6.12.95+deb13-powerpc64le (debian-kernel@lists.debian.org) (powerpc64le-linux-gnu-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP Debian 6.12.95-1 (2026-07-04)
> [    0.000000] OF: reserved mem: Reserved memory: No reserved-memory node in the DT
> [    0.000000] Found initrd at 0xc0000000064f0000:0xc000000007d7979c
> [    0.000000] Hardware name: IBM pSeries (emulated by qemu) POWER9 (architected) 0x4e1203 0xf000005 of:SLOF,HEAD hv:linux,kvm pSeries
> [    0.000000] printk: legacy bootconsole [udbg0] enabled
> [    0.000000] Partition configured for 43 cpus.
> [    0.000000] CPU maps initialized for 1 thread per core
> [    0.000000]  (thread shift is 0)
> [    0.000000] Allocated 1624 bytes for 43 pacas
> [    0.000000] numa: Partition configured for 1 NUMA nodes.
> [    0.000000] -----------------------------------------------------
> [    0.000000] phys_mem_size     = 0x8000000000
> [    0.000000] dcache_bsize      = 0x80
> [    0.000000] icache_bsize      = 0x80
> [    0.000000] cpu_features      = 0x0001c06b8f4f9183
> [    0.000000]   possible        = 0x001ffbebcf5fb187
> [    0.000000]   always          = 0x0000000380008181
> [    0.000000] cpu_user_features = 0xdc0065c2 0xaef00000
> [    0.000000] mmu_features      = 0x1c007641
> [    0.000000] firmware_features = 0x00000885455a445f
> [    0.000000] vmalloc start     = 0xc008000000000000
> [    0.000000] IO start          = 0xc00a000000000000
> [    0.000000] vmemmap start     = 0xc00c000000000000
> [    0.000000] -----------------------------------------------------
> [    0.000000] NODE_DATA(0) allocated [mem 0x7fffa28f00-0x7fffa310ff]
> [    0.000000] rfi-flush: fallback displacement flush available
> [    0.000000] rfi-flush: ori type flush available
> [    0.000000] rfi-flush: mttrig type flush available
> [    0.000000] rfi-flush: patched 12 locations (ori+mttrig type flush)
> [    0.000000] count-cache-flush: hardware flush enabled.
> [    0.000000] link-stack-flush: software flush enabled.
> [    0.000000] entry-flush: patched 61 locations (ori+mttrig type flush)
> [    0.000000] uaccess-flush: patched 1 locations (ori+mttrig type flush)
> [    0.000000] stf-barrier: eieio barrier available
> [    0.000000] stf-barrier: patched 61 entry locations (eieio barrier)
> [    0.000000] stf-barrier: patched 12 exit locations (eieio barrier)
> [    0.000000] PPC64 nvram contains 65536 bytes
> [    0.000000] barrier-nospec: using ORI speculation barrier
> [    0.000000] barrier-nospec: patched 176 locations
> [    0.000000] Top of RAM: 0x8000000000, Total RAM: 0x8000000000
> [    0.000000] Memory hole size: 0MB
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x0000007fffffffff]
> [    0.000000]   Device   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000007fffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000007fffffffff]
> [    0.000000] percpu: Embedded 39 pages/cpu s120472 r0 d39272 u159744
> [    0.000000] pcpu-alloc: s120472 r0 d39272 u159744 alloc=39*4096
> [    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07
> [    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15
> [    0.000000] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 22 [0] 23
> [    0.000000] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] 30 [0] 31
> [    0.000000] pcpu-alloc: [0] 32 [0] 33 [0] 34 [0] 35 [0] 36 [0] 37 [0] 38 [0] 39
> [    0.000000] pcpu-alloc: [0] 40 [0] 41 [0] 42
> [    0.000000] Kernel command line: root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.2:/mnt/udata/nfsroots/ppc64el/astrid,v3,hard,nointr,tcp ip=192.168.2.36::192.168.2.1:255.255.255.0:embed-o-matic:enp0s0:off ast.modeset=0 console=tty0 console=hvc0,115200n8 panic=10 rw
> [    0.000000] Unknown kernel command line parameters "nfsroot=192.168.2.2:/mnt/udata/nfsroots/ppc64el/astrid,v3,hard,nointr,tcp ip=192.168.2.36::192.168.2.1:255.255.255.0:embed-o-matic:enp0s0:off", will be passed to user space.
> [    0.000000] printk: log_buf_len individual max cpu contribution: 4096 bytes
> [    0.000000] printk: log_buf_len total cpu_extra contributions: 172032 bytes
> [    0.000000] printk: log_buf_len min size: 131072 bytes
> [    0.000000] printk: log_buf_len: 524288 bytes
> [    0.000000] printk: early log buf free: 126384(96%)
> [    0.000000] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
> [    0.000000] Fallback order for Node 0: 0
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 134217728
> [    0.000000] Policy zone: Normal
> [    0.000000] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
> [    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=43, Nodes=1
> [    0.000000] ftrace: allocating 38704 entries in 227 pages
> [    0.000000] ftrace: allocated 227 pages with 5 groups
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=43.
> [    0.000000]  Rude variant of Tasks RCU enabled.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=43
> [    0.000000] RCU Tasks Rude: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=43.
> [    0.000000] RCU Tasks Trace: Setting shift to 6 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=43.
> [    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
> [    0.000000] xive: Using IRQ range [0-2a]
> [    0.000000] xive: Interrupt handling initialized with spapr backend
> [    0.000000] xive: Using priority 6 for all interrupts
> [    0.000000] xive: Using 64kB queues
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] time_init: decrementer frequency = 512.000000 MHz
> [    0.000000] time_init: processor frequency   = 2134.000000 MHz
> [    0.000001] time_init: 56 bit decrementer (max: 7fffffffffffff)
> [    0.000735] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
> [    0.002016] clocksource: timebase mult[1f40000] shift[24] registered
> [    0.002809] clockevent: decrementer mult[83126f] shift[24] cpu[0]
> [    0.002967] Console: colour dummy device 80x25
> [    0.003524] printk: legacy console [tty0] enabled
> [    0.004385] printk: legacy console [hvc0] enabled
> [    0.005019] printk: legacy bootconsole [udbg0] disabled
> [    0.005768] pid_max: default: 44032 minimum: 344
> [    0.005904] LSM: initializing lsm=capability,landlock,lockdown,yama,apparmor,tomoyo,bpf,ipe,ima,evm
> [    0.006096] landlock: Up and running.
> [    0.006139] Yama: disabled by default; enable with sysctl kernel.yama.*
> [    0.006342] AppArmor: AppArmor initialized
> [    0.006439] TOMOYO Linux initialized
> [    0.006858] LSM support for eBPF active
> [    0.007186] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.007404] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.008424] POWER9 performance monitor hardware support registered
> [    0.008547] rcu: Hierarchical SRCU implementation.
> [    0.008602] rcu:     Max phase no-delay instances is 1000.
> [    0.008725] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
> [    0.009704] smp: Bringing up secondary CPUs ...
> [    5.021136] Processor 8 is stuck.
> [    5.040206] smp: Brought up 1 node, 42 CPUs
> [    5.040269] numa: Node 0 CPUs: 0-42
> [    5.539085] node 0 deferred pages initialised in 468ms
> [    5.539259] Memory: 528141096K/536870912K available (16428K kernel code, 2300K rwdata, 16340K rodata, 5080K init, 1320K bss, 8695376K reserved, 0K cma-reserved)
> [    5.592658] devtmpfs: initialized
> [    5.604671] PCI host bridge /pci@800000020000000  ranges:
> [    5.604729]   IO 0x0000200000000000..0x000020000000ffff -> 0x0000000000000000
> [    5.604796]  MEM 0x0000200080000000..0x00002000ffffffff -> 0x0000000080000000
> [    5.604861]  MEM 0x0000210000000000..0x000021ffffffffff -> 0x0000210000000000
> [    5.605039] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    5.605248] futex hash table entries: 16384 (order: 9, 2097152 bytes, linear)
> [    5.607696] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    5.607954] audit: initializing netlink subsys (disabled)
> [    5.608195] audit: type=2000 audit(1786980313.572:1): state=initialized audit_enabled=0 res=1
> [    5.608317] thermal_sys: Registered thermal governor 'fair_share'
> [    5.608344] thermal_sys: Registered thermal governor 'bang_bang'
> [    5.608416] thermal_sys: Registered thermal governor 'step_wise'
> [    5.608576] thermal_sys: Registered thermal governor 'user_space'
> [    5.608659] thermal_sys: Registered thermal governor 'power_allocator'
>


