Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050519131844.7D707C1512@atlas.denx.de>
References: <20050519131844.7D707C1512@atlas.denx.de>
Content-Type: text/plain
Date: Fri, 20 May 2005 08:20:29 +1000
Message-Id: <1116541230.5153.8.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, u-boot-users@lists.sourceforge.net
Subject: Re: [U-Boot-Users] RFC: Booting the Linux/ppc64 kernel without
	Open Firmware HOWTO (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-05-19 at 15:18 +0200, Wolfgang Denk wrote:
> Dear Ben,
> 
> in message <1116478614.918.75.camel@gaston> you wrote:
> > 
> > And here is a second draft with more infos.
> > 
> >            Booting the Linux/ppc64 kernel without Open Firmware
> 
> Thanks a lot for taking the initiative to come to an agreement  about
> the kernel boot interface.
> 
> I have some concerns about the memory foot print and  increased  boot
> time  that  will  result  from  the proposed solution. 

Like everybody it seems, which is funny in a way as I expect pretty much
none (or a few Kb maybe). The kernel side code for managing a
device-tree may represent more, but heh, have you seen the size of a
ppc64 kernel anyways ? I don't think that is very relevant. On the
bootloader side, I don't expect any significant impact. The device-tree
can be very small, and the code required on the bootloader side ranges
from nothing for a pre-built one, to a little bit if the bootloader has
to be able to change/add properties/nodes.

> There are many embedded systems where resources are tight and requirements
> are  aven tighter.  

Amen. (Though heh, this is ppc64, you can't be _that_ tight :)

>It  would  be probably a good idea to also ask for feedback
> from these folks - for example by posting your RFC on the celinux-dev
> mailing list.

I will do when I have a little bit more mature proposal.

> But my biggest concern is that we  should  try  to  come  up  with  a
> solution  that  has  a  wider  acceptance.

No other solution will be accepted on the kernel side. At least for
ppc64

> Especially from the U-Boot
> point of view it is not exactly nice that each of  PowerPC,  ARM  and
> MIPS  use  their very own, completely incompatible way of passing in-
> formation from the boot loader to the kernel.

True.

> As is, your proposal will add just another incompatible way of  doing
> the  same  thing  (of course we will have to stay backward compatible
> with U-Boot to allow booting older kernels, too).

My proposal is the only supported way to boot a ppc64 kernel. There are
talks about backporting support for that to ppc32 as well. Other
architectures are welcome to use it too though :) The device-tree in the
kernel is fully expanded into a tree structure on ppc, since it's
heavily used by various pieces of code all over the place, but for other
architectures that would like to use that, it's possible to limit
themselves to the flattened format. The ppc64 kernel contains some code
to access nodes & properties directly from the flattened format (used
early during boot) which represents very little code.

> Why don't we try to come up with a solution that is acceptable to the
> other architectures as well? 

This has been discussed over and over again, that is the best way to
never come up with a solution as everybody will want something different
and nobody will ever agree.

The present proposal is implemented today on the ppc64 kernel already,
and we have decided to not go backward on this requirement. 

> Maybe you want  to  post  the  RFC  to  lkml,  or  at  least  to  the
> linux-arm-kernel and linux-mips mailing lists?
> 
> Best regards,
> 
> Wolfgang Denk
> 
