Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 67B562C01BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 14:50:55 +1000 (EST)
Message-ID: <1341204649.2588.29.camel@pasglop>
Subject: Re: 3.5.0-rc5: BUG: soft lockup - CPU#0 stuck for 22s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Date: Mon, 02 Jul 2012 14:50:49 +1000
In-Reply-To: <alpine.DEB.2.01.1207010009270.5568@trent.utfs.org>
References: <alpine.DEB.2.01.1207010009270.5568@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-07-01 at 00:18 -0700, Christian Kujau wrote:
> Hi,
> 
> while trying to upgrade from 3.4.0 to 3.5.0-rc5 on this Powerbook G4 
> (powerpc 32 bit), this happens during booting:
> 
> --------------
> usb 2-1: new full-speed USB device number 4 using ohci_hcd
> SCSI subsystem initialized
> scsi0 : SBP-2 IEEE-1394
> scsi1 : SBP-2 IEEE-1394
> firewire_sbp2 fw1.0: logged in to LUN 0000 (0 retries)
> scsi 0:0:0:0: Direct-Access     Ext Hard  Disk            PQ: 0 ANSI: 4

Interesting... I observed something roughly similar on a dual G4
the other day associated with a 30s to 1mn pause during boot. RCU
was complaining loudly.

In my case, it did continue booting normally, is that the case for you ?

Also if I compile the kernel without CONFIG_SMP, it did go away as well,
do you observe that too ?

I don't have a spare cycle to investigate this problem this week I'm
afraid, it might help if you could try a bisection though.

Cheers,
Ben.
