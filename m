Return-Path: <mmporter@cox.net>
Received: from fed1rmmtai12.cox.net (fed1rmmtai12.cox.net [68.230.241.47])
	by ozlabs.org (Postfix) with ESMTP id 528852BF41
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Nov 2004 08:21:42 +1100 (EST)
Date: Wed, 10 Nov 2004 13:52:38 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Adair <dadair@ariodata.com>
Message-ID: <20041110135238.A22537@home.com>
References: <F152162DB1B0D2458EA395AD074DE1C48590CF@orion.ariodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F152162DB1B0D2458EA395AD074DE1C48590CF@orion.ariodata.com>;
	from dadair@ariodata.com on Wed, Nov 10, 2004 at 11:48:31AM -0800
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: Problems with MII mode operation on 440GP ethernet
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Replies set to linuxppc-embedded]

On Wed, Nov 10, 2004 at 11:48:31AM -0800, David Adair wrote:
> Turns out that the problem is that MII mode is getting enabled
> in the ZMII FER register for both EMAC0 and EMAC1 as a result of
> the PHY probe operation on EMAC1.  The older versions do the PHY
> probe during the open while it now occurs earlier.
> 
> Would it be better to fix this by changing the OCP definitions to
> remove EMAC1 or by modifying the Ethernet driver to enforce the
> "only one channel in MII mode" restriction?
> 
> To me it seems like the latter is a better choice since the OCP
> really has more to do with the CPU than my board configuration
> which is defined by the initial values loaded into the ZMII
> FER register.
 
I have a custom board with the same configuration (on 2.6). The
driver in that tree works in this configuration. FWIW, the port
also uses ocp calls to remove the three unused interfaces. In
any case, the latter should be done, but most people would want
to do the port right and remove the second interface anyway.
No need to claim resources and a network interface for something
that can't be used.

> For instance the following works on my boards but contains
> an implicit assumption that emac_init_zmii() is only ever
> called with "AUTO" mode since it relies on valid initial data
> in the fer register.
 
I see. We would want something that handles explicit configuration
in the tree.

> (I also tweaked things so my version of mii-tool would work
> does anyone else have trouble with the wrong variable size?)

I haven't tried 2.4 in a long time...others would know. A lot
of fixes/features have gone into the 2.6 driver that haven't
been backported to 2.4.
 
-Matt
