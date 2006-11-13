Return-Path: <jschopp@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E6CA67D72
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 17:21:15 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAD6L7xp023926
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 01:21:07 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAD6L7ql527604
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 23:21:07 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAD6L6Ip028256
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Nov 2006 23:21:07 -0700
Message-ID: <45580ED0.7000704@austin.ibm.com>
Date: Mon, 13 Nov 2006 00:21:04 -0600
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
References: <20061110182253.GV30625@austin.ibm.com>	<20061110200152.GC23089@localdomain>	<20061111010108.GX30625@austin.ibm.com>
	<1163377944.7410.12.camel@localhost.localdomain>
In-Reply-To: <1163377944.7410.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I can only find one caller? Is it called via a #define or something?
> 
> Wouldn't it be preferable to just change rtas.h like so:
> 
> #ifdef CONFIG_HOTPLUG_CPU
> extern void rtas_stop_self(void);
> #else
> static inline void rtas_stop_self(void) { }
> #endif
> 

There seem to be a couple problems here.  First I'm guessing the file you said there was 
catting into was the online attribute, which shouldn't appear, or at least shouldn't do 
anything, if cpu hotplug isn't configured.  It's a stupid thing to do, but it shouldn't 
crash the kernel.  I guess one of us should fix that, though it probably doesn't merit 
2.6.19 consideration.

The second problem is rtas_stop_self shouldn't be defined or called either.  Michael's 
solution above seems best for that to me.  Care to give us a patch Michael?
