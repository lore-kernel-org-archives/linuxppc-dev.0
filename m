Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18088.5537.900347.861055@cargo.ozlabs.ibm.com>
Date: Thu, 26 Jul 2007 13:31:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] Re: 2.6.22-git hangs during boot on PowerBook G3 in 0.0
	seconds
In-Reply-To: <20070724185946.722f34b5.kim.phillips@freescale.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
	<1185234923.5439.158.camel@localhost.localdomain>
	<20070724185946.722f34b5.kim.phillips@freescale.com>
Cc: Rutger Nijlunsing <rutger@nospam.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips writes:

> but yeah, size-cells should be allowed to be 0 (even address-cells) and
> it may be the case that the Lombard needs some fixup code.

So it turns out that the nvram is under the via-pmu node on the
Lombard.  The via-pmu node has #size-cells == 0, which is correct
since things under the via-pmu aren't directly accessible.  The nvram
driver code relies on not being able to translate an address for the
nvram nodes on machines where the nvram isn't directly accessible.
That is, it looks for "nvram" nodes, and if it can translate the
address, assumes it can access the nvram directly.

So nothing is incorrect here except your patch. :)  I'll revert it.

Paul.
