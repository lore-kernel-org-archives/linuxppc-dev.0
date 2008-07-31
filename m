Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 68694DF40C
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 06:19:59 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so137523anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:19:57 -0700 (PDT)
Message-ID: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
Date: Thu, 31 Jul 2008 14:19:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Board level compatibility matching
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This topic keeps coming up, so it is probably time to address it once
and for all.

When it comes to machine level support in arch/powerpc, there seems to
me that there are two levels or machine support.

Level 1 is the board specific stuff.  Board X has a, b, and c things
that need to be done for Linux to work correctly, but the fixups are
entirely board specific and will only ever be used on a single board
port.  The lite5200 support in arch/powerpc/platforms/52xx is an
example of this kind of board support.  It binds on a value in the top
level compatible property.

Level 2 is kind of the generic catch-all machine support for systems
that are unremarkable and don't require any special code to be run.
In most cases, new boards can be supported by this generic code
without any changes to the Linux kernel.
arch/powerpc/platforms/52xx/mpc5200_simple.c is an example here.
mpc5200_simple maintains a list of boards that are known to work with
it.

At the moment, every new board port forces a linux kernel source tree
change, even if it is just adding a single string to the match table.
I'm willing to wager that 99 times out of 100, boards based on the
mpc5200 SoC will want to use the common board support code and that
maintaining an explicit list of supported boards is completely
unnecessary.  I expect that the exact same is true for 8xxx and 4xx
SoCs.  So, rather than continuing to need to maintain explicit lists,
I propose the following:

- Add a property to the device tree that explicitly specifies the SoC
that the board is based on.  Something like 'soc-model =
"fsl,mpc5200b"' would be appropriate.  This in and of itself does not
change the usage conventions, it just provides more information about
the hardware.  (Another idea is to add a string to the top level
compatible property, but there are still arguments about what
compatible really means in the root node.)

- Prioritize board ports in the arch/powerpc/platforms directory to
identify level-1 machines support from the level-2 ones.  Make sure
that level-1 stuff always gets probed before level-2 stuff within each
SoC family.  In all likelyhood, this would probably just involve
making sure that board specific machines get linked in before the
catchall machine.

- Change level-2 machine support to bind on soc-model instead of an
explicit compatible list.

Doing so should simplify adding new board ports.  In many cases it
would just involve dropping in a new .dts file.  However, it retains
the flexability of overriding generic code with platform specific
fixups as the need arises.  I know we've been cautious about adding
catch-all bindings to the device tree, and it is a big deal to avoid
adding wildcards to compatible values.  However, this solution should
be workable because it doesn't involve stating something that is not
true in the device tree and it maintains the ability to override
cleanly when new bugs are discovered.  It also doesn't try to define
wildcard values in compatible or other device tree properties.

Thoughts?
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
