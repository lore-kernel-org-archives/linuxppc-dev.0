Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 83C9ADDF2D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 08:34:21 +1000 (EST)
Date: Wed, 4 Jul 2007 00:34:19 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0707032356270.3876@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Jul 2007, Segher Boessenkool wrote:

> Just use "compatible" exactly the way it is meant to be
> used and your life will be so much simpler.  And don't
> even think about using a very generic property like "model"
> for a purpose totally different from its intended purpose.

AFAIU, the only way currently to attach an i2c device to a driver is to 
match against driver's name. Let's take the rtc-rs5c372.c example. It 
services rs5c372a, rs5c372b, rv5c386, rv5c387a. And it registers itself 
with the name "rtc-rs5c372". We want to just specify in our dts, e.g., 
'compatible = "rs5c372b";', right? And ask the i2c layer to find a 
suitable driver for us. Which means a pretty big change to i2c core. Is 
this what you think is the proper solution? I could try to think about it 
/ discuss on i2c and eventually cook up a patch, just want to make sure I 
understand you right.

Thanks
Guennadi
---
Guennadi Liakhovetski
