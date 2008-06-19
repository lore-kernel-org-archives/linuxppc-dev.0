Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX 
In-reply-to: <C780D687-D505-4A01-BED8-9866F4D0160A@kernel.crashing.org> 
References: <20080618004734.0B72E70296@localhost.localdomain>
	<7B118E94-F308-4768-8ED6-BD66C5C3D3CA@kernel.crashing.org>
	<18521.37627.275223.34489@cargo.ozlabs.ibm.com>
	<C780D687-D505-4A01-BED8-9866F4D0160A@kernel.crashing.org>
Date: Thu, 19 Jun 2008 14:30:46 +1000
Message-ID: <13731.1213849846@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <C780D687-D505-4A01-BED8-9866F4D0160A@kernel.crashing.org> you wrote:
> 
> On Jun 18, 2008, at 5:58 PM, Paul Mackerras wrote:
> 
> > Kumar Gala writes:
> >
> >> Is VSX mutually exclusive with altivec/fp?  is there a MSR bit for  
> >> it?
> >
> > It's not exclusive, it's an extension of altivec/fp, and yes it has
> > its own MSR bit to enable it.
> 
> what MSR bit does it use... I'm not seeing the code add or test a new  
> MSR bit anywhere.

It's introduced in patch 8.

 #define MSR_VEC_LG	25	        /* Enable AltiVec */
+#define MSR_VSX_LG	23		/* Enable VSX */
 #define MSR_POW_LG	18		/* Enable Power Management */

> What exactly do you mean by its an extension of altivec/fp?  Are the  
> instructions considered part of altivec/fp or is it just reusing the  
> register storage like SPE?

VSX is considered separate instructions, but it uses the same
architected registers as FP and VMX.  

ie if you execute a VSX instruction which touches VSX regsister 0, it'll
change FP register 0 (and visa versa).  

Also, if execute a VSX instruction which touches VSX register 32, it'll
change VMX register 0 (and visa versa).  In fact, for this patch we use
the 128bit VMX load/stores to perform the context save/restore on the
VSX registers 32-63.

I guess in theory you could have VSX without FP and VMX, but this patch
assumes you have FP and VMX if you have VSX.  

This set of patches should allow any crazy mix of FP, VMX and VSX code
and the architected state should be context switched correctly.  

Sorry, I'm not familiar with how SPE works, so I can't comment on it's
relevance. 

Mikey
