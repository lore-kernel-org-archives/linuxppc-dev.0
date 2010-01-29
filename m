Return-Path: <jschopp@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1F9D4B7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Jan 2010 03:26:28 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0TGNceG016395
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 09:23:38 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0TGQIn3067274
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 09:26:18 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0TGSRpj005985
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2010 09:28:28 -0700
Message-ID: <4B630C27.1060405@austin.ibm.com>
Date: Fri, 29 Jan 2010 10:26:15 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCHv3 2/2] powerpc: implement arch_scale_smt_power for	Power7
References: <1264017638.5717.121.camel@jschopp-laptop>
	<1264017847.5717.132.camel@jschopp-laptop>
	<1264548495.12239.56.camel@jschopp-laptop>
	<1264720855.9660.22.camel@jschopp-laptop>
	<20100129122536.GA11156@iram.es>
In-Reply-To: <20100129122536.GA11156@iram.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, ego@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gabriel Paubert wrote:
> On Thu, Jan 28, 2010 at 05:20:55PM -0600, Joel Schopp wrote:
>   
>> On Power7 processors running in SMT4 mode with 2, 3, or 4 idle threads 
>> there is performance benefit to idling the higher numbered threads in
>> the core.  
>>
>>     
>
> Really 2, 3, or 4? When you have 4 idle threads out of 4, performance
> becomes a minor concern, no? ;-)
>
> 	Gabriel
>   
Yes, but going from 4 idle to 3 idle you want to keep the slanted 
weights.  If you ignored 4 you'd place wrong and then correct it after 
the fact.
