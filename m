Return-Path: <clg@fr.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBE171A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:54:18 +1000 (EST)
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9F10A1400B9
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 16:54:17 +1000 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 26 Jun 2014 07:54:13 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5FB8A1B0804B
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 07:54:43 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5Q6sAmW34734210
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 06:54:10 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5Q6sAqT003483
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 00:54:10 -0600
Message-ID: <53ABC37C.6050101@fr.ibm.com>
Date: Thu, 26 Jun 2014 08:53:48 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc: crash with 3.16.0-rc2
References: <20140626061015.GA13181@us.ibm.com>
In-Reply-To: <20140626061015.GA13181@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Suka,

On 06/26/2014 08:10 AM, Sukadev Bhattiprolu wrote:
> I got the following crash in Open Firmware, on two separate systems
> with recent mainline kernel (3.16.0-rc2). One was a P8 LPAR with no
> changes to kernel and another a Power7 LPAR with some kernel changes
> (24x7 perf counter patches). I will backout the patches and try but
> wanted to check if there is some config change I am missing.
> 
> I am also attaching the config file (which is based on a 3.14
> kernel that boots ok).
> 
> ---
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 3.16.0-rc2-unwind+ (root@saturn-lp2) (gcc version 4.8.2 20131212 (Red Hat 4.8.2-7) (GCC) ) #5 SMP Thu Jun 26 00:01:47 CDT 2014
> Detected machine type: 0000000000000101
> Max number of cores passed to firmware: 256 (NR_CPUS = 1024)
> Calling ibm,client-architecture-support... done
> command line: BOOT_IMAGE=/vmlinux-3.16.0-rc2-unwind root=UUID=017d60b7-9db9-4d91-9dc8-4e6f91b0ed40 ro biosdevname=0 vconsole.font=latarcyrheb-sun16
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 0000000005530000
>   alloc_top    : 0000000010000000
>   alloc_top_hi : 0000000010000000
>   rmo_top      : 0000000010000000
>   ram_top      : 0000000010000000
> instantiating rtas at 0x000000000ee90000... done
> Querying for OPAL presence... not there.

A patch from Michael Ellerman was just merged : 

	powerpc/powernv: Remove OPAL v1 takeover

I think it fixes the problem you are seeing.

Cheers,

C. 


> DEFAULT CATCH!, exception-handler=fff00700 
> at   %SRR0: 0000000004133064   %SRR1: 8000000000081002 
> Open Firmware exception handler entered from non-OF code
> 
> Client's Fix Pt Regs:
>  00 0000000004133030 0000000004133018 00000000047b1b28 0000000000000002
>  04 0000000028005024 00000000047b1b28 0000000000001002 0000000004132f18
>  08 0000000000000000 0000000000000000 0000000004132f18 0000000000001002
>  0c a000000000000001 0000000000000000 0000000001a3fd20 000000000401bb70
>  10 000000000401c030 000000000401bd70 fffffffffffffffd 0000000001a3fd20
>  14 0000000001b49080 000000000ee90000 0000000001170000 000000000ee90000
>  18 000000000401c510 0000000003690000 000000000401bb28 0000000004193da0
>  1c 0000000001a3fd60 794927e391410070 e87f0000408204cc 3cc2ff8b38c629d8
> Special Regs:
>     %IV: 00000700     %CR: 28005022    %XER: 00000000  %DSISR: 42000000 
>   %SRR0: 0000000004133064   %SRR1: 8000000000081002 
>     %LR: 0000000004133030    %CTR: 0000000000000000 
>    %DAR: 01a3fcf00020b4ac 
> Virtual PID = 0 
>  ok
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
