Message-ID: <3A6C7FA4.1020905@valinux.com>
Date: Mon, 22 Jan 2001 11:44:52 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: michdaen@iiic.ethz.ch, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch> <3A6C6EEC.D1A84557@mvista.com> <3A6C7143.E49ADF33@relog.ch> <3A6C7DB4.516E2897@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> Michel Dänzer wrote:
>
>> No, that's not the problem, pagelist is struct page ** :-/ (and pagelist is
>> allocated)
>
>
> Then, what the heck were you trying to print out with that
> piece of code, and who further down the food chain uses
> the page struct?
>
>
> 	-- Dan

Some VM code later on uses the page struct to return the correct value
from vma_nopage.  This code supports userland mappings, not just kernel
mappings.  We could of course just use phys_to_page/virt_to_page in the
vma_nopage code, but struct page works just fine.

-Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
