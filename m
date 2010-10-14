Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3DB3FB70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 14:25:07 +1100 (EST)
Message-ID: <4CB6788D.60705@windriver.com>
Date: Thu, 14 Oct 2010 11:27:09 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>	<20100921170700.53a99e56@udp111988uds.am.freescale.net>	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>	<20101007152626.4e834d43@udp111988uds.am.freescale.net>	<8636b70ea34330679bebdaad187ccd68.squirrel@localhost>	<4CB2DEFB.90204@windriver.com>	<20101011121745.2e471fc0@udp111988uds.am.freescale.net>	<942ea2f3464025464521511c32355782.squirrel@localhost>	<20101012162152.5246744a@udp111988uds.am.freescale.net>	<4CB5088D.4090201@windriver.com>	<20101013102815.2959fcb6@udp111988uds.am.freescale.net>
	<4CB65F6F.1090103@windriver.com>
In-Reply-To: <4CB65F6F.1090103@windriver.com>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>, david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tiejun.chen wrote:
> Scott Wood wrote:
>> On Wed, 13 Oct 2010 09:17:01 +0800
>> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
>>
>>> Scott Wood wrote:
>>>> The crash is happening somewhere in mpic_set_irq_type():
>>> Agreed. That is just where I pointed out on my email replied for OOPS. To enable
>>> DBG to figure out 'src' and 'mpic->irq_count' from the file,
>>> arch/powerpc/sysdev/mpic.c,    .
>>> ======
>>> int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
>>> {
>>> 	......
>>> 	if (src >= mpic->irq_count)
>>> 		return -EINVAL;
>>> 			^
>>> 			I think this OOPS may be from here.
>> No, it's after that.  His board code is using the mpic's "isu" remapping
> 
> I means OOPS is *from* here. According to David's call trace,
> mpic_set_irq_type() is the last issued function. And that corresponding return
> value, R3, is '0xffffffea', -22, and also '-EINVAL'. If everything is OK, I
> think we should not be failed with returning '-EINVAL' here. Right? So I think
> we should dump 'src' (mpic_irq_to_hw(virq)) and 'mpic->irq_count'. Then figure
> out why 'src' >= 'mpic->irq_count'. I think this can make our debug life easier.
> 

Certainly I'm missing something since I have no any real environment. So maybe
we can use gdb to track this panic as normal :)
# gdb vmlinux
(gdb) list *mpic_set_irq_type+0x188/

Tiejun

> Tiejun
> 
>> mechanism, and the MSIs aren't covered, so those registers aren't
>> ioremapped.
>>
>> -Scott
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
