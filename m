Return-Path: <jfaslist@yahoo.fr>
Message-ID: <4458C89B.9070505@yahoo.fr>
Date: Wed, 03 May 2006 17:13:31 +0200
From: jfaslist <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Maple freezing on PCI Target-Abort
References: <43E23B4A.4020402@yahoo.fr>	
	<1138930958.4934.102.camel@localhost.localdomain>	
	<43E37DAC.4030606@yahoo.fr>
	<1139011975.8543.4.camel@localhost.localdomain>
In-Reply-To: <1139011975.8543.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
Back on this old posting, we have made progress thanks to IBM help, the 
Maple platform no longer freezes on a (PIO) PCI target-abort. On such an 
occurence we now run the machine check excpetion handler, just like you 
said.
Here is what we got from IBM:

"...
Engineering has verified following behavior relating to Machine Check 
and Check Stop. CPC925 documentation will be updated.

   1. With APIMASK register DerrEXCP set to 1 the target abort on the
      PCI bus causes P_CSTP signal to be driven low.
   2. With APIMASK register DerrEXCP set to 0 and APIEMASK register
      DerrEXCP set to 0 the target abort on the PCI bus causes machine
      check interrupt. In this case the CHP_FAULT signal continues to be
      driven high. It appears that the EI interface has a way of
      signaling machine check since both pins P_CSTP and CHP_FAULT are
      disabled through APIMASK and APIEMASK.
   3. With APIMASK register DerrEXCP set to 0 and APIEMASK register
      DerrEXCP set to 1 the target abort on the PCI bus causes machine
      check interrupt. In this case the CHP_FAULT signal is driven low
      until the APIEXCP is read. After APIEXCP register is read the
      CHP_FAULT signal is again driven high. Since the CHP_FAULT pin is
      not connected to the PPC970FX MCP_B input pin EI bus has a way of
      signaling machine check through EI interface...."


Setting the CPC925 according to item 3, fixes the problem. I give this 
for the record, since the fix should be in PIBS, I think.
I still don't like the fact that a user process causing the condition 
causes the system to enter the "mon" debugger rather than being killed 
w/ SIGBUS/SIGSEGV. I guess the correct way for a fix would be to write a 
Maple specific machine_check exception?
Thanks,
-jf simon

Benjamin Herrenschmidt wrote:

>On Fri, 2006-02-03 at 16:58 +0100, jfaslist wrote:
>  
>
>>Hi,
>>Yes, we are going to dig into all this CPC925 and Processor Interface 
>>initialization.
>>Note that I checked that both MSR_ME and MSR_RI were set prior to 
>>triggering the PCI Target-Abort.
>>
>>-MSR_ME: If not set the CPU will "checkstop" on a machine chaeck.
>>-MSR_RI: So that the exception is recoverable.
>>
>>Regarding MSR_RI, this should always be set, I think?
>>    
>>
>
>Yes, MSR:RI is always set by the kernel except in the rare code path
>where taking an exception is actually unsafe (like in some of the
>exception handling code itself)
>
>Ben.
>
>
>  
>



-------- Original Message --------
Subject: 	Re: Maple freezing on PCI Target-Abort
Date: 	Fri, 03 Feb 2006 12:42:37 +1100
From: 	Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: 	jfaslist <jfaslist@yahoo.fr>
CC: 	linuxppc64-dev@ozlabs.org
References: 	<43E23B4A.4020402@yahoo.fr>



> -What exception vector is taking care of a DERR excp? From what I can 
> see it seems to be the "machine check" vector. But that seems a bit 
> drastic to me. After all this is just a PCI target abort.

I would expect a machine check yes.

> -I expect that the normal behavior would be for the kernel to send a 
> signal termination to the user process which caused the PIO READ PCI 
> cycle (from a previously mmap()'ed VMA address). Is it  doable on this 
> platform?  Since a READ operation is coupled by nature, I think this is 
> the only acceptable way.

It should SIGBUS except if the problem occurred in the kernel. I don't
know why it's not doing so, maybe you are hitting an issue/errata or
misconfiguration of the 925 ?

> I have tried to set the MSR[RI] bit before doing the PCI cycle, but it 
> didn't change change anything. Also on our design we disconnect the 
> CPC925 checkstop pin from the 970 machine check pin.(see page 39 of 
> cpc925 user's manual). So a DERR shouldn't cause a machine check I would 
> think.
> 
> I realize that these questions are very H/W related but couldn't find 
> the answer in IBM doc.






	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
