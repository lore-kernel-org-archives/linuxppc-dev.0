Return-Path: <dgibson@ozlabs.org>
Date: Sun, 22 Nov 2009 08:20:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vinayak Kale <vinayak.kale@gmail.com>
Subject: Re: DTS for PowerPC 440 based board
Message-ID: <20091121212047.GA29715@yookeroo>
References: <5eb65910911211046q433072f1nd2a6eb955593a37a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5eb65910911211046q433072f1nd2a6eb955593a37a@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 12:16:59AM +0530, Vinayak Kale wrote:
> Hi,
> I am porting 2.6.31 for a PowerPC 440 core based board. I have couple of
> queries. I would really appreciate if someone could answer since i couldn't
> find info from other places.
> 
> 1) Is it mandatory to create a DTS file?

Roughly speaking, yes.  You have to supply a device tree to the
kernel somehow, so if the firmware doesn't supply one itself, you will
need to create a DTS.

> 2) If uboot passes BDInfo struct to kernel instead of DT blob, then in this
> case does kernel creates FDT at run time?

Not exactly.  In this case the bootwrapper will be built with an FDT
(compiled from a dts) built in.  It will however tweak the FDT with
information from the BDInfo before booting the kernel proper.

> 3) I believe in case of DTS, the kernel picks up the h/w info from DTS blob
> so we need not hardcode any register addresses etc inside kernel other than
> in dts file. What happens in case of uboot passing just BDInfo struct. How
> do we specify the register addresses etc?

There's always a device tree which specifies register addresses.  If
the firmware only supplies a BDInfo, then the kernel wrapper must have
a device tree built in.  In practice that will always be built from a
dts, though it doesn't have to be in theory.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
