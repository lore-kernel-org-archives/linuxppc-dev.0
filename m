Message-Id: <5.1.0.14.2.20020613192425.02e05368@pop.prodigy.net>
Date: Thu, 13 Jun 2002 19:29:38 -0700
To: Paul Mackerras <paulus@samba.org>
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <15625.11286.524300.137708@argo.ozlabs.ibm.com>
References: <5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
 <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com>
 <20020613205824.GX13541@opus.bloom.county>
 <5.1.0.14.2.20020613151628.02e439e8@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 04:34 PM 6/13/2002, Paul Mackerras wrote:
>Maybe the best answer is to change get_vm_area to use
>
>         (in_interrupt()? GFP_ATOMIC: GFP_KERNEL)
>
>instead of GFP_KERNEL in the kmalloc call, and eliminate the need to
>add the extra parameter.  I'll run that past davem and see what he
>thinks.

Well, your solution is much better :).

Do I understand correctly, we have to modify _all_ vmlist_lock locking to
use _irqsave counterparts?
Not just in get_vm_area, right?

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
