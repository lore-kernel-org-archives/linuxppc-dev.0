Return-Path: <aik@ozlabs.ru>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C6982C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 17:27:50 +1100 (EST)
Received: by mail-ia0-f179.google.com with SMTP id o25so1615655iad.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 22:27:48 -0800 (PST)
Message-ID: <50C9755D.6060300@ozlabs.ru>
Date: Thu, 13 Dec 2012 17:27:41 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] vfio powerpc: enabled on powernv platform
References: <1354636299.1809.431.camel@bling.home>
 <1354865750-8104-1-git-send-email-aik@ozlabs.ru>
 <1354901926.3224.96.camel@bling.home> <50C820AF.8050804@ozlabs.ru>
 <1355322875.3224.201.camel@bling.home> <1355365763.19932.75.camel@pasglop>
In-Reply-To: <1355365763.19932.75.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/12/12 13:29, Benjamin Herrenschmidt wrote:
> On Wed, 2012-12-12 at 07:34 -0700, Alex Williamson wrote:
>>> But what would I put there?... IOMMU ID is more than enough at the moment
>>> and struct iommu_table does not have anything what would have made sense to
>>> show in the sysfs...
>>
>> I believe David mentioned that PEs had user visible names.  Perhaps they
>> match an enclosure location or something.  Group numbers are rather
>> arbitrary and really have no guarantee of persistence.  Thanks,
>
> I agree. Make up something, for example domain[PE] or something like
> that.

To be able to add a PE number, I need to call iommu_group_alloc() in the 
correct place where I know this number OR I have to carry it in iommu_table 
till the moment the iommu_group_alloc() is called (acceptable but not cool).

I will post a patch which would help as a response to this mail.


-- 
Alexey
