Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D08B1A023A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 07:09:36 +1000 (AEST)
Message-ID: <55B7EECD.8050605@zytor.com>
Date: Tue, 28 Jul 2015 14:06:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Julien Grall <julien.grall@citrix.com>, xen-devel@lists.xenproject.org
CC: ian.campbell@citrix.com, stefano.stabellini@eu.citrix.com,
 linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Vrabel <david.vrabel@citrix.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>,
 "James E.J. Bottomley" <JBottomley@odin.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Jiri Slaby <jslaby@suse.com>, Juergen Gross <jgross@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, =?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
 <roger.pau@citrix.com>, Russell King <linux@arm.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, Wei Liu <wei.liu2@citrix.com>,
 x86@kernel.org
Subject: Re: [PATCH 0/8] Use correctly the Xen memory terminologies in Linux
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2015 08:02 AM, Julien Grall wrote:
> Hi all,
> 
> This patch series aims to use the memory terminologies described in
> include/linux/mm.h [1] for Linux xen code.
> 
> Linux is using mistakenly MFN when GFN is meant, I suspect this is because the
> first support of Xen was for PV. This has brought some misimplementation
> of memory helpers on ARM and make the developper confused about the expected
> behavior.
> 
> For instance, with pfn_to_mfn, we expect to get a MFN based on the name.
> Although, if we look at the implementation on x86, it's returning a GFN.
> Most of the callers are also using it this way.
> 
> The first 2 patches of this series is ARM related in order to remove
> PV specific helpers which should not be used and fixing the implementation of
> pfn_to_mfn.
> 
> The rest of the series is here rename most of the usage in the common code
> of MFN to GFN. I also took the opportunity to replace most of the call to
> pfn_to_gfn in the common code by page_to_gfn avoid construction such
> as pfn_to_gfn(page_to_pfn(...).
> 
> Note the one xen-blkfront will be dropped by 64K series [2], I can include it
> if necessary.
> 

Can we actually get some documentation for Xen before starting to change
names around?

	-hpa
