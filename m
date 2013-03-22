Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A19E82C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 16:14:34 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 22 Mar 2013 15:07:42 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AA4A13578051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 16:14:28 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2M513dG50659560
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 16:01:03 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2M5DvYJ010166
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 16:13:58 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Add accounting for Doorbell interrupts
In-reply-to: <20130322041803.GB26908@concordia>
References: <1363765332-28461-1-git-send-email-imunsie@au1.ibm.com>
 <20130322041803.GB26908@concordia>
Date: Fri, 22 Mar 2013 16:13:57 +1100
Message-Id: <1363928529-sup-704@delenn.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2013-03-22 15:18:03 +1100:
> On Wed, Mar 20, 2013 at 06:42:12PM +1100, Ian Munsie wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > This patch adds a new line to /proc/interrupts to account for the
> > doorbell interrupts that each hardware thread has received. The total
> > interrupt count in /proc/stat will now also include doorbells.
> 
> Should it be inside CONFIG_PPC_DOORBELL ?

The doorbell line will only show up in /proc/interrupt if CPU_FTR_DBELL
is set and the total interrupt count in /proc/stat will be unaffected
if we don't have doorbells (+ 0 doorbells). It still builds fine without
CONFIG_PPC_DOORBELL.

Adding #ifdefs would save one per cpu integer in irq_stat. I can throw
together a v2 patch with them in place.

Cheers,
-Ian
