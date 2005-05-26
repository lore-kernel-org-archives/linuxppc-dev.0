Return-Path: <mgreer@mvista.com>
Message-ID: <42964AC7.8080605@mvista.com>
Date: Thu, 26 May 2005 15:16:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1117000809.6395.92.camel@gaston>	
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>	
	<1117004659.6395.103.camel@gaston>	
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>	
	<1117057460.5076.19.camel@gaston>	
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>	
	<1117089669.9076.105.camel@gaston> <429631CC.6000606@mvista.com>
	<1117145621.9076.147.camel@gaston>
In-Reply-To: <1117145621.9076.147.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>On Thu, 2005-05-26 at 13:30 -0700, Mark A. Greer wrote:
>  
>
>>Benjamin Herrenschmidt wrote:
>>
>>    
>>
>>>- There is _one_ important point to keep in mind, but that has always
>>>been true: None of this work before MMU_init(), 
>>> 
>>>
>>>      
>>>
>>This is very true and raises a couple issues that we should fix while 
>>we're at it:
>>
>>1) There are progress calls in MMU_init which will try to access the 
>>uart before its possible to create a mapping to the uart's regs 
>>(assuming you don't make a hack to map them and that you set up 
>>ppc_md.progress in your platform_init routine).  We should either get 
>>rid of those calls in MMU_init, provide an acceptable way to make 
>>temporary pre-MMU_init mappings, or make sure nobody sets up 
>>ppc_md.progress until ioremap is working (and also get rid of the calls 
>>in MMU_init b/c they're never used).
>>    
>>
>
>Or have the implementation of progress() check if the mapping was done
>or not ...
>

Doesn't seem worth it to me.

> In any ways, I always disliked ppc_md.progress deeply. It's
>ugly and clutters the code. It has never proven very useful to me vs.
>having an early console.
>

Okay, let's rip it out of MMU_init then.  Anyone have a problem with that?

Mark
