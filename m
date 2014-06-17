Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B21081A0280
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 19:45:25 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 17 Jun 2014 15:15:20 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3ACBF394004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:15:17 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5H9kHfW49152142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:16:17 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5H9jG8j006192
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:15:16 +0530
Received: from localhost.localdomain (dhcp-9-111-29-121.cn.ibm.com
 [9.111.29.121])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5H9jFXR006074
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 15:15:16 +0530
Message-ID: <53A00E2B.8030903@linux.vnet.ibm.com>
Date: Tue, 17 Jun 2014 17:45:15 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-dev@lists.ozlabs.org>
Subject: Boot failure in Power7 pSeries
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I use newest linux-next( top commit: 
5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) to boot up my Power7 machine, 
PowerVM mode(HypMode 01), use defualt config file in /boot/, it show 
error log below:

OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 3.16.0-rc1-next-20140617+ (root@shui) 
(gcc version 4.8.2 20131212 (Red Hat 4.8.2-7) (GCC) ) #5 SMP Tue Jun 17 
05:16:21 EDT 2014
Detected machine type: 0000000000000101
Max number of cores passed to firmware: 256 (NR_CPUS = 1024)
Calling ibm,client-architecture-support... done
command line: BOOT_IMAGE=/vmlinux-3.16.0-rc1-next-20140617+ 
root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap rd.md=0 rd.dm=0 
vconsole.keymap=us rd.luks=0 vconsole.font=latarcyrheb-sun16 rd.lvt
memory layout at init:
   memory_limit : 0000000000000000 (16 MB aligned)
   alloc_bottom : 0000000005910000
   alloc_top    : 0000000010000000
   alloc_top_hi : 0000000010000000
   rmo_top      : 0000000010000000
   ram_top      : 0000000010000000
instantiating rtas at 0x000000000ee80000... done
Querying for OPAL presence... DEFAULT CATCH!, exception-handler=fff00700
at   %SRR0: 00000000041a1c14   %SRR1: 0000000000081002
Open Firmware exception handler entered from non-OF code

Client's Fix Pt Regs:
  00 00000000042c017c 00000000042c2ce8 0000000004ae8d58 00000000042c2f38
  04 000000000369aafc 00000000042c2f38 0000000001adc100 00000000042c2f38
  08 0000000000000000 0000000004328d58 0000000028002024 0000000000001002
  0c a000000000000001 0000000000000000 0000000001a9fd20 00000000041a7df8
  10 00000000041a2130 00000000041a1e70 f821ff913d220005 0000000001a9fd20
  14 0000000000007962 000000000ee80000 0000000001180000 000000000ee80000
  18 00000000041a2610 0000000003690000 00000000042c3070 00000000041a1ce8
  1c 00000000041a1ce0 00000000041b89f0 0000000000000003 0000000000000001
Special Regs:
     %IV: 00000700     %CR: 48002024    %XER: 00000000  %DSISR: 40000000
   %SRR0: 00000000041a1c14   %SRR1: 0000000000081002
     %LR: 000000000369aafc    %CTR: 0000000000000000
    %DAR: f821ff913d220035
Virtual PID = 0
  ok
0 >

Thanks
Mike
