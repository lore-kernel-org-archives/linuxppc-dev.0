Message-ID: <3A6C7015.10001@valinux.com>
Date: Mon, 22 Jan 2001 10:38:29 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Michel Dänzer <michdaen@iiic.ethz.ch>,
        Benjamin 
	Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes 
	<gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch> <3A6C6EEC.D1A84557@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> Michel Dänzer wrote:
>
>>                 entry->pagelist[j]= pte_page( *pte );
>
>
>
> Bzzzzt....you lose :-).
>
> The pte_page returns the kernel's page_struct for a physical
> memory page, not the physical address which you are after......
> You ignored the compiler warning here, didn't you :-).
>
> Just do this:
>
> 	entry->pagelist[j] = (unsigned long)(pte_val(*pte)) & PAGE_MASK;
>
>
>
> 	-- Dan

entry->pagelist is of type struct page *.

-Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
