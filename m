Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E83CDDDEF8
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 10:26:19 +1100 (EST)
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1206227641.9540.108.camel@pmac.infradead.org>
References: <1201348525.6859.1.camel@thilivren>
	<1206214508.9540.89.camel@pmac.infradead.org>
	<1206223998.7197.13.camel@pasglop>
	<1206226966.9540.104.camel@pmac.infradead.org>
	<1206227641.9540.108.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sun, 23 Mar 2008 10:25:41 +1100
Message-Id: <1206228341.7197.15.camel@pasglop>
Mime-Version: 1.0
Cc: =?ISO-8859-1?Q?=C9tienne?= Bersac <bersace03@gmail.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-03-22 at 23:14 +0000, David Woodhouse wrote:
> On Sat, 2008-03-22 at 23:02 +0000, David Woodhouse wrote:
> > 
> > Yeah, there's weird shit going on with the sensor/control
> > registration.
> > I think GCC is be miscompiling it -- the sequence of
> >         all = all && pm121_register_control(foo...);
> >         all = all && pm121_register_control(bar...);
> > is bailing out as soon as 'all' gets set to zero. Despite the fact
> > that pm121_register_control() quite blatantly has side-effects.

And it's just supposed to do that no ?

Ben.

> That's after I fix the names in pm121_new_control() and fix
> pm121_register_control() to set controls[id] instead of always setting
> controls[FAN_OD], btw. Without that I don't think it could ever have
> worked. 
> 
> But it's still broken. I'll try to cut it down and file a GCC bug...
> 
> .pm121_new_control:
> .LFB929:
>         .loc 1 883 0
> .LVL44:
>         mflr 0
> .LCFI38:
>         std 0,16(1)
> .LCFI39:
>         std 30,-16(1)
> .LCFI40:
>         std 31,-8(1)
> .LCFI41:
>         stdu 1,-128(1)
> .LCFI42:
>         ld 30,.LCTOC0@toc(2)
>         mr 31,3
>         .loc 1 886 0
>         ld 9,.LC47-.LCTOC1(30)
>         lwz 0,48(9)
>         cmpwi 7,0,0
>         bne 7,.L31
> .LVL45:
>         .loc 1 889 0
>         ld 4,.LC49-.LCTOC1(30)
>         li 5,2
>         bl .pm121_register_control
>         cmpdi 7,3,0
>         beq 7,.L31
>         .loc 1 890 0
>         mr 3,31
>         ld 4,.LC51-.LCTOC1(30)
>         li 5,1
>         bl .pm121_register_control
>         cmpdi 7,3,0
>         beq 7,.L31
>         .loc 1 891 0
>         mr 3,31
>         ld 4,.LC53-.LCTOC1(30)
>         li 5,0
>         bl .pm121_register_control
>         cmpdi 7,3,0
>         beq 7,.L31
>         .loc 1 892 0
>         mr 3,31
>         ld 4,.LC55-.LCTOC1(30)
>         li 5,3
>         bl .pm121_register_control
>         cmpdi 7,3,0
>         beq 7,.L31
>         .loc 1 895 0
>         ld 3,.LC57-.LCTOC1(30)
>         bl .printk
>         nop
>         .loc 1 896 0
>         ld 9,.LC47-.LCTOC1(30)
>         li 0,1
>         stw 0,48(9)
> .LVL46:
> .L31:
>         .loc 1 898 0
>         addi 1,1,128
>         ld 0,16(1)
>         mtlr 0
>         ld 30,-16(1)
>         ld 31,-8(1)
> .LVL47:
>         blr
> 
> 
> 
