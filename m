Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6BD77B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 00:54:33 +1000 (EST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE5B0DDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 00:54:32 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id n77EpnNC024530
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Aug 2009 00:51:49 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77EsS441274102
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Aug 2009 00:54:28 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77EsReg005167
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Aug 2009 00:54:28 +1000
Date: Fri, 7 Aug 2009 20:24:05 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090807145405.GB3110@in.ibm.com>
References: <20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia>
	<20090803054919.GA19594@in.ibm.com>
	<20090805164938.GA2970@in.ibm.com>
	<1249568660.20200.23.camel@concordia>
	<20090807143549.GA3110@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090807143549.GA3110@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Neil Horman <nhorman@redhat.com>,
	Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
	miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 08:05:49PM +0530, M. Mohan Kumar wrote:
> Hi,
> 
> After enabling EARLY_DEBUG (and DEBUG in some of the files in
> arch/powerpc/kernel directory), without forcing the dtstruct variable to 8
> byte alignment: 
> 
> # ./kexec -e
> Starting new kernel
> console [udbg0] enabled
>  -> early_setup(), dt_ptr: 0x7723000
>  -> early_init_devtree(c000000007723000)
> Invalid tag 5 scanning flattened device tree !
> search "chosen", depth: 0, uname:
> Invalid tag 5 scanning flattened device tree !
> dt_root_size_cells = 2
> dt_root_addr_cells = 2
> Invalid tag 5 scanning flattened device tree !
> reserving: 128c000 -> 5ec1f7
> reserving: 7734000 -> 8cc000
> reserving: 7723000 -> f698
> Phys. mem: 0
> -> move_device_tree
> <- move_device_tree
> Scanning CPUs ...
> Invalid tag 5 scanning flattened device tree !
>  <- early_init_devtree()
> Probing machine type ...
>   pSeries ...
> No suitable machine found !
> 
> 
> So device-tree is getting corrupted when dtstruct variable is not aligned to
> 8 byte variable. This problem is not seen with gcc-3.4. Is it compiler
> issue? or bug in the code.
> 

I tried writing the device tree to a binary file with and without dt_len and
compared the files after hexdump:

0000 0001 2f00 0000 0000 0003 0000 0004                 0000 0001 2f00 0000 0000 0003 0000 0004
0000 0000 0000 0002 0000 0003 0000 0004                 0000 0000 0000 0002 0000 0003 0000 0004
0000 000f 0000 0002 0000 0003 0000 0004                 0000 000f 0000 0002 0000 0003 0000 0004
0000 001b 3ef1 4800 0000 0003 0000 000d                 0000 001b 3ef1 4800 0000 0003 0000 000d
0000 002b 0000 0000 4942 4d2c 3931 3135               | 0000 002b 4942 4d2c 3931 3135 2d35 3035
2d35 3035 0000 0000 0000 0003 0000 0005               | 0000 0000 0000 0003 0000 0005 0000 0036

Regards,
M. Mohan Kumar






> 
> On Fri, Aug 07, 2009 at 12:24:20AM +1000, Michael Ellerman wrote:
> > On Wed, 2009-08-05 at 22:19 +0530, M. Mohan Kumar wrote:
> > > Hi,
> > > 
> > > When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.
> > > 
> > > When the line
> > > 	static unsigned dtstruct[TREEWORDS], *dt;
> > > changed to 
> > > 	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
> > > 
> > > kexec-tool works.
> > 
> > Hmm, odd.
> > 
> > Can you check how it's aligned without your change? ie. in the original
> > binary, is it 4 byte aligned?
> > 
> > When you make the change, is the only thing that changes in the binary
> > the alignedness of dtstruct, or does it cause other things to move
> > around?
> > 
> > I don't think an unaligned dt blob should have any effect on the kernel,
> > ie. it should copy it in fine, but I'd have to look at the code.
> > 
> > cheers
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
