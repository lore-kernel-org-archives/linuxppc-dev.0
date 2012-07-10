Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2A9A72C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 05:36:24 +1000 (EST)
Message-ID: <1341948966.19582.27.camel@smoke>
Subject: Re: Semantics of lv1_pause()
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 10 Jul 2012 12:36:06 -0700
In-Reply-To: <1341890402.2561.2.camel@pasglop>
References: <1341890402.2561.2.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Tue, 2012-07-10 at 13:20 +1000, Benjamin Herrenschmidt wrote:
> regarding the precise semantics of lv1_pause() ?

Here's what's in PS3's setup.c:

static void ps3_power_save(void)
{
	/*
	 * lv1_pause() puts the PPE thread into inactive state until an
	 * irq on an unmasked plug exists. MSR[EE] has no effect.
	 * flags: 0 = wake on DEC interrupt, 1 = ignore DEC interrupt.
	 */

	lv1_pause(0);
}

Just FYI, setup.c is here:

  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/powerpc/platforms/ps3/setup.c;hb=HEAD#l72

> I'm fixing various issues with our idle loops, among other things,
> because we are soft-disabled when we hit ppc_md.powersave() but not
> hard-disabled, there could be an interrupt marked as pending and not
> taken yet.
> 
> Will that work properly ? I have this understanding that it might
> not ... but heh.

The (virtual) HW thread that called lv1_pause() should become active
when any virq that had irq_chip.irq_unmask() called for it occurs.

I'm not sure what 'become active' means if that virq is setup to be
handled by the 'paused' HW thread.  I guess the behavior depends on
if MSR_EE was set?
 
> Also if I call lv1_pause() with MSR_EE off, will it work ? Will it
> return with MSR_EE on like H_CEDE does on pseries ?

As above, the value of MSR_EE has no effect on activating the HW
thread, and I assume MSR_EE will still be off when lv1_pause() returns.
We can try some experiments if needed.

-Geoff
