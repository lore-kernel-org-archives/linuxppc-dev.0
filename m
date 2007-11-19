Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 5E9B7DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 05:27:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Xilinx TEMAC driver
Date: Mon, 19 Nov 2007 12:07:34 -0600
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333F0A58D2@XMBIL132.northgrum.com>
In-Reply-To: <47392A2A.7020200@itee.uq.edu.au>
References: <46A5C305.5000903@dlasys.net><fa686aa40707242129p1b5f5299i44818ead5ed4d2f3@mail.gmail.com>
	<47392A2A.7020200@itee.uq.edu.au>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "John Williams" <jwilliams@itee.uq.edu.au>,
	"Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>> On 7/24/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>>=20
>>>    Hopefully this is not too much of a mess.

>> Hooray!  Thanks for posting your work.  I'm keen to try this on my=20
>> platform.  Comments below.
>>=20

> [snip]
> Any progress on the ll_temac driver since July?  In EDK9.2, ll_temac
is really the only supported ethernet solution, apart from ethernet lite
(yuck).
> If there's a PPC version in a reasonable state, i'm happy to see
what's requierd to port it across to MicroBlaze.
> cheers,
> John

John,

I have a ll_temac for CDMAC version that I made for >2.6.19 that used
the old wrapper from a MontaVista 2.4 kernel. It was tested (not overly
stressed) and working at speeds > 100Mb. I plan on moving it to a
unified source once I had a LocalLink TEMAC that would support my
hardware. Xilinx did not support ll_temac w/ RGMII or SGMII which are
both found on the ML410 for Gigabit.

I currently use David's driver with much success now for the plb_temac.
I have a modified version that has been mostly cleaned up. I did remove
the ll stuff since it was for a Pico(??) LocalLink TEMAC that I could
not find, and not the Xilinx LocalLink TEMAC w/ CDMAC, which is what I
was interested in. If interested, I could finish the clean-up on it and
post a patch for it (once I figure out how to actually make the patch
:P). Right now what mainly remains is finish grouping the functions for
FIFO and starting support for DMA.

-- Mike
