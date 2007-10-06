Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D06B8DDE35
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 07:08:10 +1000 (EST)
Subject: Re: Where are inb/outb macros?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Lemenkov <lemenkov@gmail.com>
In-Reply-To: <adf480660710061347l59903ba6vf6b327db674606a9@mail.gmail.com>
References: <adf480660710061347l59903ba6vf6b327db674606a9@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 07 Oct 2007 07:08:01 +1000
Message-Id: <1191704881.6414.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-10-07 at 00:47 +0400, Peter Lemenkov wrote:
> Hello All!
> I can't compile one small software title because of lack <sys/io.h>
> and inb/outb macros. What sould I do to overcome this obstacle?
> 
> My linux distro is Fedora 7 if it is matter.

They don't exist in user space on non-x86. You have to do things
differently. What is your software trying to do ? If it's trying to
access a PCI device IO space, you probably want to mmap it in sysfs and
write your own accessors with appropriate memory barriers.

Ben
