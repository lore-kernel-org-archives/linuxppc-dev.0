Return-Path: <skumar@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E92EDE440
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 05:39:31 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2KIfUwb030330
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:41:30 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2KIdSSP269818
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:39:28 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2KIdRvG013438
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:39:28 -0400
Date: Fri, 21 Mar 2008 00:12:16 +0530
From: Sudhir Kumar <skumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [BUG]2.6.25-rc6:Unable to handle kernel paging request
Message-ID: <20080320184216.GB32259@in.ibm.com>
References: <20080318052921.GA32259@in.ibm.com>
	<18400.36670.5918.566965@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18400.36670.5918.566965@cargo.ozlabs.ibm.com>
Cc: Poornima Nayak <Poornima.Nayak@in.ibm.com>, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, skumar@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org
Reply-To: skumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 02:57:50PM +1100, Paul Mackerras wrote:
> Sudhir Kumar writes:
> 
> > Unable to handle kernel paging request for data at address
> > 0xd00008000000002e
> 
> Looks like some driver tried to access I/O port 0x2e without checking
> whether there was possibly anything there first.
> 
> > Faulting instruction address: 0xc00000000074ded8
> > cpu 0x0: Vector: 300 (Data Access) at [c00000003e073aa0]
> >     pc: c00000000074ded8: .f71805f_find+0x44/0x32c
> >     lr: c00000000074e1f8: .f71805f_init+0x38/0x194
> >     sp: c00000003e073d20
> >    msr: 8000000000009032
> >    dar: d00008000000002e
> >  dsisr: 42000000
> >   current = 0xc0000000220851c0
> >   paca    = 0xc0000000007c2700
> >     pid   = 1, comm = swapper
> > enter ? for help
> > [c00000003e073dc0] c00000000074e1f8 .f71805f_init+0x38/0x194
> 
> Looks like it might be the f71805f driver, whatever that is...
> Hmmm, drivers/hwmon/f71805f.c looks like it, and indeed it does go
> poking around in PCI I/O space with no checks whatever.
> 
> I suggest you turn off CONFIG_SENSORS_F71805F.
It was a new feature so I turned it on while compiling.
I have tried by turning off CONFIG_SENSORS_F71805F but the bug
is still present.
> 
> It doesn't help, of course, that CONFIG_HWMON defaults to y. :(
> 
> Paul.
Thanks
Sudhir Kumar
ISTL IBM
