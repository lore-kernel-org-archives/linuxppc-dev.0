Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0EE9DDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 03:49:29 +1000 (EST)
In-Reply-To: <20070822040504.GC26374@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
	<20070822031506.GA26374@wotan.suse.de>
	<1afbd9c8892724e484f29532802a3405@kernel.crashing.org>
	<20070822040504.GC26374@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ad5f1933225c7ed226caa1a8828a1bef@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Date: Thu, 23 Aug 2007 19:49:17 +0200
To: Nick Piggin <npiggin@suse.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Drivers are definitely using these __raw_ accessors, and from a quick
>>> look, they do appear to be hoping that *mb() is going to order access
>>> for
>>> them.
>>
>> Which drivers?
>
> There are maybe a dozen that use the raw accessors, and use non-smp_
> memory barriers. I just looked at drivers/video/tgafb.c, which
> indeed appears to intermix them.

Hrm yeah.  It also looks like old buggy code that could use a
cleanup or two (or three or four).  I wonder if all __raw_ users
are like that?


Segher
