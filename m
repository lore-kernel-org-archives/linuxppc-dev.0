Return-Path: <nfont@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62FD1B70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 05:13:42 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6QJ01D1030121
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2010 15:00:01 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6QJDbYX1417292
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2010 15:13:37 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6QJDaoV015131
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jul 2010 16:13:37 -0300
Message-ID: <4C4DDE5F.7090207@austin.ibm.com>
Date: Mon, 26 Jul 2010 14:13:35 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc: ONLINE to OFFLINE CPU state transition during
	removal
References: <20100723024343.GC32534@linux.vnet.ibm.com>
	<20100723041309.GB4728@dirshya.in.ibm.com>
In-Reply-To: <20100723041309.GB4728@dirshya.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gautham R Shenoy <ego@in.ibm.com>, Julia Lawall <julia@diku.dk>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2010 11:13 PM, Vaidyanathan Srinivasan wrote:
> * Robert Jennings <rcj@linux.vnet.ibm.com> [2010-07-22 21:43:44]:
> 
>> If a CPU remove is attempted using the 'release' interface on hardware
>> which supports extended cede, the CPU will be put in the INACTIVE state
>> rather than the OFFLINE state due to the default preferred_offline_state
>> in that situation.  In the INACTIVE state it will fail to be removed.
>>
>> This patch changes the preferred offline state to OFFLINE when an CPU is
>> in the ONLINE state.  After cpu_down() is called in dlpar_offline_cpu()
>> the CPU will be OFFLINE and CPU removal can continue.
> 
> Hi Robert,
> 
> Thanks for the patch.  In dlpar operation, we would offline the CPU
> first using the sysfs online file and then write to the sysfs release
> file to complete the sequence right?  The current code in
> dlpar_offline_cpu() would work as long as the cpu is in either
> inactive state or offline state (in case of unsupported platform).
> 
> Is the dlpar tools being changed to complete the operation with one
> sysfs write to release file?

The dlpar tools were updated so that a single write to the 'release' file
would offline the cpu and remove it from the system.  Given this, I think
Robert's patch should go forward to maintain compatability.

-Nathan

> 
>> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
>>
>> ---
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index d71e585..227c1c3 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -463,6 +463,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
>>  				break;
>>
>>  			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
>> +				set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
>>  				cpu_maps_update_done();
>>  				rc = cpu_down(cpu);
>>  				if (rc)
> 
> The patch looks good.  Will need to test out the various scenarios so
> that the preferred_offline_state do not get flipped before cpu_down()
> is called.  This is unlikely, but still we need to validate
> a concurrent sysfs online file write and sysfs release file write.
> 
> --Vaidy
> 
