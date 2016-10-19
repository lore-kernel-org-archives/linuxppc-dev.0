Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szWjG432hzDt3w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 23:39:30 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH] powerpc: link error on orphan sections
Date: Wed, 19 Oct 2016 12:36:09 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0205B19@AcuExch.aculab.com>
References: <20161012070020.30170-1-npiggin@gmail.com>
 <87zim7dag4.fsf@concordia.ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6DB01E8778@AcuExch.aculab.com>
 <87d1iw4knx.fsf@concordia.ellerman.id.au>
In-Reply-To: <87d1iw4knx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> > In the past I've caused orphan sections to error by assigning them
> > to the same address as something that exists.
> > Works with all linkers, even if the error message isn't as useful.
>=20
> How do you assign them an address without knowing what they are? With a
> wild card rule?

Right at the end of the ldscript I have:

    /* Anything from any unexpected section ends up here and
     * generates an error because this overlaps another section */
    unwanted _gp : { *(*) }
}

	David
