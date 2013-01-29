Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A4BC2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 07:34:22 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 29 Jan 2013 15:34:19 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id C19F338C806B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 15:34:11 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0TKXqPv65601788
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 15:33:52 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0TKXpiR003213
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 18:33:52 -0200
Date: Tue, 29 Jan 2013 12:33:46 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] pseries/iommu: remove DDW on kexec
Message-ID: <20130129203346.GA7664@linux.vnet.ibm.com>
References: <20130129020245.GA12156@linux.vnet.ibm.com>
 <20130129020357.GB12156@linux.vnet.ibm.com>
 <1359457108.26096.7.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359457108.26096.7.camel@concordia>
Cc: miltonm@bga.com, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 29.01.2013 [21:58:28 +1100], Michael Ellerman wrote:
> On Mon, 2013-01-28 at 18:03 -0800, Nishanth Aravamudan wrote:
> > pseries/iommu: remove DDW on kexec
> >  ...
> >     
> > I believe the simplest, easiest-to-maintain fix is to just change our
> > initcall to, rather than detecting and updating the new kernel's DDW
> > knowledge, just remove all DDW configurations. When the drivers
> > re-initialize, we will set everything back up as it was before.
> 
> I don't know this code at all, but this sounds like it will also work
> for kdump, right? ie. when the original kernel has crashed the 2nd
> kernel will tear the DDW down and set it back up.

Yes, my actual test-case (and what was reported as broken) was kdump.
>From my relatively vague (but now growing) understanding of that
process, kdump does use kexec under the covers to switch to the crash
kernel, and so does get the same benefit from this change.

Another datapoint, though, is that it might make sense to recommend (and
I'm working on figuring this out for the distros, etc) to use
disable_ddw anyways for the kdump kernel command-line, as DDW isn't
'free' and it's unclear if performance is a huge concern for the crash
kernel (sort of varies with where your storage is, and how much you need
to dump, which for kdump generally doesn't seem like that much?).

Thanks,
Nish
