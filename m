Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (unknown [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC542DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jan 2008 21:20:43 +1100 (EST)
Received: from mail.gnudd.com (rubini@localhost [127.0.0.1])
	by mail.gnudd.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m04AKcNP031636
	for <linuxppc-embedded@ozlabs.org>; Fri, 4 Jan 2008 11:20:38 +0100
Received: (from rubini@localhost)
	by mail.gnudd.com (8.13.4/8.13.4/Submit) id m04AKbm5031633
	for linuxppc-embedded@ozlabs.org; Fri, 4 Jan 2008 11:20:37 +0100
Date: Fri, 4 Jan 2008 11:20:37 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ioremap and outb
Message-ID: <20080104102037.GA31627@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <14612559.post@talk.nabble.com>
References: <14612559.post@talk.nabble.com>
	<F1F6EC0C8B75034F9E3A79FC85122E8EC2DE1E@aquib01a>
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


Please don't change subject matter without changing subject line, and please
open a new thread when asking a new question.

> I am writing a driver in which device port is mapped to CPLD and 8 bit data
> bus is directly connected from processor to CPLD. Read write on CPLD memory
> mapped (buffer/register) is required to control the device. This is now IO
> mapped to processor.

This is typical. You'll find quite a lot of examples.

>          addr=ioremap(base_addr,size);          // Remap to Mem mapped

Yes.

>          out_8(addr) and in_8(addr); 

It should be right, although __raw_readb() and __raw_writeb() may
suffice for you. Please check the comments in <asm/io.h>.

It may also happen that you need to read/write  32 bits instead of 8,
but this depends on your specific hardware.

/alessandro
