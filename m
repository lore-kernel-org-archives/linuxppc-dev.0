Return-Path: <anton@ozlabs.org>
Date: Fri, 17 Nov 2006 02:36:16 +1100
From: Anton Blanchard <anton@samba.org>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [RFC] Fix for interrupt distribution
Message-ID: <20061116153616.GA670@krispykreme>
References: <20061030180446.GA24307@in.ibm.com>
	<20061030181751.GI17168@localdomain>
	<20061031110515.GB7884@in.ibm.com>
	<20061106224603.GG6848@localdomain>
	<20061116125637.GB13004@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061116125637.GB13004@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi,

Thanks for fixing this problem. One thing I noticed in the patch:

> +	np = cpuid_to_of_node(boot_cpuid);
> +	BUG_ON(!np);
> +	ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
> +	hcpuid = get_hard_smp_processor_id(boot_cpuid);
> +
> +	if (ireg[0] == hcpuid)
> +		default_distrib_server = ireg[1];
> +	else
> +		default_distrib_server = ireg[3];

While this will work on current firmware it would be more robust to loop
through interrupt-gserver#s until you find your cpuid. For example we
set up multiple interrupt-gserver#s entries in the lab so we can have
chip, node local and global targets:

ibm,ppc-interrupt-server#s
	00000002 00000003

ibm,ppc-interrupt-gserver#s
	00000002 000000ff 00000003 000000ff 00000002 000000f7
	00000003 000000f7 00000002 000000d7
	00000003 000000d7

We always put the global target at the end (0xd7 in this case) because
the current code in Linux just grabs the last entry in the array to get
the global server. So the question is, do we look for the first or the
last entry that matches your cpuid to find the global server?

It might be worth getting something added to the architecture (PAPR) to
clear it up. To match what current Linux does, we would want servers to
go from including the least to the most cpus, so the global one is at
the end.

Anton
