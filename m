Return-Path: <ssh@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id B30C1DDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 07:05:36 +1100 (EST)
Message-ID: <47A37B8E.5000500@sgi.com>
Date: Fri, 01 Feb 2008 14:05:34 -0600
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: 8360 custom board, ucc_geth TX errors on longer(?) packets
References: <47A36A69.1010809@sgi.com>
	<20080201135324.8372268e.kim.phillips@freescale.com>
In-Reply-To: <20080201135324.8372268e.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kim Phillips wrote:
> On Fri, 01 Feb 2008 12:52:25 -0600
> Steven Hein <ssh@sgi.com> wrote:
>
>   
>> The one main difference in this board is how eth0 is wired.
>> We have a Broadcom GbE switch part, and UCC1 eth is wired
>> directly to that switch (no PHY).   (This where I needed to
>>     
>
> sounds like you ran into some h/w errata.  if on rgmii, you might
> want to find a way to program the switch for rgmii with internal delay
> (8360 rev.2 rgmii-id rx & tx; 8360rev2.1 rgmii-rxid (i.e. for rx
> only)).  If not, I'd contact fsl tech support directly.
>
> Kim
>   

I would suspect HW.....but this WORKS with the 2.6.16 kernel
I was using!    That's why I suspect that I still don't have
something configured right in my device tree, or something
else I missed in the new kernel.    But I can't
figure out what it is.... :-(    I've poured over the code in
the old versus new (both the ucc_geth driver and the platform
initialization in the old, and the device tree in the new)
and can't figure out what I missed!   And like I said, a
kernel with the same config (other than changing the platform)
works on my MPC8360E-MDS board.   Granted, that doesn't have
this direct switch connection......

I did look at the code related to the HW errata (QE_ENET18).
But we're using GMII to the switch....and that workaround
code wasn't in active in my old kernel (it was there, but
commented out).

Any other thoughts?    Has anyone seen this symptom before?

Steve

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.                          
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
