Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 914F167B35
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 22:59:43 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1406562ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 05:59:41 -0700 (PDT)
Message-ID: <528646bc0605230553o72bd9d85r6d95580fdaaf9a72@mail.gmail.com>
Date: Tue, 23 May 2006 06:53:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Ming Liu" <eemingliu@hotmail.com>
Subject: Re: Tri-mode or gigebit ethernet support problem in ML403
In-Reply-To: <BAY110-F197CC0259C9877D5B47F3B29B0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY110-F197CC0259C9877D5B47F3B29B0@phx.gbl>
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

On 5/23/06, Ming Liu <eemingliu@hotmail.com> wrote:
> Hi Grant,
> I want to ask you a problem about the 1000M ethernet support. Now I am
> trying to integrate a linux (2.4 or 2.6) in my ML403 platform, with
> tri-mode ethernet support. And I have downloaded many versions of linux,
> including linuxppc_2_4_devel, MontaVista linux 3.1 Preview
> Kit(v2.4.20_mvl31-ml300), and linux-xilinx-26. Unfortunately, I didn't fi=
nd
> any option in the menuconfig item Network Device Support->ethernet
> (1000Mbit) for me to enable the 1000M ethernet in all three versions.

I hate to be the bearer of bad news, but AFAIK non of the public trees
have a driver for the TEMAC.  Xilinx EDK 8.1 does include drivers for
the TEMAC and it *should* generate a working BSP for MontaVista Linux
3.1 (patched 2.4 kernel).  It should also work with the linuxppc-2.4
tree.

If you want it on a 2.6, you'll need to port the driver.  Regardless,
the Xilinx driver code is NOT GPL'd, so beware.

> So I have the following questions to ask.
>
> 1. With Xilinx Virtex 4 tri-mode ethernet MAC support, which version of
> Linux shall I use? I think I should choose a version with Xilinx On-chip
> Ethernet supported in the 1000M ethernet item in menuconfig.

Both Linux 2.4 and 2.6 are usable.  You've got some work to do to port
the driver in either case.

> 2. Assume that you can provide me a proper version. Shall I use Xilinx ED=
K
> to generate the BSP for my platform and copy the source code to overwrite
> the drivers in the original version. Then configure the kernel and enable
> 1000M ethernet (choose Xilinx on-chip ethernet). Then compile the
> kernel...... Are these steps correct?

The TEMAC and EMAC are totally different devices, and I haven't looked
to see if TEMAC driver uses the same API, but it is probably a good
starting point.

Cheers,
g.

--=20
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
