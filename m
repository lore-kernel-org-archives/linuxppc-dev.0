Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 91AFFDDE10
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 13:15:51 +1100 (EST)
Message-ID: <45CA85F3.5030004@freescale.com>
Date: Wed, 07 Feb 2007 20:07:47 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] Update udbg_progress() to display the integer
References: <11707051151024-git-send-email-timur@freescale.com>	
	<20070206013051.GA15525@lixom.net>	<45C90A6E.3040302@freescale.com>	
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>	
	<1170805102.2620.264.camel@localhost.localdomain>	
	<45C91275.4020806@freescale.com> <45C97121.9080609@austin.ibm.com>	
	<45C9FE30.8010108@freescale.com>
	<1170894706.4656.2.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1170894706.4656.2.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:

>> Perhaps we should define ppc_md.progress() such that it never sends the output 
>> to the same place as printk().  If the only output device is the serial port, 
>> and printk() already outputs there, then ppc_md.progress() should do nothing. 
>> This would eliminate any "accidental" use of ppc_md.progress(), when printk() is 
>> the better choice.
> 
> But then you'll end up with code that does:
> 
>  printk("Setup done");
>  ppc_md.progress("Setup done");

Technically that's true, but I think this will be rare.  The printk() 
messages are supposed to be more verbose than the progress() messages.

Besides, progress() always takes two parameters - a string and a number. 
  So it's not exactly a clone of printk().

> Because on systems where the output _does_ go to two places, you'll want
> the messages to appear in both.
> 
> I don't see what the problem is with progress messages going to the
> printk buffer?

The problem is that currently, a lot of code uses ppc_md.progress() when 
it should use printk() instead.  If progress() is intended for 2-len LED 
displays, then it's not really a substitute for printk().  progress() is 
supposed to display specialized messages, so I think it makes sense for 
it to be treated like a specialized function.
