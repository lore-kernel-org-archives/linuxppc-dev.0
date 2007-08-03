Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B78EDDE20
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 03:15:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l73G9A7Q031162
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:09:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73HFRd4264744
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 11:15:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73HFR6D010077
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 11:15:27 -0600
Date: Fri, 3 Aug 2007 12:15:25 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [patch 06/10] 40x decrementer fixes
Message-ID: <20070803121525.61155586@weaponx.rchland.ibm.com>
In-Reply-To: <46B35C07.4090806@ru.mvista.com>
References: <20070803160900.069522000@linux.vnet.ibm.com>
	<20070803161710.931656000@linux.vnet.ibm.com>
	<46B35C07.4090806@ru.mvista.com>
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

On Fri, 03 Aug 2007 20:47:03 +0400
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Josh Boyer wrote:
> 
> > Allow generic_calibrate_decr to work for 40x platforms.  Given that the hardware
> > behavior is identical, this also changes the set_dec function to reload the PIT
> > on 40x to match the behavior 44x currently has.
> 
>     Why bother doing this?! This will only warrant you imprecise decrementer 
> interrupts while it should be interrupting at the precise period currently (if 
> you load PIT once)...

Without some kind of fix, it doesn't function at all.  We can load the
PIT once, but then we need to make sure ARE is set because if the PIT
ticks down to zero it just sits there.

If we want to do that, then fine but it should be common between 40x
and 44x.  I didn't see much of a reason to differ from what's there
today.

josh
