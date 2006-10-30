Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id A33A067D57
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 05:18:01 +1100 (EST)
Date: Mon, 30 Oct 2006 12:17:51 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [RFC] Fix for interrupt distribution
Message-ID: <20061030181751.GI17168@localdomain>
References: <20061030180446.GA24307@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061030180446.GA24307@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M wrote:
> Hello,
> 
> When kdump kernel is booted with the parameter "maxcpus=1" on a threaded
> CPU, we faced some interrupt routing problems.
> 
> In the xics initialization code, "reg" property in each cpu node
> (device-tree/cpus/PowerPC,POWER5@x) is used to match the current boot
> cpu id and based on that "default_server" and "default_distrib_server"
> are calculated. This condition will always meet when OF chooses CPU0 as
> boot cpu or crash happenes on any cpu whose id is any physical cpu id.
> 
> The "reg" property in cpu node gives the id of the cpu and this cpu node
> is created only for physical cpus (not for logical/threaded cpus). The
> code compares the "reg" value to the current boot cpu id and if it
> matches then only it reads "ibm,ppc-interrupt-gserver#s" and assigns the
> last value of it (which is usually 0xff) to default_distrib_server. So
> when a crash occurs on CPU 3, it will not be able to match the condition
> and thus default_distrib_server is left as zero only. This makes all
> interrupts routed to cpu 0 but cpu 0 is not up because of "maxcpus=1"
> parameter.
> 
> To overcome this, I have just added one more condition to check the
> above condition. I have attached the patch also. Patch is generated over
> 2.6.19-rc3.
> 
> One more idea will be instead of using "reg" property in each cpu node,
> can we use "ibm,ppc-interrupt-gserver#s" to determine the distribution
> server? "ibm,ppc-interrupt-gserver#s" format is (please correct
> if I am wrong) 
> 	phys_cpu_id distrib_server logical_cpu_id distrib_server

Firmware has no notion of Linux's logical cpu numbering.


> In a Dual core SMT enabled system, "ibm,ppc-interrupt-gserver#s" will
> be: 
> 
> 	00000002 000000ff 00000003 000000ff
> 	 ^ phys cpu id
>         	  ^ distribution server
>                 	      ^ logical cpu id
>                         	       ^ distribution server
> 
> Tested on POWER5 box.
> 
> Since POWER4 does not have SMT, crash can happen on any CPU and kdump
> kernel can boot with "maxcpus=1" without any problem.
> 
> 
> 
> Allow any cpu to become boot cpu.
> 
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
> ---
> 
> Index: test/linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- test.orig/linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
> +++ test/linux-2.6.19-rc3/arch/powerpc/platforms/pseries/xics.c
> @@ -687,7 +687,8 @@ void __init xics_init_IRQ(void)
>  	     np;
>  	     np = of_find_node_by_type(np, "cpu")) {
>  		ireg = get_property(np, "reg", &ilen);
> -		if (ireg && ireg[0] == get_hard_smp_processor_id(boot_cpuid)) {
> +		if (ireg && ((ireg[0] == get_hard_smp_processor_id(boot_cpuid))
> +		  || (ireg[0] == get_hard_smp_processor_id(boot_cpuid) - 1))) {
>  			ireg = get_property(np,
>  					"ibm,ppc-interrupt-gserver#s", &ilen);
>  			i = ilen / sizeof(int);

NAK

We can't assume any arithmetic relationship between the
"hard"/platform thread ids; it's completely unspecified.  I bet this
patch happens to work on your system but will fail on others.
