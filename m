Date: Thu, 8 Jul 1999 07:17:00 -0400
From: Michael Meissner <meissner@cygnus.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: cc/gcc/egcs kernel compilation options?
Message-ID: <19990708071700.A21166@tiktok.cygnus.com>
References: <199907012249.XAA05762@calvin.demon.co.uk> <19990707130317.A21114@drow.res.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19990707130317.A21114@drow.res.cmu.edu>; from Daniel Jacobowitz on Wed, Jul 07, 1999 at 01:03:17PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 07, 1999 at 01:03:17PM -0400, Daniel Jacobowitz wrote:
> 
> On Thu, Jul 01, 1999 at 10:49:57PM +0000, Barrie Spence wrote:
> > 
> > As a PPC newbie, why do we need/use "-msoft-float"? Is this 
> > to handle some processor implementations that don't have 
> > floating-point hardware? (and if so, does it have any overhead 
> > on the 603/604/G3 Macs?). If it does have some cost, could it 
> > not be enabled in the same way as on Intel?
> > 
> > Next question, is there any advantage to building a kernel
> > with "-mcpu=604 -mtune=604"? (or whatever is most appropriate).
> 
> Floating point operations in the kernel are pretty rare, and thus do
> not need to be optimized for speed; soft-float is thus acceptable.  The
> advantage is that we don't need to save/restore the FPU registers and
> state nearly as often.  And I do not know why x86 does not have this
> issue.

The -msoft-float is there to prevent the compiler from converting some double
word moves into load floating/store floating combination.  The x86 compiler
does not allow values with integer modes (QImode, HImode, SImode, etc.) in fp
registers.  The powerpc can't do that since it would break int<->fp
conversions.

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
