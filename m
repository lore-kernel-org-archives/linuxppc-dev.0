Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D921DE927
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:10:32 +1000 (EST)
Message-ID: <4831ECF0.5090101@freescale.com>
Date: Mon, 19 May 2008 16:11:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Scott Wood wrote:
>> You're recursively entering lock_timer_base, which does a
>> spin_lock_irqsave().  Either interrupts are enabled when they should
>> not be, or an interrupt was supposed to be threaded that isn't.
> 
> Sort of figured. How do I figure out which one, and how to fix it?

Almost certainly the latter.  Is the disk interrupt shared with any 
other interrupts, that are marked IRQF_NODELAY?  The -rt patch doesn't 
seem to handle mixing the two well.

Oh, and just to be sure: you do have CONFIG_PREEMPT_RT turned on, and 
not just CONFIG_PREEMPT, right?  The non-preempt-rt versions in the -rt 
patch don't look like they disable interrupts, though I may just be 
getting lost in a sea of underscores and ifdefs.

-Scott
