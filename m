Return-Path: <saso@activetools.si>
Received: from netgate.activetools.si (router.activetools.si [213.250.28.33])
	by ozlabs.org (Postfix) with ESMTP id 9AF312BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 01:51:10 +1100 (EST)
Message-ID: <41E539D4.2000502@activetools.si>
Date: Wed, 12 Jan 2005 15:53:08 +0100
From: Saso Kavcic <saso@activetools.si>
MIME-Version: 1.0
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
References: <1628E43D99629C46988BE46087A3FBB912F225@ep-01.EmbeddedPlanet.local>
In-Reply-To: <1628E43D99629C46988BE46087A3FBB912F225@ep-01.EmbeddedPlanet.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Some issues with kernel 2.6 for MPC8260 target
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the info. Nice to know that it can work.

Steven Blakeslee wrote:

>I ported it to the Embedded Planet ep8260 board with FCC3, ep8248 board
>with FCC1 and FCC2 and ep8280 with FCC2 and FCC3.  I had to make very
>little, if anything, to get it to work.  I did not try 2.6.9.  I am
>currently using 2.6.10-rc3 which I believe after the last merge is now
>2.6.10.  I did practically nothing to get all of these to work. 
>
>  
>
>>-----Original Message-----
>>From: Saso Kavcic [mailto:saso@activetools.si] 
>>Sent: Wednesday, January 12, 2005 9:27 AM
>>To: Steven Blakeslee
>>Cc: linuxppc-embedded@ozlabs.org
>>Subject: Re: Some issues with kernel 2.6 for MPC8260 target
>>
>>Hi Steven,
>>
>>Have you noticed any improvements in 2.6.10. over 2.6.9? We 
>>were porting
>>2.6.9 to a custom mpc8275vr
>>board and we were able to get everything working except 
>>ethernet (fcc enet). We did manage to get a few packets over 
>>it but it was all very slow, unstable and unpredictable and 
>>it seemed that fcc enet driver doesn't work well in 2.6. Were 
>>you able to use fcc under 2.6.9?
>>
>>Best Regards, Saso
>>
>>Steven Blakeslee wrote:
>>
>>    
>>
>>>I would suggest going to the latest 2.6.10 kernel.  I have 
>>>      
>>>
>>it running 
>>    
>>
>>>with several ethernets running on all the 82xx processors.
>>>
>>> 
>>>
>>>      
>>>
>>>>-----Original Message-----
>>>>From: linuxppc-embedded-bounces@ozlabs.org
>>>>[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Vijay 
>>>>Padiyar
>>>>Sent: Wednesday, January 12, 2005 5:37 AM
>>>>To: LinuxPPC Support
>>>>Subject: Some issues with kernel 2.6 for MPC8260 target
>>>>
>>>>Hi all
>>>>
>>>>I wish to discuss some strange issues that I faced with 
>>>>        
>>>>
>>respect to the 
>>    
>>
>>>>Linux
>>>>2.6.8 kernel (downloaded from kernel.org). Firstly, I wish to know 
>>>>whether this has been known to work on an MPC8260 PowerPC target.
>>>>
>>>>Secondly, when I tried to compile the Linux kernel with my 
>>>>        
>>>>
>>toolchain 
>>    
>>
>>>>(built with Dan Kegel's crosstool for the PowerPC 603e 
>>>>        
>>>>
>>core, which is 
>>    
>>
>>>>what my processor has), I got some errors which I found to rather 
>>>>queer after investigation. Firstly, let me state the errors that I 
>>>>got:
>>>>
>>>>------------------------------------------------------
>>>>
>>>> LD      init/built-in.o
>>>> LD      .tmp_vmlinux1
>>>>arch/ppc/8260_io/built-in.o(.text+0x103c): In function
>>>>`mii_queue_relink':
>>>>arch/ppc/8260_io/fcc_enet.c:1254: undefined reference to 
>>>>`schedule_task'
>>>>arch/ppc/8260_io/built-in.o(.text+0x1074): In function
>>>>`mii_queue_config':
>>>>arch/ppc/8260_io/fcc_enet.c:1263: undefined reference to 
>>>>`schedule_task'
>>>>
>>>>------------------------------------------------------
>>>>
>>>>On further investigation, I find that 'schedule_task()' is 
>>>>        
>>>>
>>simply not 
>>    
>>
>>>>defined anywhere in the 2.6.8 kernel sources. This is quite wierd! 
>>>>However, it is defined in a file 'context.c'
>>>>(linux-src/kernel) in the 2.4.27 kernel sources, which we 
>>>>        
>>>>
>>were using 
>>    
>>
>>>>earlier. How is it that a function is being called but its 
>>>>        
>>>>
>>definition 
>>    
>>
>>>>has been removed from the sources?
>>>>
>>>>Another such example is with the structure 'tq_struct'. It 
>>>>        
>>>>
>>is referred 
>>    
>>
>>>>to in the file 'fcc_enet.c'
>>>>(linux-src/arch/ppc/8260_io) but it's not defined anywhere! 
>>>>Again, after checking in the 2.4.27 sources, I find that 
>>>>        
>>>>
>>it's defined 
>>    
>>
>>>>in the file 'tqueue.h' (linux-src/include/linux)!
>>>>
>>>>A third thing is that the 2.4.27 kernel source file 'uart.c'
>>>>(linux-src/arch/ppc/cpm2_io) is not present in the corresponding 
>>>>folder in the 2.6.8 source (linux-src/arch/ppc/8260_io). 
>>>>        
>>>>
>>There is one 
>>    
>>
>>>>'uart.c' in the folder '8xx_io', but it doesn't get compiled during 
>>>>the kernel build process. Will my UART work correctly with 
>>>>        
>>>>
>>this build?
>>    
>>
>>>>Can someone please tell me if there's some explanation for 
>>>>        
>>>>
>>this that 
>>    
>>
>>>>I'm unaware of? Which would be the proper forum to report 
>>>>        
>>>>
>>this? Again 
>>    
>>
>>>>I would like to ask: Has the 2.6.8 kernel been tested 
>>>>        
>>>>
>>successfully on 
>>    
>>
>>>>the MPC8260 PowerPC platform?
>>>>
>>>>Lastly, where can I get the latest stable Linux kernel 
>>>>        
>>>>
>>source for the 
>>    
>>
>>>>PowerPC platform?
>>>>
>>>>Regards
>>>>
>>>>Vijay Padiyar
>>>>_______________________________________________
>>>>Linuxppc-embedded mailing list
>>>>Linuxppc-embedded@ozlabs.org
>>>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>_______________________________________________
>>>Linuxppc-embedded mailing list
>>>Linuxppc-embedded@ozlabs.org
>>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>> 
>>>
>>>      
>>>
>>    
>>
