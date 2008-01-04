Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6419DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 19:41:16 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JAi78-0008G0-6u
	for linuxppc-embedded@ozlabs.org; Fri, 04 Jan 2008 00:41:14 -0800
Message-ID: <14612559.post@talk.nabble.com>
Date: Fri, 4 Jan 2008 00:41:14 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Drivers' probe function calling order
In-Reply-To: <20080103215456.GA20691@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <F1F6EC0C8B75034F9E3A79FC85122E8EC2DE1E@aquib01a>
	<20080103215456.GA20691@mail.gnudd.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Mr Rubini ...

I am writing a driver in which device port is mapped to CPLD and 8 bit data
bus is directly connected from processor to CPLD. Read write on CPLD memory
mapped (buffer/register) is required to control the device. This is now IO
mapped to processor. 

I need to know whether i am right if i impliment like this :- 
         addr=ioremap(base_addr,size);          // Remap to Mem mapped
address 
         out_8(addr) and in_8(addr); 


Alessandro Rubini wrote:
> 
> 
>> how can I force the system to call
>> probe function of the spi driver first?
> 
> You can declare their init functions at different initcall level.  For
> example declaring the dataflash one as late_initcall(). Or declare
> the spi one as subsys_initcall() -- whatever makes more sense.
> 
> There might be cleaner ways according to your setup, but this will
> surely work.
> 
> /alessandro
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Drivers%27-probe-function-calling-order-tp14601099p14612559.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
