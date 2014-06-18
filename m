Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B765D1A02CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 13:27:19 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 18 Jun 2014 13:27:13 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BF3B03578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 13:27:10 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5I3QsWn56492192
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 13:26:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5I3R9sY004994
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 13:27:09 +1000
Received: from localhost.localdomain (dhcp-9-111-29-66.cn.ibm.com
 [9.111.29.66])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s5I3R8pl004958
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 13:27:09 +1000
Message-ID: <53A1070C.50106@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2014 11:27:08 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Boot failure in Power7 pSeries
References: <53A00E2B.8030903@linux.vnet.ibm.com>
In-Reply-To: <53A00E2B.8030903@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anyone has a idea on this issue?

Thanks
Mike
On 06/17/2014 05:45 PM, Mike Qiu wrote:
> Hi all,
>
> I use newest linux-next( top commit: 
> 5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) to boot up my Power7 
> machine, PowerVM mode(HypMode 01), use defualt config file in /boot/, 
> it show error log below:
>
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 3.16.0-rc1-next-20140617+ (root@shui) 
> (gcc version 4.8.2 20131212 (Red Hat 4.8.2-7) (GCC) ) #5 SMP Tue Jun 
> 17 05:16:21 EDT 2014
> Detected machine type: 0000000000000101
> Max number of cores passed to firmware: 256 (NR_CPUS = 1024)
> Calling ibm,client-architecture-support... done
> command line: BOOT_IMAGE=/vmlinux-3.16.0-rc1-next-20140617+ 
> root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/swap rd.md=0 rd.dm=0 
> vconsole.keymap=us rd.luks=0 vconsole.font=latarcyrheb-sun16 rd.lvt
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 0000000005910000
>   alloc_top    : 0000000010000000
>   alloc_top_hi : 0000000010000000
>   rmo_top      : 0000000010000000
>   ram_top      : 0000000010000000
> instantiating rtas at 0x000000000ee80000... done
> Querying for OPAL presence... DEFAULT CATCH!, exception-handler=fff00700
> at   %SRR0: 00000000041a1c14   %SRR1: 0000000000081002
> Open Firmware exception handler entered from non-OF code
>
> Client's Fix Pt Regs:
>  00 00000000042c017c 00000000042c2ce8 0000000004ae8d58 00000000042c2f38
>  04 000000000369aafc 00000000042c2f38 0000000001adc100 00000000042c2f38
>  08 0000000000000000 0000000004328d58 0000000028002024 0000000000001002
>  0c a000000000000001 0000000000000000 0000000001a9fd20 00000000041a7df8
>  10 00000000041a2130 00000000041a1e70 f821ff913d220005 0000000001a9fd20
>  14 0000000000007962 000000000ee80000 0000000001180000 000000000ee80000
>  18 00000000041a2610 0000000003690000 00000000042c3070 00000000041a1ce8
>  1c 00000000041a1ce0 00000000041b89f0 0000000000000003 0000000000000001
> Special Regs:
>     %IV: 00000700     %CR: 48002024    %XER: 00000000  %DSISR: 40000000
>   %SRR0: 00000000041a1c14   %SRR1: 0000000000081002
>     %LR: 000000000369aafc    %CTR: 0000000000000000
>    %DAR: f821ff913d220035
> Virtual PID = 0
>  ok
> 0 >
>
> Thanks
> Mike
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
