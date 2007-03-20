Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4A33DDF33
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 02:53:03 +1100 (EST)
In-Reply-To: <boot-03.miltonm@bga.com>
References: <boot-03.miltonm@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c712b29a84737948c507b06921bdf21e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/7] boot: use FORCE
Date: Tue, 20 Mar 2007 16:52:56 +0100
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  quiet_cmd_bootar = BOOTAR  $@
> -      cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $^; mv $@.$$$$ $@
> +      cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $(filter-out FORCE,$^); 
> mv $@.$$$$ $@

Is there no way to do this without using filter-out?  It's
ugly and a bit fragile.  Oh and it shouldn't be ; but &&
(not your fault, but while you're at it...)


Segher
