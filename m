Date: Sat, 31 Mar 2001 20:15:50 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: I-cache flushing on the 7400
Message-ID: <20010331201550.A20735@ibrium.se>
References: <20010331153031.A10946@ibrium.se> <Pine.HPX.4.10.10103311944390.18988-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10103311944390.18988-100000@gra-ux1.iram.es>; from paubert@iram.es on Sat, Mar 31, 2001 at 07:51:55PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 31, 2001 at 07:51:55PM +0200, Gabriel Paubert wrote:

> > 	LI_PHYS( r2,split_store_patch )
> > 	stw     r4,0(r2)			// store instruction
> > 	dcbst   0,r2				// Flush cache
> > 	sync
> > 	icbi    0,r2
> > 	isync
> >
> > 	.... some instructions and then a rfi to split_store_patch ....
> > 	rfi
> >
> > split_store_patch:
> > 	nop
> >
>
> It should, while actually the isync does not seem necessary since rfi
> is a context synchronizing instruction (rfi and sc include implicitly the
> equivalent of an isync).

Yes, but in this case the rfi instruction is within the same cache-line
as the nop. I think I need the extra isync to make sure the cache
line in question is not touched before the invalidation is completed.

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
