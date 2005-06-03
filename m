Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>,
	linuxppc64-dev@ozlabs.org
In-Reply-To: <1117783104.31082.151.camel@gaston>
References: <1117614390.19020.24.camel@gaston>
	<1117614484.19020.27.camel@gaston> <1117783104.31082.151.camel@gaston>
Content-Type: text/plain
Message-Id: <1117819176.6517.290.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 03 Jun 2005 12:19:36 -0500
Subject: Discuss: Adding OF Flat Dev Tree to ppc32
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ben and Folks,

I've read through ppc64/kernel/prom.c and done some minor
call-chain analysis rooted at the two functions:
    early_init_devtree()
    unflatten_device_tree()
as they are apparently the only two referenced in the
initial early boot up process.

My notion was to take the portion of prom.c rooted at
these two functions and add them to the ppc32 line.

First, what portions of pp64/kernel/prom.c are obsolete?
Anything?  You alluded to cleaning this up some, but I
am not too familiar with it to know where that was headed.

Second, there is already a fairly similar prom.c file
hanging out over in ppc32 land.  I _think_ it houses
roughly the complementary code out of ppc64's prom.c
that is NOT derived from the call chain derived from
the above two functions.

Which leads me to the questions:  Is there, or should
we create, a plan to factor the flat-dev-tree handling
code into common or shared ppc code?  I am reluctant
to just outright clone and copy that code if it will
ultimately "be the same" or even "mostly the same".
It seems that the early_init_devtree() might then need
to be refactored or duplicated for ppc32-land.

Are you anticipating the same r3,r4,r5 interface outlined
in your 0.4 rev of the ppc4 OF spec to be used by the
ppc32 world as well?  Seems like it just might...

Naturally, I'm willing to jump in here, just looking
for a bit of global-direction from you. :-)

jdl
