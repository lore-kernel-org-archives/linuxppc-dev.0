Message-ID: <3A6C6EEC.D1A84557@mvista.com>
Date: Mon, 22 Jan 2001 12:33:32 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Michel Dänzer <michdaen@iiic.ethz.ch>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A686DFE.9030308@valinux.com> <19341214104258.22601@mailhost.mipsys.com> <3A68FC06.7BEEA13D@iiic.ethz.ch> <3A691166.DC6DCD81@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

>                 entry->pagelist[j]= pte_page( *pte );


Bzzzzt....you lose :-).

The pte_page returns the kernel's page_struct for a physical
memory page, not the physical address which you are after......
You ignored the compiler warning here, didn't you :-).

Just do this:

	entry->pagelist[j] = (unsigned long)(pte_val(*pte)) & PAGE_MASK;



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
