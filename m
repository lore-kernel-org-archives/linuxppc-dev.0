Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-124.bluehost.com (outbound-mail-124.bluehost.com
	[67.222.38.24]) by ozlabs.org (Postfix) with SMTP id 4E5C4DDF58
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 07:29:17 +1100 (EST)
Message-ID: <493ED385.7070601@dlasys.net>
Date: Tue, 09 Dec 2008 15:22:29 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net> <87r64j112j.fsf@macbook.be.48ers.dk>
In-Reply-To: <87r64j112j.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
>>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
> Hi,
>
>  David> 	I am having two problems with it.
>  David> 	I can not get it working with interrupts,
>
> No activity on the interrupt pin or is it always active?
>   
Neither:
The USB system does not function with interrupts, and the kernel reports
lots of unhandled IRQ's.

I beleive that
int_status = c67x00_ll_hpi_status(c67x00);
if (!int_status)
return IRQ_NONE;

is always exiting IRQ_NONE;


If I replace the request_irq() call with installation of a timer service
routine that basically periodically calls the interrupt handler,
everything works fine - albeit slowly.







-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
