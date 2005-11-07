Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 952966869D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 01:45:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 7 Nov 2005 15:32:52 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5A2@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
	"Pantelis Antoniou" <pantelis.antoniou@gmail.com>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
Subject: RE: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Marcelo

[SNIP]=20
> The root of the problem are the changes against the 8xx TLB=20
> handlers introduced
> during v2.6. What happens is the TLBMiss handlers load the=20
> zeroed pte into
> the TLB, causing the TLBError handler to be invoked (thats=20
> two TLB faults per=20
> pagefault), which then jumps to the generic MM code to setup the pte.
>=20
> The bug is that the zeroed TLB is not invalidated (the same reason
> for the "dcbst" misbehaviour), resulting in infinite TLBError faults.
>=20
> Dan, I wonder why we just don't go back to v2.4 behaviour.

This is one reason why it is the way it is:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016382.html
This details are little fuzzy ATM, but I think the reason for the
current
impl. was only that it was less intrusive to impl.

 Jocke
