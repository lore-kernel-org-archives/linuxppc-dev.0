Message-ID: <39D66E4D.4364FC8B@mvista.com>
Date: Sat, 30 Sep 2000 15:50:53 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: frowand@mvista.com, Dan Malek <dan@mvista.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <19340822040932.8760@mailhost.mipsys.com>
		<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
		<14803.57550.118150.759977@argo.linuxcare.com.au>
		<39D41AA2.C586D738@mvista.com>
		<14804.7238.688771.238444@argo.linuxcare.com.au>
		<39D4E85F.926CFD5B@mvista.com> <14805.17492.766815.388301@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> Frank Rowand writes:
>
> > Paul Mackerras wrote:
> [snip]
> > > Because we'll make it the same value for all ports.  Anybody got any
> > > objections to 0xff000000?
>
> > Yes.  It is equivalently mapped on the PPC 405 at 0xe8000000.
>
> But that's a physical address, not necessarily a virtual address,
> right?  I was talking about virtual address 0xff000000.  Any
> particular reason why you have to have virtual == physical?  (If there
> is, my response will probably be "fix it". :-)

If the answer ends up "fix it", that's fine.  Dan Malek has been providing
me lots of review of the code I've been doing for the 405, helping me to
learn the Linux PowerPC way of doing things so I have lots of practice at
fixing things.

The address 0xe8000000 is both the physical and the virtual address
("equivalently mapped").  I can move the virtual address to 0xff000000
(kernel people can do anything, right?).

This raises a question about equivalent mapping though.  Everything above
ioremap_base is equivalently mapped by ioremap().  In 2.4.0-test2
ioremap_base is initialized in MMU_init():

  0xe8000000  #ifdef CONFIG_IBM405
  0xfffff000  #ifdef CONFIG_POWER4
  0xf0000000  _MACH_prep
  0xf8000000  _MACH_Pmac
  0xe0000000  _MACH_8260
  0xf8000000  everything else

Is it wise to hardcode a virtual address of 0xff000000 to a specific
object?  If that is done, then an ioremap of physical address
0xff000000 will also have the same virtual address.  What am I missing?

So to answer your question, I arbitrarilly chose 0xe8000000 as ioremap_base
because it seemed within reason, given other existing values.  I can move
ioremap_base to lots of other places if I need to.


>
> Paul.
>
> --
> Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
> +61 2 6262 8990 tel, +61 2 6262 8991 fax
> paulus@linuxcare.com.au, http://www.linuxcare.com.au/
> Linuxcare.  Support for the revolution.

Thanks,

Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
