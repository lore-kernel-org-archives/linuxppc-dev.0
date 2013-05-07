Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7C412C016E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 06:34:00 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 7 May 2013 16:33:55 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 1661138C8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 16:33:52 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r47KXp4L291634
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 16:33:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r47KXpfI030923
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 17:33:51 -0300
Date: Tue, 7 May 2013 13:33:47 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL
 bits in HWCAP2
Message-ID: <20130507203346.GA7307@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <1367623431.4389.132.camel@pasglop>
 <20130503234019.GE8561@linux.vnet.ibm.com>
 <OFBCA2593E.F64367AB-ON86257B63.004ED7A8-86257B63.00506FC6@us.ibm.com>
 <1367876228.15842.62.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367876228.15842.62.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Michael R Meissner <mrmeissn@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Ryan Arnold <ryanarn@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07.05.2013 [07:37:08 +1000], Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-06 at 09:38 -0500, Ryan Arnold wrote:
> > My understanding was that these bits being 'on' is an indication of
> > what features the hardware supports (or what the kernel emulates) and
> > a not an indication of whether that facility is currently enabled or
> > not.  If the hardware supports a particular feature but it is not
> > enabled I'd expect that user-space usage of that feature would cause
> > the kernel to trap on a facility availability exception (which is how
> > Altivec/VMX is implemented, being defaulted to turned off).
> 
> Right but the discussion is about whether we should expose the bits
> when the kernel doesn't have the ability to handle the feature :-)
> 
> IE. We need to remove the HTM feature if the kernel is compiled without
> transactional memory support.
> 
> Similarily, Nish, you may need to check that we remove those bits if
> pHyp has the partition in a mode that doesn't support them (P7
> compatibility for example) for migration purposes.

Yep, I'll need to talk with Mikey about this part. Will be a follow-on
patch if needed. Minimally, the bit defines will stay the same, which is
the important part to get going right now.

Thanks,
Nish
