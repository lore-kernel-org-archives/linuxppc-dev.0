Return-Path: <dgibson@ozlabs.org>
Date: Mon, 30 Apr 2007 16:06:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/13] powerpc: Add Makefile rule to wrap dts file in zImage
Message-ID: <20070430060614.GA4683@localhost.localdomain>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235504.GC4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070425235504.GC4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2007 at 04:55:04PM -0700, Mark A. Greer wrote:
> Add 'zImage.dts' and 'zImage.dts_initrd' build rules that automatically
> compile and wrap a dts file into the zImage file.  The rules are similar
> to the initrd rules.
> 
> The dts file is expected to be arch/powerpc/boot/dts/$(CONFIG_DEVICE_TREE)

Hrm.  It would make more sense to extend the existing zImage.% rule to
pass in the dts (making sure it still works with no dts, obviously).
We shouldn't need this two-level indirection of make targets, either
through dts-y, see my recent patch of cuboot cleanups to see how I
removed that for Scott Wood's cuboot stuff.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
