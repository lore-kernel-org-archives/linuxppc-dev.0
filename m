Return-Path: <listmail@conspiracy.net>
Received: from ns.traffictel.com (mail.conspiracy.net [209.189.226.94])
	by ozlabs.org (Postfix) with ESMTP id 7861F2BF10
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Dec 2004 04:14:04 +1100 (EST)
Message-ID: <41D19406.2050904@conspiracy.net>
Date: Tue, 28 Dec 2004 11:12:38 -0600
From: "paul.bilke" <listmail@conspiracy.net>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20041228095119.F07EDC1430@atlas.denx.de>
In-Reply-To: <20041228095119.F07EDC1430@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Actually wd is right, one quick check to see if this is the problem is 
to disable the I-Cache.  The problem only shows up the the I cache 
enabled.  I ran my
870 with them disabled for months (I know its painful) until I got the 
powers that be to approve wd to spend the time we did not have to fix it.
Some of the best money I ever spent.

Paul

Wolfgang Denk wrote:

>Dear Alex,
>
>in message <313680C9A886D511A06000204840E1CF0A64741E@whq-msgusr-02.pit.comms.marconi.com> you wrote:
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
