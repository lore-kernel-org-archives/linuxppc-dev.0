Return-Path: <SRS0=d9E3=FP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD63C433FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 05:29:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A4A23D50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 05:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A4A23D50
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsfV835kTzDqvx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 16:29:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsfSQ3qflzDqrm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2020 16:27:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=Xkrq96BD; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4CsfSQ1c52z9sWS; Fri, 11 Dec 2020 16:27:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1607664470; bh=KCtiru4Zi8d+YqJORQKk8XMRhcLRedA9e5sZ52eDqd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xkrq96BDhTklQ0K8ESjMBS/H2JDLfSb6lCg9u5s6yVFA7aWoUsHktu+P2KmAFEIwL
 4ttkjA+dqz8LuIDBIDLK2pIzqL8MYluoU+romI05TdvWFUuZ/PnnRv3wyc0aAUgzRu
 1r9m0lEvvQsI/iX7OHps3Cj7zrGJVltUQOXeUhM2oYQX7MKXxD/paAJkFga/fyvDQU
 hAGWr7xpEPcWhmmUUy+T2F25KCVA4ok0sgd/Ob8irX8W8cEtDCAQ4u1kyoNyy4kGkE
 Nt3PghgUf2qkq0ctk/aPt8EswcTe8OL+YCA4WsdAuSxSZ3SbMDMdwU9XIEJtEIOQCB
 9YdUqOMfUP/Ww==
Date: Fri, 11 Dec 2020 16:27:44 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v1 1/2] KVM: PPC: Book3S HV: Add support for
 H_RPT_INVALIDATE (nested case only)
Message-ID: <20201211052744.GB69862@thinks.paulus.ozlabs.org>
References: <20201019112642.53016-1-bharata@linux.ibm.com>
 <20201019112642.53016-2-bharata@linux.ibm.com>
 <20201209041542.GA29825@thinks.paulus.ozlabs.org>
 <20201210042418.GA775394@in.ibm.com>
 <20201211011639.GD4874@yekko.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211011639.GD4874@yekko.fritz.box>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: npiggin@gmail.com, Bharata B Rao <bharata@linux.ibm.com>,
 kvm-ppc@vger.kernel.org, aneesh.kumar@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 11, 2020 at 12:16:39PM +1100, David Gibson wrote:
> On Thu, Dec 10, 2020 at 09:54:18AM +0530, Bharata B Rao wrote:
> > On Wed, Dec 09, 2020 at 03:15:42PM +1100, Paul Mackerras wrote:
> > > On Mon, Oct 19, 2020 at 04:56:41PM +0530, Bharata B Rao wrote:
> > > > Implements H_RPT_INVALIDATE hcall and supports only nested case
> > > > currently.
> > > > 
> > > > A KVM capability KVM_CAP_RPT_INVALIDATE is added to indicate the
> > > > support for this hcall.
> > > 
> > > I have a couple of questions about this patch:
> > > 
> > > 1. Is this something that is useful today, or is it something that may
> > > become useful in the future depending on future product plans? In
> > > other words, what advantage is there to forcing L2 guests to use this
> > > hcall instead of doing tlbie themselves?
> > 
> > H_RPT_INVALIDATE will replace the use of the existing H_TLB_INVALIDATE
> > for nested partition scoped invalidations. Implementations that want to
> > off-load invalidations to the host (when GTSE=0) would have to bother
> > about only one hcall (H_RPT_INVALIDATE)
> > 
> > > 
> > > 2. Why does it need to be added to the default-enabled hcall list?
> > > 
> > > There is a concern that if this is enabled by default we could get the
> > > situation where a guest using it gets migrated to a host that doesn't
> > > support it, which would be bad.  That is the reason that all new
> > > things like this are disabled by default and only enabled by userspace
> > > (i.e. QEMU) in situations where we can enforce that it is available on
> > > all hosts to which the VM might be migrated.
> > 
> > As you suggested privately, I am thinking of falling back to
> > H_TLB_INVALIDATE in case where this new hcall fails due to not being
> > present. That should address the migration case that you mention
> > above. With that and leaving the new hcall enabled by default
> > is good okay?
> 
> No.  Assuming that guests will have some fallback is not how the qemu
> migration compatibility model works.  If we specify an old machine
> type, we need to provide the same environment that the older host
> would have.

I misunderstood what this patchset is about when I first looked at
it.  H_RPT_INVALIDATE has two separate functions; one is to do
process-scoped invalidations for a guest when LPCR[GTSE] = 0 (i.e.,
when the guest is not permitted to do tlbie itself), and the other is
to do partition-scoped invalidations that an L1 hypervisor needs to do
on behalf of an L2 guest.  The second function is a replacement and
standardization of the existing H_TLB_INVALIDATE which was introduced
with the nested virtualization code (using a hypercall number from the
platform-specific range).

This patchset only implements the second function, not the first.  The
first function remains unimplemented in KVM at present.

Given that QEMU will need changes for a guest to be able to exploit
H_RPT_INVALIDATE (at a minimum, adding a device tree property), it
doesn't seem onerous for QEMU to have to enable the hcall with
KVM_CAP_PPC_ENABLE_HCALL.  I think that the control on whether the
hcall is handled in KVM along with the control on nested hypervisor
function provides adequate control for QEMU without needing a writable
capability.  The read-only capability to say whether the hcall exists
does seem useful.

Given all that, I'm veering towards taking Bharata's patchset pretty
much as-is, minus the addition of H_RPT_INVALIDATE to the
default-enabled set.

Paul.
