Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id D307D2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Dec 2004 04:28:43 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647421@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'paul.bilke'" <listmail@conspiracy.net>,
	Wolfgang Denk <wd@denx.de>
Date: Tue, 28 Dec 2004 12:28:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi! (Thanks !) 

I guess I need some more education - since I am getting my problem right at
the boot - is 
I-Cache enabled (by default ?) for 8xx on 2.6 at the booting ? - I do not
see anything in .config 
which controls it (or I am missing it there ?) 
How (where and at what point during the boot)-) I could disable I-Cache ?

Thanks,
Alex
-----Original Message-----
From: paul.bilke [mailto:listmail@conspiracy.net]
Sent: Tuesday, December 28, 2004 12:13 PM
To: Wolfgang Denk
Cc: Povolotsky, Alexander; linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx


Actually wd is right, one quick check to see if this is the problem is 
to disable the I-Cache.  The problem only shows up the the I cache 
enabled.  I ran my 870 with them disabled for months (I know its painful)
until I got the 
powers that be to approve wd to spend the time we did not have to fix it.
Some of the best money I ever spent.

Paul

Wolfgang Denk wrote:

>Dear Alex,
>
>in message
<313680C9A886D511A06000204840E1CF0A64741E@whq-msgusr-02.pit.comms.marconi.co
m> you wrote:
>  
>
>> 
>>    
>>
>>>Moving things around in the kernel sometimes 
>>>makes this go away but really its just hidden.
>>>In my case it would explode in zlib_inflate also.  Putting some output 
>>>in the routine would move it ...
>>>      
>>>
>>Yes that is exactly what I have observed (but I did'nt have the correct
>>explanation for it) 
>>    
>>
>
>I think Paul may be right  with  his  suspicion;  it  sounds  like  a
>manifestation  of the CPU15 problem (but it could also be incorrectly
>initialized SDRAMs which fail  during  heavy  load  with  burst  mode
>accesses, or one more instability of the 2.6 kernel on 8xx systems).
>
>Note that all our work relating to this problem was done on  the  2.4
>kernel  base,  and  I  make no claims that it might actually help for
>your 2.6 problems.
>
>  
>
>>Could this code be used for 2.6 ?
>>    
>>
>
>The patch does not apply cleanly as is to the 2.6 tree, but it should
>be simple enough to port.
>
>  
>
>>Could someone point me to it, please ?
>>    
>>
>
>It's in the linuxppc_2_4_devel tree on our CVS server.
>
>Please  find  attached  the  patch  to  the  2.4  kernel  tree  which
>implements  the  workaround,  and  a  test  application  to  reliably
>reproduce the CPU15 errata. It usually takes  1-10  minutes  for  the
>application to crash, if the workaround is disabled:
>
>	bash-2.05b# date; ./cpu15 ; date
>	Thu Aug  2 02:02:42 MEST 2001
>	Illegal instruction
>	Thu Aug  2 02:02:54 MEST 2001
>	bash-2.05b# date; ./cpu15 ; date
>	Thu Aug  2 02:02:58 MEST 2001
>	Illegal instruction
>	Thu Aug  2 02:03:48 MEST 2001
>	bash-2.05b# date; ./cpu15 ; date
>	Thu Aug  2 02:03:54 MEST 2001
>	Illegal instruction
>	Thu Aug  2 02:03:57 MEST 2001
>	bash-2.05b# date; ./cpu15 ; date
>	Thu Aug  2 02:04:07 MEST 2001
>	Illegal instruction
>	Thu Aug  2 02:04:16 MEST 2001
>	bash-2.05b#
>
>We noticed that some background activitly, like logging in/out to the
>target via 'telnet', while the application is running over the serial
>console, additionally speeds up the crash.
>
>You can use this command to enable the workaround at run-time (it  is
>disabled by default):
>
>	bash# sysctl -w kernel.8xx_cpu15=1
>
>Please note that for the h/w problem  to  show  up,  the  instruction
>cache  has  to  be enabled.
>
>Hope this helps.
>
>Best regards,
>
>Wolfgang Denk
>
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
