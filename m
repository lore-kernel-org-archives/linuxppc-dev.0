Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F17B2C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:40:33 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 May 2013 19:40:29 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 21A176E803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 19:40:24 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43NeQT8344326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:40:27 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43NeQbW029803
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 17:40:26 -0600
Date: Fri, 3 May 2013 16:40:19 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL
 bits in HWCAP2
Message-ID: <20130503234019.GE8561@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
 <1367623431.4389.132.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367623431.4389.132.camel@pasglop>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 Michael R Meissner <mrmeissn@us.ibm.com>, sjmunroe@us.ibm.com,
 bergner@us.ibm.com, Ryan Arnold <ryanarn@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.05.2013 [09:23:51 +1000], Benjamin Herrenschmidt wrote:
> On Fri, 2013-05-03 at 16:19 -0700, Nishanth Aravamudan wrote:
> > +/* in AT_HWCAP2 */
> > +#define PPC_FEATURE2_ARCH_2_07         0x80000000
> > +#define PPC_FEATURE2_HTM               0x40000000
> > +#define PPC_FEATURE2_DSCR              0x20000000
> > +#define PPC_FEATURE2_EBB               0x10000000
> > +#define PPC_FEATURE2_ISEL              0x08000000
> 
> Should we "adjust" (ie filter out) some of these based
> on CONFIG_ options (such as transactional memory enabled,
> EBB supported by the hypervisor, etc...) ?

Err, yeah, that seems reasonable :) However, it seems like glibc uses
these values rather directly so it knows what bits to check for each
feature. Therefore, it seems like it would be better to do the
ifdeffery/checking in the user in cputable.c, but that seems like it
could get quite complicated.

Would it be ok (I guess I'm asking Ryan & co. here) to have an #ifdef in
the definition that may or may not mean the bit is set in the aux
vector, but the bit, if set, would always be the same bit?

-Nish
