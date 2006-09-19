Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24D1567B59
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 04:59:00 +1000 (EST)
Message-ID: <45103DF0.9050409@genesi-usa.com>
Date: Tue, 19 Sep 2006 20:58:56 +0200
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [POWERPC] convert string i/o operations to C
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>	<20060919182953.GK29167@austin.ibm.com>
	<20060919135259.303706d3.kim.phillips@freescale.com>
In-Reply-To: <20060919135259.303706d3.kim.phillips@freescale.com>
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

Shouldn't this stuff be optimized out depending on what processor you're 
ACTUALLY running?

For a generic "powerpc" kernel it can be understood, but when you 
consider that on 970/POWER4 and above they use lwsync instead of sync
(google for them and see the mailing list posts :), just to breathe back 
some performance in spinlocks and so on, surely this can be rejigged so 
that processors don't do more work than necessary..? Even a noop takes 
time doesn't it?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Kim Phillips wrote:
> On Tue, 19 Sep 2006 13:29:53 -0500
> linas@austin.ibm.com (Linas Vepstas) wrote:
> 
>> What does this twi do? According to my powerpc docs, this would be a
>> no-op.  Does this have some magic synchronizing powers on certain
>> implementations? If so, there should be at least a comment card added
>> about why the twi is there. (This special ability of twi might be
>> well-known to some, but still, this is not immediately obvious,
>> and not immedately documented in e.g. the PEM.)
> 
> include/asm-p[ower]pc/io.h sheds some light on the matter:
> 
>  * With the sequence below (twi; isync; nop), we have found that
>  * the machine check occurs on one of the three instructions on
>  * all PPC implementations tested so far.  The twi and isync are
>  * needed on the 601 (in fact twi; sync works too), the isync and
>  * nop are needed on 604[e|r], and any of twi, sync or isync will
>  * work on 603[e], 750, 74xx.
>  * The twi creates an explicit data dependency on the returned
>  * value which seems to be needed to make the 601 wait for the
>  * load to finish.
> 
> Kim
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
