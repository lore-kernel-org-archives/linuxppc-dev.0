Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 456EADE04C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 17:18:54 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
References: <1169714047.65693.647693675533.qpush@cradle>
Date: Thu, 25 Jan 2007 23:18:20 -0700
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle> (Michael Ellerman's
	message of "Thu, 25 Jan 2007 19:34:07 +1100")
Message-ID: <m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> OK, here's a first cut at moving ops based MSI into the generic code. I'm
> posting this now to make sure I'm not heading off into the weeds.

First thanks for copying me on this.  I really appreciate it.

> The fifth patch contain the guts of it, I've included the MPIC and
> RTAS backends as examples. In fact they actually work.
>
> In order to smoothly merge this with the old MSI code, the two will need to
> coexist in the tree for at least a few commits, so I've added (invisible)
> Kconfig symbols to allow that.
>
> I plan to merge the Intel code by:
>  * copying it into drivers/pci/msi/intel.c with zero changes.
>  * providing a minimal shim to connect the ops code to the intel code.
>  * at this point the code should be functional but ugly as hell.
>  * via a longish series of patches, adapt the intel code to better match
>    the new ops code.
>  * this should allow us to bisect through to find any mistakes.
>
> If people think that's crazy and or stupid please let me know :)
>
> TBD are:
>  * suspend / resume hooks in the ops - this shouldn't be too tricky with
>    the power management API cleaned up a touch.
>  * working out why the hell msi_remove_pci_irq_vectors() is a special case ?


I haven't done more than skim the patches yet but I am distressed.

You code appears to be nice simple clean and to not support MSI in
a useful way.  I may be reading too quickly but at the moment your infrastructure
appears useless if you are on a platform that doesn't enforce MSI's get filtered
with a legacy interrupt controller.

You don't have MSI-X support (which is the interesting case) and you don't have
suspend/resume support.

You don't support the MSI mask bit.

Looking at your msi_ops it does not map to what I am doing on x86.  There
is the implicit assumption that the msi_message is fixed for the lifetime
of the msi.  Which is wrong.

So in short summary I cannot use your msi_ops they are inappropriate for
i386, x86_64 and ia64.

So at the moment I am opposed to this code because as it sits it appears to
be a serious regression.

The additional bits that feel like this code was primarily targeted at supporting
the RTAS with real hardware support thrown in as an after thought just seem
to add insult to injury.  To date I have no information that indicates to me
that the RTAS model is at all sane or makes any sense to duplicate elsewhere.
If supporting the RTAS is what is obscuring your vision of what is really
needed to support MSI I don't want to see RTAS support in a patch set
until we get a good multiple platform architecture, merged into the kernel.

Supporting the RTAS first and breaking everyone who actually has real
hardware seems like very much the wrong approach to get a good
multiple platform solution.

After I get some sleep I will see if I can up with some constructive
criticism on how we can make things work.

Eric
