Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6618679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Mar 2006 02:04:50 +1100 (EST)
In-Reply-To: <200603220628100675.0019366F@smtp.dslextreme.com>
References: <200603220628100675.0019366F@smtp.dslextreme.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <58B0E954-FEF3-4E5E-A6C9-69AF14E002E1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: software-triggered reset of MPC8541
Date: Wed, 22 Mar 2006 09:05:39 -0600
To: Dan Wilson <dwilson@dslextreme.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 22, 2006, at 8:28 AM, Dan Wilson wrote:

> My apologies for asking a question in this mailing list that is  
> somewhat off-topic, but this is the best list I know of for such a  
> question:
>
> We are trying to implement a software function to reset an 8541.   
> The ELDK 4.0 kernel includes an abort() function that does this by  
> setting the appropriate bits in DBCR0.  In our tests, this  
> unfailingly reboots the unit.  A colleague has put an identical  
> function into a non-linux-based application on which he is working,  
> and finds that most of the time the unit reboots as expected, but  
> sometimes it just hangs.
>
> My question is: does the linux kernel do anything special to  
> prepare the processor environment for this reboot prior to calling  
> abort()?  The only thing I could find was a call to  
> local_irq_disable(), which does:
> static inline void local_irq_disable(void)

The problem is there is no good way of actually resetting the full  
8541 from software without additional logic on whatever system you  
have.  The abort() is a poor mans way which is only actually  
resetting the E500 core.  The rest of the system logic is left in  
whatever state it was before.

What you really need is to determine if there is some way to effect  
and board logic you may have that handles the HRESET_REQ signal.

> {
> #ifdef CONFIG_BOOKE
>         __asm__ __volatile__("wrteei 0": : :"memory");
> #else
>         unsigned long msr;
>         __asm__ __volatile__("": : :"memory");
>         msr = mfmsr();
>         SET_MSR_EE(msr & ~MSR_EE);
> #endif
> }
>
> As the 8541 is an E500 core, I believe it is the #ifdef  
> CONFIG_BOOKE code that is being executed.  The wrteei 0 instruction  
> is clear enough.  What does the rest of that line do (i.e., the  
> repeated colons and the memory command)?  I haven't been able to  
> find a memory command in the ppc instruction set documents that I  
> have?

The "memory" reference is more about GCC's assembler syntax than  
anything PPC specific.  Take a look at the GCC does for inline  
assembly to find out more.

- kumar
