Return-Path: <mohan@in.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 887F4DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 02:16:22 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9NFFgHT031558
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 09:15:42 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9NFG4HN051992
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 09:16:06 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9NFG3EF030862
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 09:16:04 -0600
Message-ID: <4900952A.3090605@in.ibm.com>
Date: Thu, 23 Oct 2008 20:45:54 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running
	relocatable
References: <kexec-kern-2@bga.com>
In-Reply-To: <kexec-kern-2@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org,
	Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Milton,

My suggestions:

Milton Miller wrote:
> The __kdump_flag ABI is overly constraining for future development.  
> 
> As of 2.6.27, the kernel entry point has 4 constraints:  Offset 0 is
> the starting point for the master (boot) cpu (entered with r3 pointing
> to the device tree structure), offset 0x60 is code for the slave cpus
> (entered with r3 set to their device tree physical id), offset 0x20 is
> used by the iseries hypervisor, and secondary cpus must be well behaved
> when the first 256 bytes are copied to address 0.
> 
> Placing the __kdump_flag at 0x18 is bad because:
> 
> - It was taking the last 8 bytes before the iseries hypervisor data.  
> - It was 8 bytes for a boolean flag
> - It had no way of identifying that the flag was present
> - It does leave any room for the master to add any additional code
>   before branching, which hurts debug.
> - It will be unnecessarily hard for 32 bit code to be common (8 bytes)
> 
> Now that we have eliminated the use of __kdump_flag in favor of
> the standard is_kdump_kernel(), this flag only controls run without
> relocating the kernel to PHYSICAL_START (0), so rename it __run_at_load.
>
We could try both of our approaches. Instead of passing the information 
that next kernel should be relocatable from kexec_sequence to purgatory 
code, we will do it from kexec-tools path (following your approach). But 
instead of setting the __run_at_load value in the purgatory code (ie at 
physical address 0x5c), we will set the variable __run_at_load at kernel 
  image itself.

i.e.,
[code snip 1]
	lwz	r7,__run_at_load-_stext(r26)
	cmplwi	cr0,r7,1	/* kdump kernel ? - stay where we are */
  	bne	1f
  	add	r25,r25,r26

	lwz	r7,__run_at_load-_stext(r26)
	cmplwi	cr0,r7,1
  	bne	3f

kexec-tools
[code snip 2]
	LOADADDR(6,run_at_load)
	ld	18,0(6)
	cmpd	18,1
	bne	skip
	li	7,1
	stw	7,92(4)		# mark __run_at_load flag at kernel
skip:
	lwz	7,0(4)		# get the first instruction that we stole
	stw	7,0(0)		# and put it in the slave loop at 0
  				# skip cache flush, do we care?

[code snip 3]
	if (info->kexec_flags & KEXEC_ON_CRASH) {
		....
		elf_rel_set_symbol(&info->rhdr, "run_at_load",
                                 &my_run_at_load, 							 
sizeof(my_run_at_load));
	}

Using this approach we are not breaking the kexec_sequence ABI and we 
directly modifying the flag in kernel image.

Regards,
Mohan.
