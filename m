Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 6AD00DDF2F
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 05:26:52 +1100 (EST)
Date: Tue, 26 Feb 2008 20:25:45 +0200
From: Adrian Bunk <bunk@kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD_FAILURE] Linux 2.6.25-rc3 - various unexported
	functions () on powerpc
Message-ID: <20080226182545.GE8287@cs181133002.pp.htv.fi>
References: <alpine.LFD.1.00.0802241354200.14934@woody.linux-foundation.org>
	<47C42234.6060906@linux.vnet.ibm.com>
	<20080226151512.GA10717@cs181133002.pp.htv.fi>
	<47C457F5.4080902@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <47C457F5.4080902@linux.vnet.ibm.com>
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

On Tue, Feb 26, 2008 at 11:48:29PM +0530, Kamalesh Babulal wrote:
> Adrian Bunk wrote:
> > On Tue, Feb 26, 2008 at 07:59:08PM +0530, Kamalesh Babulal wrote:
> >> Hi,
> >>
> >> The 2.6.25-rc3 kernel build fails on powerpc with allyesconfig config option,
> >> the .config has been attached.
> >> ...
> > 
> > Builds fine here.
> > 
> > Local problem (e.g. disk full) on your machine?
> > 
> > cu
> > Adrian
> > 
> Hi Adrain,

Hi Kamalseh,  ;)

> It Builds fine on another powerpc box with the same .config file, the problem seems to be with the gcc
> on that box, the reported build failure might have been the side effect of the same. 
> 
> 
> drivers/md/raid6int8.c: In function `raid6_int8_gen_syndrome':
> drivers/md/raid6int8.c:185: error: unable to find a register to spill in class `FLOAT_REGS'
> drivers/md/raid6int8.c:185: error: this is the insn:
> (insn:HI 619 799 638 4 drivers/md/raid6int8.c:168 (set (mem:DI (plus:DI (reg/v/f:DI 122 [ p ])
>                 (reg/v:DI 66 ctr [orig:124 d ] [124])) [0 S8 A64])
>         (reg/v:DI 129 [ wp0 ])) 320 {*movdi_internal64} (nil)
>     (expr_list:REG_DEAD (reg/v:DI 129 [ wp0 ])
>         (nil)))
> drivers/md/raid6int8.c:185: confused by earlier errors, bailing out
> make[2]: *** [drivers/md/raid6int8.o] Error 1
> make[1]: *** [drivers/md] Error 2
> make: *** [drivers] Error 2
> 
> # gcc --version
> gcc (GCC) 3.4.6 20060404 (Red Hat 3.4.6-3)

this means your quite old vendor gcc has a bug.

> Thanks & Regards,
> Kamalesh Babulal,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
