Return-Path: <a.p.zijlstra@chello.nl>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5AAA41007D7
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2011 20:53:49 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/ps3: Fix lost SMP IPIs
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Geoff Levand <geoff@infradead.org>
Date: Wed, 09 Nov 2011 10:53:36 +0100
In-Reply-To: <E1RNxlN-0000wq-1P@casper.infradead.org>
References: <E1RNxlN-0000wq-1P@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320832416.13360.7.camel@twins>
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-08 at 14:37 -0800, Geoff Levand wrote:
> Fixes the PS3 bootup hang introduced in 3.0-rc1 by:
>=20
>   commit 317f394160e9beb97d19a84c39b7e5eb3d7815a
>   sched: Move the second half of ttwu() to the remote cpu
>=20
> Move the PS3's LV1 EOI call lv1_end_of_interrupt_ext() from ps3_chip_eoi(=
)
> to ps3_get_irq() for IPI messages.
>=20
> If lv1_send_event_locally() is called between a previous call to
> lv1_send_event_locally() and the coresponding call to
> lv1_end_of_interrupt_ext() the second event will not be delivered to the
> target cpu.
>=20
> The PS3's SMP IPIs are implemented using lv1_send_event_locally(), so if =
two
> IPI messages of the same type are sent to the same target in a relatively
> short period of time the second IPI event can become lost when
> lv1_end_of_interrupt_ext() is called from ps3_chip_eoi().=20

Ah glad you found it! I'm not going to ack it since PPC guts are way
beyond me.
