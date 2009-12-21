Return-Path: <jschopp@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7218FB6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 09:15:01 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBLM6DMl028924
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 17:06:13 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBLMEwAg2125858
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 17:14:58 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBLMEvEr023264
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 17:14:57 -0500
Message-ID: <4B2FF35E.9020101@austin.ibm.com>
Date: Mon, 21 Dec 2009 16:14:54 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
References: <1261170452.8134.13.camel@jschopp-laptop>
	<29526.1261353566@neuling.org>
	<4B2FBB3F.8030703@austin.ibm.com> <7024.1261429935@neuling.org>
In-Reply-To: <7024.1261429935@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>> OK.
>>     
>>>> +	W(NR_CPUS/4),			/* max cores supported */
>>>>         
>
> FYI reading the PAPR, this comment should technically be "max 'cpu'
> nodes presented".
>   
I applied a disambiguation filter to the comment since cpus can mean a 
lot of things these days ( ie hardware threads, cores, chips) , but a 
core is a core.

>> 4 is the new 2.  
>>     
>
> I'd still be asking what 2 is.  It's needs a #define to make clearer
> what you are doing.
>
>   
I'll add a #define
>> Since you don't know the actual threads per core at 
>> this point in boot you have to be conservative and go with the maximum 
>> number of any processor.  See page 4 of these charts:
>> http://www.power.org/events/powercon09/taiwan09/IBM_Overview_POWER7.pdf
>>     
>
> I don't think hard wiring 4 in here is right. If we are booting a
> machine with SMT2, we will put only half the number of cores that we can
> handle in this field.  This is going to break a lot of machines where
> people have compiled with NR_CPUS = thread number.
>
> I think you just want to put NR_CPUS here.  
>
>   
It's a bad interface.  No matter what you choose there will be a 
downside.  1) If you choose NR_CPUS, the best case of how many you could 
boot without SMT, then when you boot with SMT2 or SMT4 you can get 
assigned more cpus than you can boot.  2) If you choose NR_CPUS/4, the 
worst case of how many you could boot, and you get a large machine with 
SMT2 or SMT1 you might have said you support less cpus than you actually 
do and thus not boot all the cpus.  So no matter what you choose you 
could be not booting cpus in some theoretical scenario. 
