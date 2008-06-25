Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76C23DE08D
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 03:07:44 +1000 (EST)
Message-Id: <1DD06CDB-428E-4832-93CA-6F0404CA6692@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48626FA9.8010903@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating
	point	registers in thread_struct.
Date: Wed, 25 Jun 2008 12:07:19 -0500
References: <20080625040718.028B470296@localhost.localdomain>
	<F09034D9-1B3C-4087-B6DF-FAB7B3AFA191@kernel.crashing.org>
	<48626588.8050202@freescale.com> <20080625161255.GA12165@iram.es>
	<48626FA9.8010903@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 25, 2008, at 11:17 AM, Scott Wood wrote:

> Gabriel Paubert wrote:
>> On Wed, Jun 25, 2008 at 10:34:32AM -0500, Scott Wood wrote:
>>> Kumar Gala wrote:
>>>>> +/* Macros to workout the correct index for the FPR in the  
>>>>> thread struct */
>>>>> +#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
>>>>> +#define FPRHALF(i) (((i) - PT_FPR0) % 2)
>>>> Have you looked at what the compiler spits out here to make sure  
>>>> we aren't getting a divide?  Seems like we could use '& 0x1'.
>>> GCC's not *that* dumb.  However, you may get some unnecessary sign- 
>>> twiddling if "i" is signed.
>> Not for modulo 2, it's only an even/odd choice and GCC implements  
>> that efficiently IIRC. For other powers of 2,
>> making the left hand side unsigned helps the compiler.
>
> From this:
>
> int foo(int x)
> {
> 	return x % 2;
> }
>
> I get this with -O3:
>
> foo:
>        mr 0,3
>        srawi 3,3,1
>        addze 3,3
>        slwi 3,3,1
>        subf 3,3,0
>        blr
>        .size   foo, .-foo
>        .ident  "GCC: (GNU) 4.1.2"
>
> Changing it to "x & 1", or to unsigned, gives this:
>
> foo:
>        rlwinm 3,3,0,31,31
>        blr
>        .size   foo, .-foo
>        .ident  "GCC: (GNU) 4.1.2"
>
> Maybe newer GCCs are better?

Nope. gcc-4.3.0 from fedora 9:

foo:
         mr 0,3
         srawi 3,3,1
         addze 3,3
         slwi 3,3,1
         subf 3,3,0
         blr

bar:
         rlwinm 3,3,0,31,31
         blr

if you make 'x' unsigned things are better.

- k
