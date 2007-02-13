Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id C8E37DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 02:37:22 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1614869ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:37:19 -0800 (PST)
Message-ID: <528646bc0702130737t2c4fdb1cj6b994d89c8652c9d@mail.gmail.com>
Date: Tue, 13 Feb 2007 08:37:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mark A. Greer" <mgreer@mvista.com>,
	"linuxppc-dev Development" <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] mpc5200 device tree bindings refinement
In-Reply-To: <20070212205731.GC2729@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0702091038k5188d83fsbc088d875472791c@mail.gmail.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA3029428E1@az33exm25.fsl.freescale.net>
	<20070212205731.GC2729@mag.az.mvista.com>
Cc: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/12/07, Mark A. Greer <mgreer@mvista.com> wrote:
> On Mon, Feb 12, 2007 at 01:48:07PM -0700, Yoder Stuart-B08248 wrote:
> >
> > If the property is to distinguish between multiple
> > devices of the same type how about using
> > 'device-index' or 'device-idx' as a property name.
>
> 2) I (we?) really don't need to know a device index, per se.  What I
> need to know is what set of regs within a block of regs or bits with a
> single register are associated with a device.  Whether its device 0
> or 1 or... doesn't really matter.  That's why I'm partial to
> 'register-set' but I'm always open.

I am concerned that this ends up been premature optimization (of the
device tree).  Hardware designers are fickle people and like to change
shared registers between different chips.  I do agree that logically
the device is attached to a block of registers that can be described
in a separate node (child of the soc node).  But since we have no idea
if it's going to change in the next chip, it's probably better just to
describe it as the block-index on the soc.

Of course, I this begs the argument: "why do we describe anything
about an soc at all; why not just specify the SoC name/revision and be
done with it?"  I don't like that direction myself, but I do find it
non-trivial to find the sweet spot between minimal and "fully-loaded"
device trees.  That just highlights to me that this is just as much of
an art as it is science.  :)

On 2/12/07, Yoder Stuart-B08248 <stuart.yoder@freescale.com> wrote:
> > > Maybe ip-block-index ? :-) The word "cell" can be confusing... or just
> > > "block-index" ?
> >
> > I'm happy with 'block-index'
> >
> If it could be changed I like block-index better.
>
BTW, I'm cool with block-index or ip-block-index too.

Cheers,
g.
-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
