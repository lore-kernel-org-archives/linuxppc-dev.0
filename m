Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66D59DE085
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Jul 2008 05:22:26 +1000 (EST)
Message-ID: <4879046A.1020508@bucknell.edu>
Date: Sat, 12 Jul 2008 15:22:18 -0400
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: insmod: unresolved symbol XIo_In32/XIo_Out32
References: <48776D93.5080504@bucknell.edu>
	<20080711183117.GD15321@secretlab.ca>
	<4877B04A.8090801@bucknell.edu>
	<20080711210514.GB18239@secretlab.ca>
In-Reply-To: <20080711210514.GB18239@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi again,

Ok, so I tried mapping to in_be32( ) and out_be32( ) by changing:

#define XIo_In32(InputPtr) (*(volatile u32 *)(InputPtr)); SYNCHRONIZE_IO; 
to
#define XIo_In32(InputPtr) in_be32(InputPtr)

and

#define XIo_Out32(OutputPtr, Value) \
   { (*(volatile u32 *)(OutputPtr) = Value); SYNCHRONIZE_IO; }
to
#define XIo_Out32(OutputPtr, Value) out_be32(OutputPtr, Value)

I made sure to include asm-ppc/io.h, too. However, I still get the same 
unresolved symbol error message... Did I do the mapping correctly? 
Thanks again for your help!


-Juliana


Grant Likely wrote:
> On Fri, Jul 11, 2008 at 03:11:06PM -0400, Juliana Su wrote:
>   
>> Hi,
>>
>> Thanks for your reply! I am new to creating loadable kernel modules, so  
>> I hope you do not mind some more questions... How can I get the XIo_*  
>> helper routines to compile into the kernel or export them with  
>> EXPORT_SYMBOL( )? In my c file (my driver file from which I create the  
>> object file), I made sure to include xio.h, which is where XIo_In32 and  
>> XIo_Out32 are defined (see below section from xio.h).
>>     
>
> Add an EXPORT_SYMBOL() line to the location where the io accessors are
> implemented.  However, you'd probably be better just to replace xio.h
> implementation with macros that just map them to the in_be32() and
> out_be32() macros.
>
> g.
>
>   
