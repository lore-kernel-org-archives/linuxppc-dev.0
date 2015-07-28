Return-Path: <prvs=6444d210c=david.vrabel@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FCAA1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 03:16:45 +1000 (AEST)
Message-ID: <55B7B8D2.5060107@citrix.com>
Date: Tue, 28 Jul 2015 18:16:02 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Julien Grall <julien.grall@citrix.com>, <xen-devel@lists.xenproject.org>
CC: <linux-fbdev@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Jiri
 Slaby" <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 <stefano.stabellini@eu.citrix.com>, Russell King <linux@arm.linux.org.uk>,
 <linux-scsi@vger.kernel.org>, <x86@kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ti.com>, <linux-input@vger.kernel.org>, "Jean-Christophe
 Plagniol-Villard" <plagnioj@jcrosoft.com>, <ian.campbell@citrix.com>, "James
 E.J. Bottomley" <JBottomley@odin.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 <linux-arm-kernel@lists.infradead.org>, Juergen Gross <jgross@suse.com>,
 "Wei Liu" <wei.liu2@citrix.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 <linux-kernel@vger.kernel.org>, David Vrabel <david.vrabel@citrix.com>,
 <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?B?Um9nZXIg?= =?UTF-8?B?UGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH 4/8] xen: Use the correctly the Xen memory
 terminologies
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/07/15 16:02, Julien Grall wrote:
> Based on include/xen/mm.h [1], Linux is mistakenly using MFN when GFN
> is meant, I suspect this is because the first support for Xen was for
> PV. This brough some misimplementation of helpers on ARM and make the
> developper confused the expected behavior.

For the benefit of other subsystem maintainers, this is a purely
mechanical change in Xen-specific terminology.  It doesn't need reviews
or acks from non-Xen people (IMO).

> For instance, with pfn_to_mfn, we expect to get an MFN based on the name.
> Although, if we look at the implementation on x86, it's returning a GFN.
> 
> For clarity and avoid new confusion, replace any reference of mfn into
> gnf in any helpers used by PV drivers.
> 
> Take also the opportunity to simplify simple construction such
> as pfn_to_mfn(page_to_pfn(page)) into page_to_gfn. More complex clean up
> will come in follow-up patches.
> 
> I think it may be possible to do further clean up in the x86 code to
> ensure that helpers returning machine address (such as virt_address) is
> not used by no auto-translated guests. I will let x86 xen expert doing
> it.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

It looks a bit odd to use GFN in some of the PV code where the
hypervisor API uses MFN but overall I think using the correct
terminology where possible is best.  But I'd like to have Boris's or
Konrad's opinion on this.

David
