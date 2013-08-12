Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B29412C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 07:25:37 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 13 Aug 2013 18:20:14 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E6F35357804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 07:25:34 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7CL9cNV6357410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 07:09:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7CLPYQh027369
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 07:25:34 +1000
Message-ID: <520952C9.3060101@linux.vnet.ibm.com>
Date: Mon, 12 Aug 2013 16:25:29 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Register bootmem pages at boot on powerpc
References: <52050ACE.4090001@linux.vnet.ibm.com>
 <52050B80.8010602@linux.vnet.ibm.com> <1376266763.32100.144.camel@pasglop>
 <5208DCBC.7060205@linux.vnet.ibm.com> <1376341985.32100.174.camel@pasglop>
In-Reply-To: <1376341985.32100.174.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2013 04:13 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-08-12 at 08:01 -0500, Nathan Fontenot wrote:
>>> Can you tell me a bit more, the above makes me nervous...
>>
>> Ok, I agree. that message isn't quite right.
>>
>> What I wanted to convey is that memory hotplug is not fully supported
>> on powerpc with SPARSE_VMEMMAP enabled.. Perhaps the message should read
>> "Memory hotplug is not fully supported for bootmem info nodes".
>>
>> Thoughts?
> 
> Since SPARSE_VMEMMAP is our default and enabled in our distros, that mean
> that memory hotplug isn't fully supported for us in general ?

Actually... We have had the distros (at least SLES 11 and RHEL 6 releases)
disable SPARSE_VMEMMAP in their releases.

> 
> What do you mean by "not fully supported" ? What precisely is missing ?
> What will happen if one tries to plug or unplug memory?

I don't know everything that is missing, but there are several routines
that need to be defined for power to support memory hotplug with SPARSE_VMEMMAP.

> 
> Shouldn't we fix it ?

Working on it, but it's not there yet.

> 
> Cheers,
> Ben.
> 
> 
