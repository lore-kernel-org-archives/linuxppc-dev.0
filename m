Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A209DDEC5
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 16:05:17 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ieljt-0003Ox-0o
	for linuxppc-dev@ozlabs.org; Sun, 07 Oct 2007 23:05:13 -0700
Message-ID: <13091078.post@talk.nabble.com>
Date: Sun, 7 Oct 2007 23:05:13 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Where are inb/outb macros?
In-Reply-To: <200710070146.51140.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <adf480660710061347l59903ba6vf6b327db674606a9@mail.gmail.com>
	<1191704881.6414.3.camel@pasglop>
	<200710070146.51140.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


inb/outb could be used from the usr space on x86 class PC-computer to access
to io ports this is what i assume that you are trying 

You need to compile the program with -O option (expantion of Inline function
)

To perform io operation on ports ioprem/iopl system call must be used (To
get permissio to perform io operation)

Program must run as root 

on non 86 platform try using /dev/port device file in the application 

misbah


Arnd Bergmann wrote:
> 
> On Saturday 06 October 2007, Benjamin Herrenschmidt wrote:
>> On Sun, 2007-10-07 at 00:47 +0400, Peter Lemenkov wrote:
>> > Hello All!
>> > I can't compile one small software title because of lack <sys/io.h>
>> > and inb/outb macros. What sould I do to overcome this obstacle?
>> > 
>> > My linux distro is Fedora 7 if it is matter.
>> 
>> They don't exist in user space on non-x86. You have to do things
>> differently. What is your software trying to do ? If it's trying to
>> access a PCI device IO space, you probably want to mmap it in sysfs and
>> write your own accessors with appropriate memory barriers.
> 
> All cases where I've seen application software use <sys/io.h>, there was
> actually a full device driver in the kernel that already exported a 
> high-level interface to user space. If that's the case here, the
> application
> should use that instead of sysfs.
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/Where-are-inb-outb-macros--tf4581135.html#a13091078
Sent from the linuxppc-dev mailing list archive at Nabble.com.
