Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id ED613DDF65
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 23:37:49 +1000 (EST)
Message-ID: <468E457F.4030402@semihalf.com>
Date: Fri, 06 Jul 2007 15:37:03 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI IO range limitation
References: <46838B54.2010806@semihalf.com>	
	<1183052634.5521.284.camel@localhost.localdomain>	
	<468A15D9.7010003@semihalf.com>
	<1183461210.10386.104.camel@localhost.localdomain>
In-Reply-To: <1183461210.10386.104.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2007-07-03 at 11:24 +0200, Marian Balakowicz wrote:
>> Benjamin Herrenschmidt wrote:
>>> On Thu, 2007-06-28 at 12:20 +0200, Marian Balakowicz wrote:
>>>> I guess that with the above dropping of non-zero based PCI IO ranges
>>>> this is not supposed to be working. But does anyone know why?
>>> We just fixed that for 64 bits but 32 bits still has the limitation.
>>> Note that it's not a very good idea to have your IO range at !0 if
>>> you're going to use anything ISA-like, such as a VGA video card or other
>>> legacy devices behind a PCI southbridge or SuperIO.
>> Agree with the zero-based IO range for ISA devices. But, knowing we don't
>> have any ISA stuff on board it should be possible to change the IO base.
> 
> And you don't plan to ever have a VGA video card ?

You definitely got a point, but still, I tend to think that if someone wants to shoot himself in a foot he should be free to do it.

>> Are you planning on modifications for 32 bits as well?
> 
> Not right now, but you are welcome to send a patch :-) Though I fail to
> see why you want to do it.

I don't necessarily need that, I was rather wondering what were the reasons for such modification. This used to be allowed in 2.4, while 2.6 kernel with the legacy setup will silently reset. Kernel booting and issuing a big warning instead would be much nicer if we are to stick to the 0 based IO ranges.

Marian
