Return-Path: <stevan@iritel.com>
Received: from iritel.iritel.bg.ac.yu (iritel.iritel.bg.ac.yu [193.203.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61984679E2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 23:34:13 +1000 (EST)
Received: from iritel (root@localhost)
	by iritel.iritel.bg.ac.yu (8.13.1/8.13.1) with SMTP id k4ADSu0V007182
	for <linuxppc-embedded@ozlabs.org>; Wed, 10 May 2006 15:28:56 +0200
Subject: Re: Help Needed: input overrun(s)
From: Stevan Ignjatovic <stevan@iritel.com>
To: s.maiti@tcs.com
In-Reply-To: <OF00585CA1.4BAD2F12-ON6525716A.0018127A-6525716A.00191467@tcs.com>
References: <OF00585CA1.4BAD2F12-ON6525716A.0018127A-6525716A.00191467@tcs.com>
Content-Type: text/plain
Message-Id: <1147267964.25388.41.camel@stevan.iritel.co.yu>
Mime-Version: 1.0
Date: Wed, 10 May 2006 15:32:44 +0200
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

Hello,

On Wed, 2006-05-10 at 06:33, s.maiti@tcs.com wrote:
> Hi all,
> 
> I am currently involve in development of Multi-Channel Controller (MCC) 
> driver for MPC8260 processor. Whenever we are loading the driver, on the 
> console we are receiving a print "ttyS: 1 input overrun(s)" along with 
> other prints of the driver and resulting in scrambled output. 
> Can anyone suggest why this is happening? Is the driver affecting the uart 
> driver?

As far as UART driver is concerned, it could be affected if you did not
carefully allocate some resources. Are you using MCC1 or MCC2? Channel
specific parameters of MCC1 (channels 0-127) are at the beginning of the
DPRAM (channel CH_NUM at address 64*CH_NUM). UART driver (as well as
ethernet driver) allocates its buffer descriptors with
m8260_cpm_dpalloc. I think that allocating with this function starts at
the beginning of the DPRAM, so you might have overwritten UART's buffer
descriptors. So, use MCC2 if you can. If you use some BRGs in your MCC
driver you should check that as well.     

>  We have seen the memory map thoroughly, there is no issue of 
> memory conflict. Any help in this regards, I will be grateful.
> 
> Thnaks and regards,
> Souvik Maiti
> Tata Consultancy Services Limited
> Mailto: s.maiti@tcs.com
> Website: http://www.tcs.com
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain 
> confidential or privileged information. If you are 
> not the intended recipient, any dissemination, use, 
> review, distribution, printing or copying of the 
> information contained in this e-mail message 
> and/or attachments to it are strictly prohibited. If 
> you have received this communication in error, 
> please notify us by reply e-mail or telephone and 
> immediately and permanently delete the message 
> and any attachments. Thank you
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Regards,
Stevan
