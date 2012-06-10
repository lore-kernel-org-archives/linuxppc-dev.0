Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B258B6FF4
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2012 17:23:09 +1000 (EST)
Message-ID: <1339312981.24838.98.camel@pasglop>
Subject: Re: [PATCH 01/15] i2c/powermac: Register i2c devices from device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Sun, 10 Jun 2012 17:23:01 +1000
In-Reply-To: <m2zk8br65n.fsf@linux-m68k.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
 <m2r4tofuxr.fsf@igel.home> <1339279889.24838.93.camel@pasglop>
 <m2k3zgf79j.fsf@igel.home> <1339281364.24838.94.camel@pasglop>
 <m2fwa4f5x5.fsf@igel.home> <1339283422.24838.96.camel@pasglop>
 <m2zk8br65n.fsf@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-06-10 at 09:13 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > On Sun, 2012-06-10 at 00:59 +0200, Andreas Schwab wrote:
> >> It's a PowerMac G5.  During booting I see this:
> >
> > There's about half a dozen versions of those :-) I assume the older
> > PowerMac7,2 ?
> 
> Yes, that's right.  Sorry for being imprecise.
> 
> >> PowerMac i2c bus pmu 2 registered
> >> PowerMac i2c bus pmu 1 registered
> >> PowerMac i2c bus mac-io 0 registered
> >> i2c i2c-5: i2c-powermac: modalias failure
> >> on /ht@0,f2000000/pci@1/mac-io@7/i2c@18000/deq@6a
> >> i2c i2c-5: i2c-powermac: invalid reg
> >> on /ht@0,f2000000/pci@1/mac-io@7/i2c@18000/i2c-modem
> >> PowerMac i2c bus u3 1 registered
> >> i2c i2c-6: i2c-powermac: modalias failure
> >> on /u3@0,f8000000/i2c@f8001000/cereal@1c0
> >> PowerMac i2c bus u3 0 registered
> >> 
> >> The deq node has no compatible, perhaps the modalias can be
> >> constructed out of the name instead?
> >
> > But where is the deq node ? Under i2c or under sound ?
> 
> It looks like /ht@0,f2000000/pci@1/mac-io@7/i2c@18000/deq@6a is under
> i2c.

Ah, excellent, so a small quirk in i2c_powermac is the way to go then,
we can detect it by name and hack up something. Either that or even
better, in prom_init, we could add the missing property to the
device-tree.

Any chance you can try that ? (Look at other examples of DT fixups in
prom_init.c and don't forget the RELOC() around strings :-)

Cheers,
Ben.
