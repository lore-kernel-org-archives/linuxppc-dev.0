Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFCE61007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  1 Nov 2009 21:03:17 +1100 (EST)
In-Reply-To: <OFA2803682.B247ED64-ONC1257660.007B44F5-C1257660.007BB531@transmode.se>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<200910311742.56280.mb@bu3sch.de>
	<OF7FB0F99B.2962ECBA-ONC1257660.006EDDB5-C1257660.006F2808@transmode.se>
	<200910312135.34196.mb@bu3sch.de>
	<OFA2803682.B247ED64-ONC1257660.007B44F5-C1257660.007BB531@transmode.se>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <67287DD7-C1FB-48B8-871C-52CA101C4BC8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Accessing flash directly from User Space [SOLVED]
Date: Sun, 1 Nov 2009 11:07:24 +0100
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "bgat@billgatliff.com" <bgat@billgatliff.com>,
	Alessandro Rubini <rubini@gnudd.com>,
	Jonathan Haws <Jonathan.Haws@sdl.usu.edu>,
	"scottwood@freescale.com" <scottwood@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> mmio[0] = address;
>>>> mmio[1] = data;
>>>> mb();

eieio is enough here.

>>>> mmio[3] |= 0x01; /* This triggers an operation -> address=data */
>>>> /* probably also need an mb() here, if the following code
>>>>  * depends on the operation to be triggered. */

No, a sync does not guarantee the device has seen the store yet;
you need something specific to the device to guarantee this.
Usually a load (from the same register!) followed by code that
makes sure the load has finished is sufficient (and necessary).

>>> hmm, the mmio[0] and mmio[1] are written in order I hope?
>>
>> We do not care in this example, as the write to [3] does trigger
>> the device operation. We do only care that [0] and [1] are set
>> when [3] is written. We do not care in what order [0] and [1] are  
>> written.
>
> In this example yes, I was wondering in general.

The writes will not be reordered, but they can be combined,
unless you put an eieio (or sync) inbetween.

> So what does guarded memory mapping on ppc mean really? If I need
> that much mb(), guarded does not seem to do much.

Loosely speaking, guarded means no prefetch is done.


Segher
