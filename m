Message-ID: <3912E688.70D4150D@embeddededge.com>
Date: Fri, 05 May 2000 11:19:36 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Better board support (was Re: [PATCH] Adding support for LXT971/2
 PHYs)
References: <20000505051936.BA2B23C971@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Another example under the scheme would be to replace most of the usages of
> "#ifdef CONFIG_RPXCLASSIC" in fec.c with "#ifdef PHY_QS6612",

Actually, that's already gone (but not yet checked in).  I don't even
have #ifdefs for the PHYS.  I scan the MII looking for all PHYs, when
one responds I match the mfg/device ID to a table and go.

There are thing unique to individual boards that still require board
specific #ifdefs.

> /* Ethernet : PHY controls - connected to port X

Many boards don't use 8xx I/O pins for PHY controls.  They have
external hardware registers for this because they use the 8xx pins
for other communication I/O.  This requires minor board specific
code to be included in the driver.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
