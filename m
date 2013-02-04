Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B5D7B2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 15:25:08 +1100 (EST)
Message-ID: <1359951896.14701.24.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: Fix hash computation function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 04 Feb 2013 15:24:56 +1100
In-Reply-To: <1359948565.25414.12.camel@concordia>
References: <1359524442-5861-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1359948565.25414.12.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-02-04 at 14:29 +1100, Michael Ellerman wrote:
> On Wed, 2013-01-30 at 11:10 +0530, Aneesh Kumar K.V wrote:
> > From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > 
> > The ASM version of hash computation function was truncating the upper bit.
> > Make the ASM version similar to hpt_hash function. Remove masking vsid bits.
> > Without this patch, we observed hang during bootup due to not satisfying page
> > fault request correctly.
> 
> Which commit(s) introduced the bug?

The bug has been there for ever (well, as far back as git goes without
digging the old monster repo) so may as well date from my original port
of the C hashing code to asm.

However it wasn't per-se a bug until Aneesh 64T support was added in 3.7
since we didn't use the top vsid bits that are masked.

I've merged the patch. My only worry is whether there might have been a
reason for the masking in the first place, ie, do we ever carry VSIDs
with bad bits at the top... though the hash mask should take care of
that in any case (well I hope...)

Cheers,
Ben.
