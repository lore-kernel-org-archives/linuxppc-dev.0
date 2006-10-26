Return-Path: <ammubhai@gmail.com>
Received: from marmot.shef.ac.uk (marmot.shef.ac.uk [143.167.1.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E200367DB0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 18:00:54 +1000 (EST)
Message-ID: <45406B30.1050605@gmail.com>
Date: Thu, 26 Oct 2006 09:00:48 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: agnel juni <junijoseph@yahoo.co.in>
Subject: Re: System ACE driver - for 2.6 kernel - need help to understand
	xsa_thread
References: <20061026003115.22528.qmail@web8408.mail.in.yahoo.com>
In-Reply-To: <20061026003115.22528.qmail@web8408.mail.in.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Junita,
    Its a hack really! When I was developing/porting the SysAce driver 
to 2.6 I tried to maintain the code as is from the 2.4 kernel driver. In 
doing so I found that there is a slight difference between the two 
kernels. i.e. I am not sure why, but the sysace device can only handle 
requests for 2 sectors at a time. This was fine in the 2.4 as the kernel 
always requested 2 sectors. However, in 2.6 I found that this is 
different: the requests are 8 secs. or more. I tried to fix this in vain 
by changing several parameters of the driver during initialization. 
Anyway, due to several issues I didn't try hard to fix it at that time.

Hence this hack: No matter how many sec. req. I get from the kernel, I 
use a loop to req. only 2 secs. at a time. The xsa_device.req_done is 
used as a flag and reset in the XSA IRQ IIRC.

If you find a better approach, please do update me. Hope this helps!

cheers,
-Ameet

agnel juni wrote:
> 
> Hello all
> 
> I am trying to understand the parameters that are sent through "cur_req" 
> function used in funtion xsa_thread in System ACE driver.
> 
> In xsa_thread function in the System ACE driver ,
> 
> In 2.4 kernel:
> --------------------
> while ((stat = cur_req(&SysAce, sector,
>                                        CURRENT->current_nr_sectors,
>                                        CURRENT->buffer)) == XST_DEVICE_BUSY)
>                         xsa_short_delay();
> 
>  
> Where as in 2.6 kernel this is changed to
> ---------------------------------------------------------------
> 
> for(i = xsa_cur_req->current_nr_sectors; i > 0; i-=2){
>                         xsa_device.req_done = 1;
>                         while ((stat = cur_req(&SysAce, sector,
>                                         2,
>                                         buffer)) == XST_DEVICE_BUSY)
>                                 xsa_short_delay();
> #endif
> 
> Ameet , could you help me understand the impact of the parameters, 
> especailly the 3rd paramter which is hardcoded in 2.6 kernel.It would be 
> great if you could clarify this in regard to 'mount' command.
> 
> Thanks in advance
> Junita
> 
> 
> 
> ------------------------------------------------------------------------
> Find out what India is talking about on - Yahoo! Answers India 
> <http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/>
> Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. 
> Get it NOW 
> <http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com> 
> 
