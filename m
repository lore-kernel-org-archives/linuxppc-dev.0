Message-ID: <3A6C7143.E49ADF33@relog.ch>
Date: Mon, 22 Jan 2001 18:43:31 +0100
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: michdaen@iiic.ethz.ch
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch> <3A6C6EEC.D1A84557@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Michel Dänzer wrote:
>
> >                 entry->pagelist[j]= pte_page( *pte );
>
> Bzzzzt....you lose :-).
>
> The pte_page returns the kernel's page_struct for a physical
> memory page, not the physical address which you are after......
> You ignored the compiler warning here, didn't you :-).

No, that's not the problem, pagelist is struct page ** :-/ (and pagelist is
allocated)

BTW I tried to replace this construct with entry->pagelist[j]= virt_to_page(i)
and it ran through this loop, but died even worse later (pagelist[j]->virtual
!= i). Why doesn't that work?


Seems I have a lot to learn...

Michel


--
Earthling Michel Dänzer (MrCooper)    \   Debian GNU/Linux (powerpc) developer
CS student, Free Software enthusiast   \        XFree86 and DRI project member

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
