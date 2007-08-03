Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 324A9DDF25
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 03:25:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73HPEHr010110
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 13:25:14 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73HPEAD160712
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 11:25:14 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73HPD8b018251
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 11:25:13 -0600
Date: Fri, 3 Aug 2007 12:25:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 06/10] 40x decrementer fixes
Message-ID: <20070803122512.26a24d99@weaponx.rchland.ibm.com>
In-Reply-To: <46B3617B.10509@ru.mvista.com>
References: <20070803160900.069522000@linux.vnet.ibm.com>
	<20070803161710.931656000@linux.vnet.ibm.com>
	<46B35C07.4090806@ru.mvista.com> <46B3617B.10509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 03 Aug 2007 21:10:19 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> I wrote:
> 
> >>Allow generic_calibrate_decr to work for 40x platforms.  Given that the hardware
> >>behavior is identical, this also changes the set_dec function to reload the PIT
> 
>     It's not actually identical. When you're writing to the PIT reg on 40x, 
> you're alos writing to the hidden PIT auto-reload reg. which is not the case 
> for 440 that is true Book E.

I said the hardware _behavior_ is identical.  On both 440 and 405, if
the PIT/DEC counts down to 0 and ARE isn't set, it just doesn't tick
anymore.  The fact that writing to PIT sets the shadow reload reg on
405 doesn't matter since ARE isn't enabled.  The same is true for 440
at the moment, since DECAR is never set.

> 
> >>on 40x to match the behavior 44x currently has.
> 
> >     Why bother doing this?! This will only warrant you imprecise decrementer 
> > interrupts while it should be interrupting at the precise period currently (if 
> > you load PIT once)...
> 
>     I.e. the error will only accumulate. NAK.

What error exactly?  I'm not following you there.  If there really is
an error, then we can fix it but it seems that it would be common error
for both 440 and 405 at the moment.

josh
