Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11CABB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Oct 2009 01:01:19 +1100 (EST)
Received: from rly21a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly21a.srv.mailcontrol.com (MailControl) with ESMTP id
	n9CDxfIv027106
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2009 15:00:46 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly21a.srv.mailcontrol.com (MailControl) id n9CDx2Yj025283
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2009 14:59:02 +0100
Message-ID: <4AD33533.5030900@mta.it>
Date: Mon, 12 Oct 2009 15:54:59 +0200
From: Fortini Matteo <matteo.fortini@mta.it>
MIME-Version: 1.0
To: Roberto Guerra <roberto.j.guerra@gmail.com>
Subject: Re: Linux seamless booting
References: <4AD30DF0.1000901@mta.it>
	<7c4144600910120623k2c9aea89ia0f255164f03ff89@mail.gmail.com>
In-Reply-To: <7c4144600910120623k2c9aea89ia0f255164f03ff89@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, that's what we're currently using, but the problem is a little 
broader: I should answer to CAN messages in at most 100-200ms from 
powerup, and that can be done in u-boot.
However, handing CAN transmission control over to Linux is quite 
complicated nowadays, since it would involve passing structures in 
memory and hacking through device init.
It'd be nice to have a framework with which u-boot could hand-over 
devices to Linux in a clean and defined way.
We were thinking about starting some kind of development in that 
direction, but with very little resources, so I was looking for someone 
who had looked at the same problem.

Thanks,
Matteo

Roberto Guerra ha scritto:
> Did you try "setenv bootdelay 0" in uboot?
>
> On Mon, Oct 12, 2009 at 7:07 AM, Fortini Matteo <matteo.fortini@mta.it> wrote:
>   
>> Hi all,
>> we've been working on a PPC512x board booting with u-boot + linux 2.6.24.6,
>> and one major issue for our application is boot time.
>>
>> Right now, we went down to less than 6s boot time (i.e. time from power off
>> to launch of the user app), even with some drivers installed, i.e.:
>>
>>   * CAN bus
>>   * GPU on PCI bus
>>   * USB host
>>   * UBI
>>
>> with r/o squashfs root and r/w ubifs configuration filesystem mounted from a
>> NOR flash memory.
>>
>> This time could be enough for the high-level application (we're showing a
>> splash screen in about 2-3s so it's ok if the main app takes a little longer
>> to come up), but the whole system is connected to others via CAN and we
>> can't afford the "black out" period between u-boot and linux.
>>
>> Some other operating systems (e.g. QNX) have this "seamless booting"
>> function, in which drivers are started in stages, so that a (minimal)
>> functionality can be given in milliseconds, and more functionalities come up
>> as time goes by.
>>
>> Is there a way to support something similar with the u-boot -> linux
>> solution?
>>
>> Thank you,
>> Matteo
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>     
> .
>
>   
