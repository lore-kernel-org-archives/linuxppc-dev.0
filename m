Date: Thu, 25 Jan 2001 22:51:16 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
cc: Roman Zippel <zippel@fh-brandenburg.de>, mgreer@mvista.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
In-Reply-To: <3A7082DF.CD7E8B61@mvista.com>
Message-ID: <Pine.HPX.4.10.10101252142420.22074-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Jan 2001, Dan Malek wrote:

>
> Roman Zippel wrote:
>
> > The problem is the ia32 guys want to address 64GByte, what requires a
> > 64bit physical address, what nobody can handle on 32bit Systems.
>
> Heh....64Gbyte is nothing, just a few more bits beyond 32....you
> don't need 64-bits for this.  In fact, I had a revelation last
> night where I thought we could even do this quite transparently
> on PowerPCs with VSIDs or even context registers, anything that
> implictly gives us a few more bits of virtual address.  Later
> on that.....

You've seen the light, yes it is the way to go at least on 6xx/7xx[x]...

> Of course, the quick solution today would be to just move the
> kernel virtual address to a lower address.........no need for
> highmem config at all.  It wouldn't give you the 64Gbyte, but it
> would solve the immediate problem of 1G real memory.

Or even up to 3Gb easily, while at the same time increasing the virtual
address space of each process. For 36 bit extension, you absolutely need
kmap style kludges, however. 32 bit is nothing, 4Gb of RAM is cheap these
days. OTOH if Motorola has come with real 64 bit processors instead of
this 36 bit band-aid, the point would be moot.

Note that some data has to be accessible at all times from the kernel, and
having less than 1Gb directly accessible while you have 64Gb of RAM
(that's just about 1.5%) is not a healthy situation on x86.

> All I am doing is cleaning up a bunch of the PowerPC MM initialization
> and mapping functions.  Just getting rid of ifdefs, duplication of
> code and stuff like that.  I suspect we will be rewriting in 2.5,
> and there is no sense to do it multiple times for different PPC
> processor variants.
>
> > For what exactly do you need such generic virt_to_phys? AFAIK 2.5 will go
> > more page oriented, so drivers get a set of pages to work on.
>
> All of the embedded PowerPC, and the new high end PowerPC all work
> with page mapped TLBs.  The 'middle' processors, 6xx/7xx/74xx have
> the BAT register enhancement that appears to be going away.  On the

IBM and Motorola are diverging on this point: the 755 has 8 BATS, but
Power4 doesn't have them. I'm still looking for docs on the evolution of
the MMU, this could be important for implementation decisions. But
Motorola could well kill BATS on the next chip depending on the phase of
moon or some horoscope or anything else...

> I don't know what you mean by more "page oriented" as that is the
> way it works now.  We just use BATs in some cases for efficiency, but
> you don't have to.

BATS are a good idea, but variable page size are another, superior IMHO,
possibility. It seems to be what Power4 has from what David said a few
days ago. I don't know how they mix variable page size with hash tables
and failed to find any detailed documentation...

> > ....... Either everything is done with pages or one
> > has to store a virtual/physical address pair. Doing a generic conversion
> > functions for the latter is often slower, so it's currently expected that
> > drivers just store it themselves.
>
> Oh great, yet another technology path we think we are inventing again.
> I hope whoever gets blessed by Linus to work on this takes a serious
> look at over 20 years of research and implementation by others.  Oh
> well, I'll just hack my little mapping functions :-).

Indeed.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
