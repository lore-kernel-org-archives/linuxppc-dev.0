Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9lLw0fhfzDr3P
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 10:59:50 +1000 (AEST)
Date: Sun, 16 Jul 2017 19:58:46 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Thomas Besemer <thomas.besemer@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: 440EP NOR Flash Mapping with DTS
Message-ID: <20170717005846.GD13471@gate.crashing.org>
References: <CAO7m3AkpuUdApRiiDw+Sv6fqyhVsfBOUA8cw1xChJLxT1r6_wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAO7m3AkpuUdApRiiDw+Sv6fqyhVsfBOUA8cw1xChJLxT1r6_wA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jul 16, 2017 at 05:31:05PM -0700, Thomas Besemer wrote:
> I'm trying to map some NOR flash in via DTS on a Yosemite
> style 440EP board. I've tried a few different things, below
> showing my latest attempt.  During Kernel boot, it does not
> appear to detect the device, as no messages are emitted.
> 
> Flash is Spansion S29GL256P, base address 0xFE000000.
> 
> EBC0: ebc {
>        compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
>        dcr-reg = <0x012 0x002>;
>        #address-cells = <2>;
>        #size-cells = <1>;
>        clock-frequency = <0>; /* Filled in by zImage */
>        interrupts = <0x5 0x1>;
>        interrupt-parent = <&UIC1>;
> 
>        nor_flash@FE0000000,0 {

@0,fe000000

>                reg = <0xFE000000 0x02000000>;

reg = <0 0xfe000000 0x02000000>;


Cheers,


Segher
