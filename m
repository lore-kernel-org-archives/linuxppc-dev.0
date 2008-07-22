Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3D3EDE7D7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 04:49:58 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6MIngBR002800
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:49:42 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6MIngmB197962
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:49:42 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6MIngwe008413
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 14:49:42 -0400
Message-ID: <48862BC5.2060701@austin.ibm.com>
Date: Tue, 22 Jul 2008 13:49:41 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 04/16 v3] powerpc: Split retrieval of processor entitlement
	data into a helper routine
References: <20080704124449.GA1310@linux.vnet.ibm.com>	<20080704125207.GE1310@linux.vnet.ibm.com>
	<18565.30231.361341.295825@cargo.ozlabs.ibm.com>
In-Reply-To: <18565.30231.361341.295825@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Robert Jennings writes:
> 
>> Split the retrieval of processor entitlement data returned in the H_GET_PPP
>> hcall into its own helper routine.
> 
> This seems to change the value reported for pool_capacity radically:
> 
>>  		/* report pool_capacity in percentage */
>> -		seq_printf(m, "pool_capacity=%ld\n",
>> -			   ((h_resource >> 2 * 8) & 0xffff) * 100);
>> +		seq_printf(m, "pool_capacity=%d\n", ppp_data.group_num * 100);
> 
> On a Power6 partition here with your patch series applied, I see
> 
> pool_capacity=3277200
> 
> in /proc/ppc64/lparcfg.  Without your patches, I get
> 
> pool_capacity=400
> pool_idle_time=0
> pool_num_procs=0
>
> This looks like an incompatible user-visible change to me, and we
> haven't even changed the lparcfg version number at the beginning of
> the /proc/ppc64/lparcfg output.  Why is the pool_capacity so
> different, and why do the pool_idle_time and pool_num_procs lines
> disappear?
>

ok, three problems, three new patches.

The reporting of pool_capacity was a bug in using the wrong information
reported by h_get_ppp in the patch.  This is in a new patch 4/16.

The failure to report the pool_idle_time and pool_num_procs was due to
an update to h_pic where we started checking the return code of the
h_call for H_PIC.  The values were not reported if the h_call fails,
which on my partition it fails with -10 (H_Authority).  I have reverted
this back to the previous behavior and report the values of pool_idle_time
and pool_num_procs regardless of the h_call return code.  This is
in a new patch 2/16.

Yes, the lparcfg version number should have been updated.  I missed that.
Fixed in a new patch 3/16.

-Nathan 
 
> Regards,
> Paul.
