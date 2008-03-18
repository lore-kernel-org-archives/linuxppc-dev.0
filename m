Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id E8634DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 13:42:30 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so9153131agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 19:42:29 -0700 (PDT)
Message-ID: <fa686aa40803171942u78d2aa68y47c1de3321f727f1@mail.gmail.com>
Date: Mon, 17 Mar 2008 20:42:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <20080318002650.AE701246C5@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<20080318002650.AE701246C5@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 6:26 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant,
>
>
>  in message <fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com> you wrote:
>  >
>  > However, I have declined (for now) to pick up the defconfigs for those
>  > boards and instead merged in the config features they require into the
>  > mpc5200 defconfig.  My primary reason for doing so is to increase the
>  > likelyhood that full featured kernels are built and tested so that
>  > situations where board ports conflict with each other are caught and
>  > fixed.
>
>  I know what you mean, and I agree with the idea.
>
>  Unfortunately I think it's impossible to implement, especially on such
>  embedded processors with their high level of pin multiplexing.
>
>  For example, if you want to  include  testing  of  the  FEC  ethernet
>  driver,  you  will probably fail to test the second USB port. I think
>  it's simply not possible to test all possible  options  in  a  single
>  kernel  configuration - first it doesn't work (for example because of
>  pin multiplexing issues), second you will likely not be able to  find
>  hardware that implements all features at once.

I don't think this example really applies.  Yes, I agree that I cannot
test all the functions, but that does not preclude building in all the
drivers and making sure that they don't cause a conflict by just being
present.  For instance, I can build a single kernel image right now
that should boot and fully run on the Efika, lite5200, tqm and motion
pro boards (although the Efika has a different wrapper).  I can only
test it on the Efika and lite5200 boards and I have to rely on other
people for the boards I don't have.  If it breaks; I expect to receive
an irate email in my Inbox telling me to fix it!

pin multiplexing shouldn't be an issue at all.  Only the devices which
are instantiated in the device tree will actually get initialized so
if the pins aren't hooked up then it shouldn't be in the tree.
Ideally, the bootloader should take care of the pin multiplexing
setup, but even if it doesn't it can be setup by platform code and
CONFIG_MULTIPLATFORM supports building multiple platforms into a
single image (within a processor family of course; you can't build a
405+6xx multiplatform kernel.)  tqm, motionpro and cm boards can all
use simple platform because they all have good firmware ports that
setup the hardware correctly in the first place.  lite5200(b) does not
because there are quite a few lite5200 boards 'in the wild' with
firmware that doesn't setup the board the way it should be (or at
least the way Linux likes it).

>  > There has been some discussion about having a subdirectory for
>  > optimized board configs, but nobody has done anything about it yet.
>
>  Is this a hint?

Oh, probably.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
