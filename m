Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 091E52C00FB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 15:27:09 +1000 (EST)
Message-ID: <1373779584.19894.270.camel@pasglop>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Sun, 14 Jul 2013 15:26:24 +1000
In-Reply-To: <20130714043600.GA30717@concordia>
References: <51DF1BBB.5060904@mail.usask.ca>
 <51DF2229.5010604@mail.usask.ca> <20130712012142.GA24112@concordia>
 <51E07056.8040007@mail.usask.ca> <51E08A40.80900@mail.usask.ca>
 <51E0F41A.20904@mail.usask.ca> <20130714043600.GA30717@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Chris Friesen <cbf123@mail.usask.ca>, kexec@lists.infradead.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-07-14 at 14:36 +1000, Michael Ellerman wrote:
> > >Is this expected behaviour? It seems to be the same in current git
> > >versions of kexec-tools.
> > >
> > >On my system I see "/proc/device-tree/memory".
> > >
> > >If I modify add_usable_mem_property() to also accept "/memory" then
> my

This is a bug in your device-tree. The memory node should have a unit
address which corresponds to it's reg property. I know people tend to
skip it for "0" but it's bad practice.

So for memory starting at 0 it should be memory@0

Cheers,
Ben.
