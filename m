Return-Path: <mkravetz@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FA7667B2B
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 03:04:47 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k56Gl7Vh001685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 12:47:07 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k56Gl2u5009896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 12:47:02 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k56Gl2CM148054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 12:47:02 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k56Gl1q1010380
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 12:47:02 -0400
Date: Tue, 6 Jun 2006 09:46:46 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Christopher Yeoh <cyeoh@samba.org>
Subject: Re: Collecting hypervisor call stats
Message-ID: <20060606164646.GA3161@w-mikek2.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<AEFF6654-C958-42F7-93CF-64103B015CB1@watson.ibm.com>
	<17534.30511.192632.558778@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17534.30511.192632.558778@localhost.localdomain>
Cc: Chris Yeoh <yeohc@au1.ibm.com>, Bryan Rosenburg <rosnbrg@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 01, 2006 at 03:12:15PM +1000, Christopher Yeoh wrote:
> Here's a patch we've used for collecting hcall counts and times.

Thanks for the patch/code Chris!  I'm using this as a basis for something
that we may want to merge into the tree.  Just a couple of questions.

Your 'wrappers' have the following general form:

> +long plpar_hcall(unsigned long opcode, unsigned long arg1,
> +			unsigned long arg2, unsigned long arg3,
> +			unsigned long arg4, unsigned long *out1,
> +			unsigned long *out2, unsigned long *out3)
> +{
> +    long retcode;
> +    unsigned long t_entry;
> +    int opcode_index;
> +    
> +    opcode_index = map_hcall_to_index(opcode);
> +    
> +    t_entry = mfspr(SPRN_PURR);
> +    barrier();
> +    
> +    retcode = plpar_hcall_real(opcode, arg1, arg2, arg3, arg4,
> +			       out1, out2, out3);
> +    
> +    barrier();
> +    get_cpu_var(hcall_type_count)[opcode_index]++;
> +    put_cpu_var(hcall_type_count);
> +    get_cpu_var(hcall_type_time)[opcode_index] += mfspr(SPRN_PURR) - t_entry;
> +    put_cpu_var(hcall_type_time);
> +    
> +    return retcode;
> +};

Can you explain the need for barrier(s) before and after the call to the
real routine?  It usually takes me a couple days of thought to figure out
exactly where these are needed. :)

The use of get_cpu_var/put_cpu_var result in disabling/enabling preemption.
I can understand why this would be desirable to assure the accuracy of the
statistics.  But, I was wondering if the desired accuracy is worth the added
overhead.  My thought was to make these as lightweight as possible and
sacrifice some accuracy if necessary.  After all, no 'internal decisions' are
being made because of this data.  It is simply exposed to user land.
Thoughts?

Thanks,
-- 
Mike
