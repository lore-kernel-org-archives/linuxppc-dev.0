Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87D152C02A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 07:02:48 +1100 (EST)
Date: Mon, 4 Feb 2013 14:02:35 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: Why is the e500v2 core not using cpuidle?
To: Thomas Waldecker <Thomas.Waldecker@tqs.de>
In-Reply-To: <B88C075EE1324644BA0452D5EFDD5828139523EA@TQ-MAIL.tq-net.de>
 (from Thomas.Waldecker@tqs.de on Sat Feb  2 03:41:27 2013)
Message-ID: <1360008155.14901.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "Linux PPC dev mailing list \(linuxppc-dev@lists.ozlabs.org\)"
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2013 03:41:27 AM, Thomas Waldecker wrote:
> Hi Scott,
>=20
> >> Why is there no support for the cpuidle framework?
> > Because nobody implemented it. :-)
> That's the reason I thought before :-)
>=20
> > The only reason I can think of to implement it on this chip would =20
> be to
> > dynamically choose when to enter nap versus doze, rather than always
> > just using doze.  It's not clear whether the difference in power
> > savings is worth it -- do you have any way of measuring?
>=20
> Is the e500 only using doze? There are comments in the file
> arch/powerpc/kernel/idle_e500.S
> which are stating:
> /*  Go to NAP or DOZE now */
> or
> /* Return from NAP/DOZE ...*/
>=20
> and because of this comments I thought that both modes are in use.

e500 can use nap instead, but it's statically chosen via sysctl.  The =20
default is doze.  Entering nap requires flushing the cache, so you'd =20
only use nap if you care more about lowering idle power consumption =20
than performance, and you wake infrequently enough that you're not =20
burning more power on the cache flushes than you save with the deeper =20
idle state.

> I have a way of measuring the power and it is also a small part of my =20
> masterthesis,
> but it is not very meaningful because at the measuring point there =20
> are other peripheral
> components too.
>=20
> According to the comments can I activate the nap mode somehow?

echo 1 > /proc/sys/kernel/powersave-nap

If you're able to measure a meaningful difference between the two, I'd =20
be interested in hearing your results.

> >> How can I debug the e500 idle modes?
> >> Are there any statistics?
> > Top reports idle percentage...
> If the e500 and e500v2 are indeed using only the doze mode it
> would be enough statistics.

Whichever mode you have selected, that will be used for all idling.  =20
Statistics would only be useful if the idle mode were dynamically =20
chosen.

> Such statistics would be great for the doze, nap (and sleep for the =20
> whole package).

The only way you'll get into sleep mode is through /sys/power/state.

-Scott=
