Subject: Re: Activating SystemACE support
From: Jeff Angielski <jeff@theptrgroup.com>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <10318-29667@sneakemail.com>
References: <10318-29667@sneakemail.com>
Content-Type: text/plain
Message-Id: <1077811344.4225.12.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 26 Feb 2004 11:02:24 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-02-25 at 22:54, Stephen Williams wrote:
>
> I have a board that, like the Xilinx ml300 board, has a SystemACE
> chip on it. I would like to activate the existing SystemACE drivers
> support in the kernel, but it is not clear to me how I pass to the
> drivers the base address and IRQ that has been assigned. Does anyone
> has any suggestions?
>

The SystemACE driver is currently written as a subset of the
CONFIG_XILINX_OCP code.  So the easiest thing is to just add another
xparameters_xxxx.h and have it conditionally included into the
arch/ppc/platforms/xilinx_ocp/xparameters.h file.  Put your board
specific information in that file and you should be fine from there.

You might have to also munge the config.in files and/or Makefiles to
make sure everything gets included that needs to be there to support the
SystemACE.

Incidentally, I would be interested in hearing what kind of transfer
rates people are seeing using the SystemACE.  I have run some Bonnie
tests on the filesystem on my MPC8266 board and it is pretty slow.

Jeff Angielski
The PTR Group


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
