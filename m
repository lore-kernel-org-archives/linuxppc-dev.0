Subject: Re: get_pteptr prototype
From: Hollis Blanchard <hollis@austin.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, devel list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20030107005751.GP22215@zax.zax>
References: <1041893967.1207.42.camel@granite.austin.ibm.com>
	<20030107005751.GP22215@zax.zax>
Content-Type: text/plain
Date: 08 Jan 2003 09:48:48 -0600
Message-Id: <1042040929.1021.80.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-01-06 at 18:57, David Gibson wrote:
>
> On Mon, Jan 06, 2003 at 04:59:26PM -0600, Hollis Blanchard wrote:
> > Hi, I think the prototype for get_pteptr should be moved to
> > asm/pgtable.h . It currently is declared extern in mm/fault.c, and I
> > will need it for platforms/ibm405lp_pm.c .
> >
> > Please apply to _2_4_devel and -2.5, and probably _2_4 for that matter.
>
> Hrm... what are you actually intending to use get_pteptr() for.

I use it to acquire the PTE pointer for a page I need to mark writable
(see the init function in
http://penguinppc.org/~hollis/405LP-sleep.diff). It's sort of like
CONFIG_XMON mapping the whole kernel writable, except I only need one
page. If you know of a better way, please let me know!

> There
> are currently only two users, one of which needs to die (in 2.5, at
> least).  My experience has been that the concept of get_pteptr() is a
> great deal less useful that one would, at first, think.

It's simply a wrapper around successive pte/pmd/pgd_offset calls, with
some error checking. Are you saying those calls are not the correct way
to get the PTE pointer for an address?

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
