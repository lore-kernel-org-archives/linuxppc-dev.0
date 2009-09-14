Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C82E2B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 06:44:48 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 599B2DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 06:44:47 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8EKiiL5016132
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 13:44:44 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8EKkLfH012630
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 15:46:21 -0500 (CDT)
Message-ID: <4AAEAB56.1050609@freescale.com>
Date: Mon, 14 Sep 2009 15:45:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3 2/5] powerpc/85xx/86xx: Add suspend/resume support
References: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
	<20090830193718.GB17519@oksana.dev.rtsoft.ru>
	<20090914172811.GA9074@b07421-ec1.am.freescale.net>
	<20090914202017.GA14428@oksana.dev.rtsoft.ru>
In-Reply-To: <20090914202017.GA14428@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> This patch adds suspend/resume support for MPC8540, MPC8569 and
> MPC8641D-compatible CPUs.
> 
> MPC8540 and MPC8641D-compatible PMCs are trivial: we just write
> the SLP bit into the PM control and status register.
> 
> MPC8569 is a bit trickier, QE turns off during suspend, thus on
> resume we must reload QE microcode and reset QE.
> 
> So far we don't support Deep Sleep mode as found in newer MPC85xx
> CPUs (i.e. MPC8536). It can be relatively easy implemented though,
> and for it we reserve 'mem' suspend type.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Scott Wood <scottwood@freescale.com>

>> I'm not sure that we're guaranteed that the sleep has taken effect
>> immediately -- we may need to do a loop waiting for it to clear (on
>> 85xx), probably with some delays to give the bus a chance to become idle.
> 
> Brilliant idea, thanks!
> 
> But it works vice versa: upon write, the code flow stops immediately
> (on 85xx and 86xx),

That's what I've observed as well; the question is whether it's always 
guaranteed to be immediate.

>> The 8610 manual says that that bit should only be set as part of a
>> sequence also involving the use of MSR[POW] (section 23.5.1.4).
> 
> Well, 23.4.1.12 says:
> 
> | Sleep status
> | 0 The device is not attempting to reach sleep mode.
> | 1 The device is attempting to enter sleep mode because
> | POWMGTCSR[SLP] is set, or HID0[SLEEP] and MSR[POW] in
>                          ^^
> | the e600 core are set. The core has halted fetching, snooping
> | to the L1 and L2 caches is disabled, ....
> 
> The same in 85xx specs.
> 
> I can confirm this on real hw, after setting the SLP bit, the 8610
> actually goes into sleep mode, no code flow happens until a wakeup
> event. So playing with MSR[POW] doesn't seem to be necessary. The
> same for 85xx.

OK, looks like section 23.5.1.4 is just bogus.

> This exact snippet could be moved to the "qe" device driver, yes.
> But I didn't bother because fsl_pmc have to request the QE firmware.
> 
> You can't request the firmware in the qe driver's ->suspend()
> routine necause the firmware may be on e.g. NFS filesystem or USB
> stick (implies having QE Ethernet or QE USB fully functional).

Is there any way for software to read out the current firmware from the 
device, or is it write-only?

> We can solve that by implementing ppc_md.suspend_prepare() (must
> be called from userspace context), there we could request the
> firmware. Then QE device driver would reload it in its resume()
> callback. Needless to say that it makes things a bit more
> complicated to follow.
> 
> The current code vanishes without QE anyway. But if you insist,
> I can do the suspend_prepare() thing, although I'd prefer it as
> a cleanup patch for 2.6.33, since it would touch more code,
> specifically I'm concerned about ppc generic files.

I don't insist, it just struck me as odd.

-Scott
