Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CDAAB7CFA
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 03:48:23 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o39HidTm019000
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 03:44:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o39Hg1fl1126614
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 03:42:01 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o39HmMqu016197
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 03:48:22 +1000
Message-ID: <4BBF6862.3010600@in.ibm.com>
Date: Fri, 09 Apr 2010 23:18:18 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: [-next April 8] eHEA driver failure on powerpc
References: <20100408155113.ef8df30c.sfr@canb.auug.org.au>
	<4BBDC447.3040901@in.ibm.com>
In-Reply-To: <4BBDC447.3040901@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev <netdev@vger.kernel.org>, linux-next@vger.kernel.org,
	Anton Blanchard <anton@samba.org>, HERING2@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> With today's next release, eHEA network interface on couple
> of power6 boxes fails to initialize.
>
> # modprobe ehea
> IBM eHEA ethernet device driver (Release EHEA_0102)
>  alloc irq_desc for 256 on node 0
>  alloc kstat_irqs on node 0
> irq: irq 590080 on host null mapped to virtual irq 256
> ehea: Error in ehea_plpar_hcall_norets: opcode=26c 
> ret=fffffffffffffffc arg1=8000000003000000 arg2=0 
> arg3=7000000000050400 arg4=fc9b0000 arg5=200 arg6=0 arg7=0
> ehea: Error in ehea_reg_mr_section: register_rpage_mr failed
> ehea: Error in ehea_reg_kernel_mr: registering mr failed
> ehea: Error in ehea_setup_ports: creating MR failed
> ehea 23c00200.lhea: setup_ports failed
> ehea: probe of 23c00200.lhea failed with error -5
I tracked this problem to the following commit.

commit 7545ba6f82924d4523f8f8a2baf2e517a750265d
powerpc/mm: Bump SECTION_SIZE_BITS from 16MB to 256MB

If i revert this commit, the network interface is initialized
properly. Verified this on two different power6 boxes.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
