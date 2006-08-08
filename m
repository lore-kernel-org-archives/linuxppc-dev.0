Return-Path: <danny@mailmij.org>
Received: from mail.mailmij.org (mail.mailmij.org [82.93.140.149])
	by ozlabs.org (Postfix) with ESMTP id 2198D67B6A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 02:50:25 +1000 (EST)
Date: Tue, 8 Aug 2006 18:50:23 +0200
From: danny@mailmij.org
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] fix for firewire patch added in 2.6.17.2 that breaks
	things on ppc
Message-ID: <20060808185023.B21209@luna.ellen.dexterslabs.com>
References: <20060805151050.B24484@luna.ellen.dexterslabs.com>
	<20060807063854.B641@luna.ellen.dexterslabs.com>
	<17624.7051.905145.470927@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17624.7051.905145.470927@cargo.ozlabs.ibm.com>;
	from paulus@samba.org on Tue, Aug 08, 2006 at 03:05:15PM +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2006 at 03:05:15PM +1000, Paul Mackerras wrote:
> danny@mailmij.org writes:
> 
> > -#endif
> > -
> > +#else
> >  	pci_save_state(pdev);
> > -
> > +#endif /* CONFIG_PPC_PMAC */
> 
> Shouldn't we just move the pci_save_state call up before the
> pmac_call_feature() call?
> 
> Paul.
> 
I tested this. It works, but it has no effect (pci_restore_state does not report that anything changed,
thus this means that the config space already contained the correct values).

I discovered one additional problem with leaving a device running through a sleep/resume cycle:
suspend:
ohci1394: fw-host0: SelfID received outside of bus reset sequence
resume:
ohci1394: fw-host0: SelfID is inconsistent [0x7e80773f/0x7e80773f]
The last leads to the node not being able to resume when the device is actually plugged.

Anyway, it's a separate issue, I will investigate.

Danny
