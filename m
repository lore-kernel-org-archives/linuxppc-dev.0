Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 4ABFB2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Nov 2004 20:23:44 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Branko on dkts <brankok@dkts.co.yu>
In-Reply-To: <003001c4c88a$db63a840$24c8a8c0@sraz.dkts.co.yu>
References: <003001c4c88a$db63a840$24c8a8c0@sraz.dkts.co.yu>
Content-Type: text/plain
Date: Fri, 12 Nov 2004 10:23:30 +0100
Message-Id: <1100251411.10732.6.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Thread cancellation problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2004-11-12 at 08:40 +0100, Branko on dkts wrote:
> Hello group!
>  
> I would be most grateful for your help. 
>  
> I am developing a Linux application for ppc. The ppc Linux
> distribution I am using is ELDK 3.0. I am having a problem with
> canceling a thread blocked on read. The thread tries to read data from
> a HDLC device. 

First, this is the wrong list for this question as it is concerned
with kernel development, not application developement.

Second, you must prevent the thread/process to get stuck in the
first place. Depending on what the driver supports, you should
try to open(2) the HDLC device with the O_NONBLOCK flag and modifiy
the read/write handling according to non-blocking mode,
or use a select(2) before every read/write to see if the actual call
would block (and not call read/write in this case, of course).

Regards,

-- 
Stefan Nickl
Kontron Modular Computers
