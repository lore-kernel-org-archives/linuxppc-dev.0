Return-Path: <jschopp@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B43691007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 04:51:09 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0PHjisu008956
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2010 10:45:44 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0PHojiH015262
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2010 10:50:45 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0PHohmt010841
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2010 10:50:43 -0700
Message-ID: <4B5DD9F1.2010002@austin.ibm.com>
Date: Mon, 25 Jan 2010 11:50:41 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: implement arch_scale_smt_power for Power7
References: <1264017638.5717.121.camel@jschopp-laptop>	
	<1264017847.5717.132.camel@jschopp-laptop>
	<26556.1264021443@neuling.org>	 <4B577F1A.9060907@austin.ibm.com>
	<1264302028.3601.36.camel@pasglop>
In-Reply-To: <1264302028.3601.36.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Michael Neuling <mikey@neuling.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, ego@in.ibm.com,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2010-01-20 at 16:09 -0600, Joel Schopp wrote:
>   
>> I can turn that into a conditional branch (case statement) with a shift 
>> for the common 1,2,4 cases which should cover all procs available today 
>> falling back to a divide for any theoretical future processors that do 
>> other numbers of threads. 
>>     
>
> Look at the cputhreads.h implementation ... Today we only support
> power-of-two numbers of threads.
>   
I've run 3 threads using cpu hotplug to offline 1 of the 4.  It's 
certainly a stupid idea, but there you go.
