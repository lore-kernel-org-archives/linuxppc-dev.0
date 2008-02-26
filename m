Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28esmtp07.in.ibm.com (e28smtp07.in.ibm.com [59.145.155.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CC73DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 05:18:37 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id m1QIIWme025114
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 23:48:32 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1QIIWjJ1007830
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 23:48:32 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m1QIIbao002676
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 18:18:37 GMT
Message-ID: <47C457F5.4080902@linux.vnet.ibm.com>
Date: Tue, 26 Feb 2008 23:48:29 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [BUILD_FAILURE] Linux 2.6.25-rc3 - various unexported functions
	() on powerpc
References: <alpine.LFD.1.00.0802241354200.14934@woody.linux-foundation.org>
	<47C42234.6060906@linux.vnet.ibm.com>
	<20080226151512.GA10717@cs181133002.pp.htv.fi>
In-Reply-To: <20080226151512.GA10717@cs181133002.pp.htv.fi>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, sam@ravnborg.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk wrote:
> On Tue, Feb 26, 2008 at 07:59:08PM +0530, Kamalesh Babulal wrote:
>> Hi,
>>
>> The 2.6.25-rc3 kernel build fails on powerpc with allyesconfig config option,
>> the .config has been attached.
>> ...
> 
> Builds fine here.
> 
> Local problem (e.g. disk full) on your machine?
> 
> cu
> Adrian
> 
Hi Adrain,

It Builds fine on another powerpc box with the same .config file, the problem seems to be with the gcc
on that box, the reported build failure might have been the side effect of the same. 


drivers/md/raid6int8.c: In function `raid6_int8_gen_syndrome':
drivers/md/raid6int8.c:185: error: unable to find a register to spill in class `FLOAT_REGS'
drivers/md/raid6int8.c:185: error: this is the insn:
(insn:HI 619 799 638 4 drivers/md/raid6int8.c:168 (set (mem:DI (plus:DI (reg/v/f:DI 122 [ p ])
                (reg/v:DI 66 ctr [orig:124 d ] [124])) [0 S8 A64])
        (reg/v:DI 129 [ wp0 ])) 320 {*movdi_internal64} (nil)
    (expr_list:REG_DEAD (reg/v:DI 129 [ wp0 ])
        (nil)))
drivers/md/raid6int8.c:185: confused by earlier errors, bailing out
make[2]: *** [drivers/md/raid6int8.o] Error 1
make[1]: *** [drivers/md] Error 2
make: *** [drivers] Error 2

# gcc --version
gcc (GCC) 3.4.6 20060404 (Red Hat 3.4.6-3)

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
