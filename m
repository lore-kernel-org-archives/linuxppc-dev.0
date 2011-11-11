Return-Path: <ananth@in.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9673CB6F97
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 15:47:48 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 10 Nov 2011 23:47:45 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAB4lhQe2998372
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 23:47:43 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAB4lgxO014193
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 02:47:43 -0200
Date: Fri, 11 Nov 2011 10:17:55 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
Message-ID: <20111111044755.GA19107@in.ibm.com>
References: <20111107044750.GB4361@in.ibm.com>
 <4EB812E8.9090107@freescale.com> <20111108065811.GA9109@in.ibm.com>
 <4EB96002.5030605@freescale.com> <20111109044124.GA10961@in.ibm.com>
 <20111109154825.GB7839@schlenkerla.am.freescale.net>
 <20111110084807.GA16323@in.ibm.com> <1320985094.21206.35.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320985094.21206.35.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, mahesh@linux.vnet.ibm.com
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 11, 2011 at 03:18:14PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2011-11-10 at 14:18 +0530, Ananth N Mavinakayanahalli wrote:
> 
> > 
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > 
> > The Processor Identification Register (PIR) on some powerpc platforms
> > provides information to decode the processor identification tag.
> > Decoding this information is platform specific.
> > 
> > We currently need this information for POWERx processors and hence
> > follows a similar model as adopted for the other POWERx specific
> > features.
> 
> At this rate we're going to end up with no bits left for CPU features
> way too quickly... Especially for something we only care about once at
> boot time.
>
> Wouldn't CPU_FTR_PPCAS_ARCH_V2 be a good enough test ?

/me checks Cell manuals... yes, that test would be good enough. I will
cook up a patch to use this.
 
> Can you tell us a bit more about the real use for that feature ? I still
> don't see what's the point of getting the underlying HW ID.

This is a requirement from the hardware system test folks for use with
their core, node and thread tests.

Ananth
