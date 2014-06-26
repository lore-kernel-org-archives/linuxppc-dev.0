Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 342D01A000D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 18:22:22 +1000 (EST)
Message-ID: <1403770940.18572.7.camel@concordia>
Subject: Re: powerpc: crash with 3.16.0-rc2
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cedric Le Goater <clg@fr.ibm.com>
Date: Thu, 26 Jun 2014 18:22:20 +1000
In-Reply-To: <53ABC37C.6050101@fr.ibm.com>
References: <20140626061015.GA13181@us.ibm.com> <53ABC37C.6050101@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-06-26 at 08:53 +0200, Cedric Le Goater wrote:
> Hi Suka,
> 
> On 06/26/2014 08:10 AM, Sukadev Bhattiprolu wrote:
> > I got the following crash in Open Firmware, on two separate systems
> > with recent mainline kernel (3.16.0-rc2). One was a P8 LPAR with no
> > changes to kernel and another a Power7 LPAR with some kernel changes
> > (24x7 perf counter patches). I will backout the patches and try but
> > wanted to check if there is some config change I am missing.
> > 
> > I am also attaching the config file (which is based on a 3.14
> > kernel that boots ok).
> > 
> > ---
> > OF stdout device is: /vdevice/vty@30000000
> > Preparing to boot Linux version 3.16.0-rc2-unwind+ (root@saturn-lp2) (gcc version 4.8.2 20131212 (Red Hat 4.8.2-7) (GCC) ) #5 SMP Thu Jun 26 00:01:47 CDT 2014
> > Detected machine type: 0000000000000101
> > Max number of cores passed to firmware: 256 (NR_CPUS = 1024)
> > Calling ibm,client-architecture-support... done
> > command line: BOOT_IMAGE=/vmlinux-3.16.0-rc2-unwind root=UUID=017d60b7-9db9-4d91-9dc8-4e6f91b0ed40 ro biosdevname=0 vconsole.font=latarcyrheb-sun16
> > memory layout at init:
> >   memory_limit : 0000000000000000 (16 MB aligned)
> >   alloc_bottom : 0000000005530000
> >   alloc_top    : 0000000010000000
> >   alloc_top_hi : 0000000010000000
> >   rmo_top      : 0000000010000000
> >   ram_top      : 0000000010000000
> > instantiating rtas at 0x000000000ee90000... done
> > Querying for OPAL presence... not there.
> 
> A patch from Michael Ellerman was just merged : 
> 
> 	powerpc/powernv: Remove OPAL v1 takeover
> 
> I think it fixes the problem you are seeing.

Yes it should.

cheers
