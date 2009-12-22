Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id E4A85B7B65
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 11:33:16 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
In-reply-to: <4B2FF35E.9020101@austin.ibm.com>
References: <1261170452.8134.13.camel@jschopp-laptop>
	<29526.1261353566@neuling.org>
	<4B2FBB3F.8030703@austin.ibm.com> <7024.1261429935@neuling.org>
	<4B2FF35E.9020101@austin.ibm.com>
Date: Tue, 22 Dec 2009 11:33:16 +1100
Message-ID: <16243.1261441996@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> OK.
>>>     
>>>>> +	W(NR_CPUS/4),			/* max cores supported */
>>>>>         
>>
>> FYI reading the PAPR, this comment should technically be "max 'cpu'
>> nodes presented".
>>   
>I applied a disambiguation filter to the comment since cpus can mean a 
>lot of things these days ( ie hardware threads, cores, chips) , but a 
>core is a core.

I think you applied ambiguation filter actually :-)

The PAPR is clear and perfectly understandable in this context.  It's
"OF device tree nodes of type 'cpu'".

>>> 4 is the new 2.  
>>>     
>>
>> I'd still be asking what 2 is.  It's needs a #define to make clearer
>> what you are doing.
>>
>>   
>I'll add a #define
>>> Since you don't know the actual threads per core at 
>>> this point in boot you have to be conservative and go with the maximum 
>>> number of any processor.  See page 4 of these charts:
>>> http://www.power.org/events/powercon09/taiwan09/IBM_Overview_POWER7.pdf
>>>     
>>
>> I don't think hard wiring 4 in here is right. If we are booting a
>> machine with SMT2, we will put only half the number of cores that we can
>> handle in this field.  This is going to break a lot of machines where
>> people have compiled with NR_CPUS = thread number.
>>
>> I think you just want to put NR_CPUS here.  
>>
>>   
>It's a bad interface.  No matter what you choose there will be a 
>downside.  1) If you choose NR_CPUS, the best case of how many you could 
>boot without SMT, then when you boot with SMT2 or SMT4 you can get 
>assigned more cpus than you can boot.  2) If you choose NR_CPUS/4, the 
>worst case of how many you could boot, and you get a large machine with 
>SMT2 or SMT1 you might have said you support less cpus than you actually 
>do and thus not boot all the cpus.  So no matter what you choose you 
>could be not booting cpus in some theoretical scenario. 

Sure but 1) is how Linux behaves now (we can always get more cpus than
we can handle) and 2) is what you are changing it to.  2) is going to
break existing users.

Anyway, if you are intending to change functionality like this, please
make it clear in the check in comment.  

Mikey
