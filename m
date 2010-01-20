Return-Path: <jschopp@austin.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3A4CB7D4D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 09:09:44 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0KM3HcZ008039
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 17:03:17 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0KM9elv083686
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 17:09:40 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0KM9YUx001170
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2010 15:09:36 -0700
Message-ID: <4B577F1A.9060907@austin.ibm.com>
Date: Wed, 20 Jan 2010 16:09:30 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<26556.1264021443@neuling.org>
In-Reply-To: <26556.1264021443@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ingo Molnar <mingo@elte.hu>, ego@in.ibm.com, linuxppc-dev@lists.ozlabs.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> +	if (cpu_has_feature(CPU_FTRS_POWER7) && weight == 4) {
>>     
>
> I think we should avoid using cpu_has_feature like this.  It's better to
> create a new feature and add it to POWER7 in the cputable, then check
> for that here.
>
> The way that it is now, I think any CPU that has superset of the POWER7
> features, will be true here.  This is not what we want.
>   
Any ideas for what to call this feature?  ASYM_SMT4 ?
>
>> +	smt_gain /= weight;
>>     
>
> This results in a PPC div, when most of the time it's going to be a
> power of two divide.  You've optimised the divides a few lines above
> this, but not this one.  Some consistency would be good.
>
>   
I can turn that into a conditional branch (case statement) with a shift 
for the common 1,2,4 cases which should cover all procs available today 
falling back to a divide for any theoretical future processors that do 
other numbers of threads.
