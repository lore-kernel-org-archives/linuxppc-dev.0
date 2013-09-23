Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B1D32C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 08:32:43 +1000 (EST)
Message-ID: <1379975475.24959.45.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/6 v7] kvm: booke: clear host tlb reference flag on
 guest tlb invalidation
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Date: Mon, 23 Sep 2013 17:31:15 -0500
In-Reply-To: <1379907769-31452-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379907769-31452-1-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-23 at 09:12 +0530, Bharat Bhushan wrote:
> On booke, "struct tlbe_ref" contains host tlb mapping information
> (pfn: for guest-pfn to pfn, flags: attribute associated with this mapping)
> for a guest tlb entry. So when a guest creates a TLB entry then
> "struct tlbe_ref" is set to point to valid "pfn" and set attributes in
> "flags" field of the above said structure. When a guest TLB entry is
> invalidated then flags field of corresponding "struct tlbe_ref" is
> updated to point that this is no more valid, also we selectively clear
> some other attribute bits, example: if E500_TLB_BITMAP was set then we clear
> E500_TLB_BITMAP, if E500_TLB_TLB0 is set then we clear this.
> 
> Ideally we should clear complete "flags" as this entry is invalid and does not
> have anything to re-used. The other part of the problem is that when we use
> the same entry again then also we do not clear (started doing or-ing etc).
> 
> So far it was working because the selectively clearing mentioned above
> actually clears "flags" what was set during TLB mapping. But the problem
> starts coming when we add more attributes to this then we need to selectively
> clear them and which is not needed.
> 
> This patch we do both
>         - Clear "flags" when invalidating;
>         - Clear "flags" when reusing same entry later
> 
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
> v6->7
>  - Comment re-phrased

Reviewed-by: Scott Wood <scottwood@freescale.com>

-Scott
