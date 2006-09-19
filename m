Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 597E6679E9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:20:41 +1000 (EST)
Message-ID: <45104304.3000205@genesi-usa.com>
Date: Tue, 19 Sep 2006 21:20:36 +0200
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] convert string i/o operations to C
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>	<20060919182953.GK29167@austin.ibm.com>
	<20060919135259.303706d3.kim.phillips@freescale.com>
	<45103DF0.9050409@genesi-usa.com>
	<9E674786-9AF3-4322-B642-7BAA58462B74@kernel.crashing.org>
In-Reply-To: <9E674786-9AF3-4322-B642-7BAA58462B74@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Segher Boessenkool wrote:
>> For a generic "powerpc" kernel it can be understood, but when you
>> consider that on 970/POWER4 and above they use lwsync instead of sync
> 
> lwsync (sync 1) doesn't (architecturally) do anything to order MMIO
> accesses, so you're misunderstanding something.

See below :D

>> (google for them and see the mailing list posts :), just to breathe back
>> some performance in spinlocks and so on, surely this can be rejigged so
>> that processors don't do more work than necessary..? Even a noop takes
>> time doesn't it?
> 
> No-ops don't matter for performance, compared to the cost of the I/O
> itself.  It would help to avoid heavier-than-necessary synchronisation
> instructions if not needed on some certain CPU (or on non-SMP kernels,
> etc.)

But it couldn't hurt, right? There has to be an application note per-CPU 
on the correct sequence of operations for such an access (I seem to have 
collected a directory full for firmware development), it seems a little 
odd to pick and choose one instruction over another for one thing, and 
then say you need to do it to support the 601 of all things, and run 
this code against the G3/G4/G5 which perhaps doesn't care or is more 
intelligent about it (or is guaranteed to have a more intelligent host 
bridge at least).

Maybe I'm talking crap, please say so :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
