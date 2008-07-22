Return-Path: <mohan@in.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0A2EDE097
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 17:58:49 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6M7wkd2026541
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 03:58:46 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6M7wksa205658
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 03:58:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6M7wjxr012460
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 03:58:46 -0400
Message-ID: <4885932C.2070008@in.ibm.com>
Date: Tue, 22 Jul 2008 13:28:36 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC v3 PATCH 1/4] Extract list of relocation offsets
References: <20080717183339.GA25070@in.ibm.com>
	<20080717184055.GB25070@in.ibm.com>
	<1216325187.7740.353.camel@pasglop> <48802AE0.30105@in.ibm.com>
	<d8d07a180aaf59d25936ad03c7287f5a@bga.com>
	<4884E0AF.2070809@in.ibm.com>
	<18565.32335.641560.254806@cargo.ozlabs.ibm.com>
In-Reply-To: <18565.32335.641560.254806@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: naren@linux.vnet.ibm.com, Milton Miller <miltonm@bga.com>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Mohan Kumar M writes:
> 
>> diff --git a/arch/powerpc/boot/relocs.c b/arch/powerpc/boot/relocs.c
>> new file mode 100644
>> index 0000000..31ca903
> 
> Where did this file come from?  Did you write it all yourself?  If
> not, then you need to credit the original author in the patch
> description at least.  Also it needs a copyright notice.
> 
> There is some evidence that this has been copied from a similar
> program for x86.  For instance, this:

Hi Paul,

Yes, its taken from x86 relocs.c. I will include proper credits to the 
original author in the next patch.

> 
> Also, this:
> 
> +		if (shdr[i].sh_type == SHT_REL) {
> +			reltab[i] = malloc(shdr[i].sh_size);
> +			if (!reltab[i]) {
> +				die("malloc of %d bytes for relocs failed\n",
> +					shdr[i].sh_size);
> +			}
> +			relp = reltab[i];
> 
> is, I think, unnecessary, since as far as I know we never get SHT_REL
> sections on powerpc.

Ok, I will remove SHT_REL code in the relocs.c file.

Regards,
Mohan.
