Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1CAB67F31
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 15:41:37 +1000 (EST)
Date: Thu, 11 Aug 2005 19:45:23 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050811224523.GA5395@dmt.cnet>
References: <42FA3636.7010804@ru.mvista.com> <42FA3D7B.8040200@ru.mvista.com>
	<42FA4108.9090808@ru.mvista.com>
	<4BA092C9-1517-416E-9C98-90F9D8F41857@freescale.com>
	<20050811053032.GF5665@dmt.cnet> <42FB6DE0.4070506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42FB6DE0.4070506@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] identify_ppc_sys_by_name_and_id function implementation
	final
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2005 at 07:25:20PM +0400, Vitaly Bordug wrote:
> Marcelo Tosatti wrote:
> >On Wed, Aug 10, 2005 at 02:16:57PM -0500, Kumar Gala wrote:
> >
> >>+static int __init find_chip_by_name_and_id(char *name, u32 id)
> >>+{
> >>+    int ret = -1;
> >>+    unsigned int i = 0;
> >>+    unsigned int j = 0;
> >>+    unsigned int dups = 0;
> >>+
> >>+    unsigned int matched[count_sys_specs()];
> >>
> >>Is is legit in the kernel to use dynamically sized array?
> >
> >
> >kmalloc() is certainly safer - why not use it? 
> Practically , version with kmalloc works, but  setup_arch and thus this 
> function is called before mem_init, so I just wonder if kmalloc can 
> handle this case. On the other hand, I don't like to deal with
> alloc_bootmem() if mem_init_done!=1 and kmalloc otherwise (like ocp 
> does) just for the temporary buffer.
> 
> But it's the only _right_ way (or I 've missed something) - sure I'll 
> follow it.

I dont see any problem with dynamic array usage on the kernel (maybe someone
else has good argumentation against it).

Just that you have a 4kb stack. Does count_sys_specs() have an appropriate
maximum?
