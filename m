Date: Thu, 25 Jan 2001 22:36:51 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
In-Reply-To: <3A7082DF.CD7E8B61@mvista.com>
Message-ID: <Pine.GSO.4.10.10101252121420.27492-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 25 Jan 2001, Dan Malek wrote:

> On the
> embedded processors, all I/O is mapped through page tables, which
> usually don't have 1:1 mapping.  The existing virt_to_phys and such
> with just the arithmetic adjustment don't work on those.

And it doesn't really have to. virt_to_bus() might be a better place for
this. virt_to_phys() is at least on ia32 a quite speed sensitive function,
that only needs to work on normal low memory.

> Some
> systems have big holes in the physical space, including physical
> addresses that map "under" the fixed kernel virtual addresses.

With holes do you mean several memory chunks? These should be handled with
memory zones.

> I don't know what you mean by more "page oriented" as that is the
> way it works now.  We just use BATs in some cases for efficiency, but
> you don't have to.

I mean drivers get a pointer to a "struct page", what they can use to
get a virtual or physical address.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
