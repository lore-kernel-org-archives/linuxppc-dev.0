Return-Path: <linuxram@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 99F982C00C3
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2012 15:03:46 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 18 Jul 2012 01:03:36 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AC30B38C8054
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2012 01:02:33 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6I52X8Z369326
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2012 01:02:33 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6I52WLS020521
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2012 02:02:33 -0300
Date: Wed, 18 Jul 2012 13:02:27 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120718050227.GC2375@ram-ThinkPad-T61>
References: <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw>
 <20120717055715.GF2369@ram-ThinkPad-T61>
 <1342516619.3669.5.camel@pasglop>
 <20120717100314.GB25613@ram-ThinkPad-T61>
 <1342521498.3669.7.camel@pasglop>
 <CAErSpo4AS=QCRE3w-QBzuuSSEK8VeQ+PXxyp3mTyDAEvASxQcQ@mail.gmail.com>
 <20120718010746.GA4238@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120718010746.GA4238@shangw>
Cc: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 yinghai@kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2012 at 09:07:46AM +0800, Gavin Shan wrote:
> 4. Either "b_res->flags & mask" or "type" to be used for window_alignment(),
>    I don't think it's big deal because "b_res->flags & mask == type" for
>    current implementation. However, I'm not sure I still need change it
>    to "type"?
> 
>    min_align = max(min_align, window_alignment(bus, b_res->flags & mask));

Ah. you are right.

(b_res->flags & mask) or type, either one is ok. I had a wrong
assumption about b_res->flags. I thought it has either IORESOURCE_MEM
set or IORESOURCE_PREFETCH set, but not both.

Whatever concern I had, i dont have it any more.
RP
