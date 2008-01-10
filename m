Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 185F2DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 15:12:18 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so116075anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 20:12:13 -0800 (PST)
Message-ID: <3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
Date: Wed, 9 Jan 2008 22:12:13 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
In-Reply-To: <20080110031723.GA22168@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782B985.2090508@austin.ibm.com> <4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, lkessler@us.ibm.com,
	Nathan Lynch <ntl@pobox.com>, strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 09/01/2008, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 09, 2008 at 08:33:53PM -0600, Linas Vepstas wrote:
>
> > Heh. That's the elbow-grease of this thing.  The easy part is to get
> > the core function working. The hard part is to test these various configs,
> > and when they don't work, figure out what went wrong. That will take
> > perseverence and brains.
>
> This just sounds like a whole lot of extra work to get a feature that
> already exists.

Well, no. kexec is horribly ill-behaved with respect to PCI. The
kexec kernel starts running with PCI devices in some random
state; maybe they're DMA'ing or who knows what. kexec tries
real hard to whack a few needed pci devices into submission
but it has been hit-n-miss, and the source of 90% of the kexec
headaches and debugging effort. Its not pretty.

If all pci-host bridges could shut-down or settle the bus, and
raise the #RST line high, and then if all BIOS'es supported
this, you'd be right. But they can't ....

--linas
