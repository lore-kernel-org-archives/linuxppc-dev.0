To: Val Henson <val@nmt.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
In-Reply-To: Message from Val Henson <val@nmt.edu>
   of "Mon, 25 Mar 2002 20:21:32 PDT." <20020325202132.M24258@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Mar 2002 15:14:34 +1100
Message-ID: <19114.1017116074@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 25 Mar 2002 20:21:32 -0700, Val Henson <val@nmt.edu> writes:
>I'm happy to hear reasons for why a more complicated interface is a
>good idea.

benh wanted to "find" a particular BI_DEVICE bi_rec within multiple instances.
I think what you are suggesting requires that there be only one instance of any
given (top-level) tag. yes? If not, how do you determine which bi_rec to return?
Always the first one you come across? or maintain a pointer and have subsequent
calls return the next one, until there are no more, at which time you return NULL?

I think benh was suggesting that you have many "top-level" BI_DEVICE bi_recs,
then have some interface to "find" one of them (either by "name", or by some
variable length "device id") - each driver (that wants to) then looks for it's
bi_rec when it is initialised. This would require that every BI_DEVICE bi_rec
"contains" either a "name" bi_rec or a "device id" bi_rec - otherwise it would
never be found (using the proposed interface functions). Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
