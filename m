Return-Path: <martyn.welch@ge.com>
Received: from exprod5og110.obsmtp.com (exprod5og110.obsmtp.com [64.18.0.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2131B6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 19:42:37 +1000 (EST)
Message-ID: <4E01B7D3.1010700@ge.com>
Date: Wed, 22 Jun 2011 10:37:23 +0100
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: GPIO MPC8315 board
References: <31901492.post@talk.nabble.com>
In-Reply-To: <31901492.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/06/11 09:56, Vasanth Ragavendran wrote:
> 
> Hi
>  
> I am using a MPC8315ERDB board. For this i've an external button which is
> connected to GPIO pin 7 of the board. And if this button is pressed then
> certain files have to be deleted. Browsing through the internet i found that
> GPIO drivers have to be included into the kernel and hence i set a 'y' to
> CONFIG_MPC8xxx_GPIO, CONFIG_GPIO_SYSFS and CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB
> etc. And the dts file has be modified to include the following lines 
>  
> gpio1: gpio-controller@c00 {                
> #gpio-cells = <2>;                
> compatible = "fsl,mpc8315-gpio", "fsl,mpc8349-gpio";                
> reg = <0xc00 0x100>;                
> interrupts = <74 0x8>;                
> interrupt-parent = <&ipic>;                
> gpio-controller;         };          
>  
> this is included under immr@e0000000.
>  
> further i included
>  
> erase-button@0 {
> compatible = "erase-button";
> interrupts = <7 2>;
> interrupt-parent = <&gpio1>;
> };
>  
> am i right in including this? coz after compiling the kernel i get a folder
> under /sys/class/gpio. I did an export using
>  
> echo 224 > /sys/class/gpio/export.
>  
> 224 was the number appearing in gpiochip224/base.
>  
> It created another folder gpio224.
>  
> However i'm not able to set the value in them nor the direction.
>  
> echo 1 > /sys/class/gpio/gpio224/value
> cat /sys/class/gpio/gpio224/value﻿
> returns a value of 0 only.
>  
> however the direction is "in"
> cat /sys/class/gpio/gpio224/direction
> in
> 

echo "out" > /sys/class/gpio/gpio224/direction

Martyn

> Am i doing it correctly? How to check it programatically if the button is
> pressed and take the corresponding action! Plz help!
>  
> My kernel version is 2.6.35.9.
>  
> Thanking you in advance.


-- 
Martyn Welch (Principal Software Engineer) | Registered in England and
GE Intelligent Platforms                   | Wales (3828642) at 100
T +44(0)127322748                          | Barbirolli Square, Manchester,
E martyn.welch@ge.com                      | M2 3AB  VAT:GB 927559189
