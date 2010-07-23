Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B83391007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 14:13:23 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id o6N4DJdG027850
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2010 09:43:19 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N4DIJU3498000
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2010 09:43:18 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N4DH8V026485
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jul 2010 09:43:18 +0530
Date: Fri, 23 Jul 2010 09:43:09 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Robert Jennings <rcj@linux.vnet.ibm.com>,
	Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Gautham R Shenoy <ego@in.ibm.com>,
	Julia Lawall <julia@diku.dk>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: ONLINE to OFFLINE CPU state transition during
	removal
Message-ID: <20100723041309.GB4728@dirshya.in.ibm.com>
References: <20100723024343.GC32534@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100723024343.GC32534@linux.vnet.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Robert Jennings <rcj@linux.vnet.ibm.com> [2010-07-22 21:43:44]:

> If a CPU remove is attempted using the 'release' interface on hardware
> which supports extended cede, the CPU will be put in the INACTIVE state
> rather than the OFFLINE state due to the default preferred_offline_state
> in that situation.  In the INACTIVE state it will fail to be removed.
> 
> This patch changes the preferred offline state to OFFLINE when an CPU is
> in the ONLINE state.  After cpu_down() is called in dlpar_offline_cpu()
> the CPU will be OFFLINE and CPU removal can continue.

Hi Robert,

Thanks for the patch.  In dlpar operation, we would offline the CPU
first using the sysfs online file and then write to the sysfs release
file to complete the sequence right?  The current code in
dlpar_offline_cpu() would work as long as the cpu is in either
inactive state or offline state (in case of unsupported platform).

Is the dlpar tools being changed to complete the operation with one
sysfs write to release file?

> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> 
> ---
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index d71e585..227c1c3 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -463,6 +463,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
>  				break;
> 
>  			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
> +				set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
>  				cpu_maps_update_done();
>  				rc = cpu_down(cpu);
>  				if (rc)

The patch looks good.  Will need to test out the various scenarios so
that the preferred_offline_state do not get flipped before cpu_down()
is called.  This is unlikely, but still we need to validate
a concurrent sysfs online file write and sysfs release file write.

--Vaidy
