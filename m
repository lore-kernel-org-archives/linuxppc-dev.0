Date: Thu, 9 Jan 2003 13:33:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: paulus@samba.org, devel list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: get_pteptr prototype
Message-ID: <20030109023300.GC6569@zax.zax>
References: <1041893967.1207.42.camel@granite.austin.ibm.com> <20030107005751.GP22215@zax.zax> <1042040929.1021.80.camel@granite.austin.ibm.com> <20030108234908.GA1088@zax.zax> <1042071086.1207.206.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1042071086.1207.206.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 08, 2003 at 06:11:25PM -0600, Hollis Blanchard wrote:
>
> On Wed, 2003-01-08 at 17:49, David Gibson wrote:
> > On Wed, Jan 08, 2003 at 09:48:48AM -0600, Hollis Blanchard wrote:
> > > It's simply a wrapper around successive pte/pmd/pgd_offset calls, with
> > > some error checking. Are you saying those calls are not the correct way
> > > to get the PTE pointer for an address?
> >
> > Trouble is that this will break badly in 2.5 where we use large-page
> > entries for the lowmem mapping.
>
> I'm happy to change it to something 2.5-friendly if someone can suggest
> how...
>
> Alternatively I can add 405LP to the XMON/KGDB/BDI2000 list of ifdefs
> that map the whole kernel writable, which would be overkill but avoid
> adding PTE manipulations.

Hmm... what's the reason that wakeup_info needs to be reserved in
head_4xx.S, rather than just being a normal variable in the data area
(which should be writable anyway)?  Its not obvious to me from the
patch.

Actually, skimming through the patch I noticed a minor nit: you only
have one .long in head_4xx.S reserving space for the wakeup_info
struct which is 3 words long.  In practice the . = in the exception
handlers will give you plenty of space, but I think it would be good
form to explicitly reserve the right amount of space.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
