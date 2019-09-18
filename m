Return-Path: <SRS0=xS+q=XN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C536C4CEC9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 20:57:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA7620665
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 20:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA7620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46YXNc3MjdzF4m8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 06:57:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=188.165.43.98; helo=14.mo3.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 12675 seconds by postgrey-1.36 at bilbo;
 Thu, 19 Sep 2019 06:55:15 AEST
Received: from 14.mo3.mail-out.ovh.net (14.mo3.mail-out.ovh.net
 [188.165.43.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46YXLC0JMVzF4js
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2019 06:55:11 +1000 (AEST)
Received: from player758.ha.ovh.net (unknown [10.108.57.14])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id CAEC2227788
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2019 22:55:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id C6E4AA0042D8;
 Wed, 18 Sep 2019 20:55:00 +0000 (UTC)
Date: Wed, 18 Sep 2019 22:54:59 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH trivial] KVM: PPC: Remove superfluous check for non-zero
 return value
Message-ID: <20190918225459.0f1091ad@bahia.lan>
In-Reply-To: <20190918184436.5323298d@bahia.lan>
References: <20190911195235.29048-1-thuth@redhat.com>
 <20190918184436.5323298d@bahia.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11072662635729164594
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdduheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: Jiri Kosina <trivial@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 18 Sep 2019 18:44:36 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 11 Sep 2019 21:52:35 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > After the kfree()s haven been removed in the previous
> > commit 9798f4ea71ea ("fix rollback when kvmppc_xive_create fails"),
> > the code can be simplified even more to simply always "return ret"
> > now.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> 
> This looks like a good candidate for trivial, hence Cc'ing Jiri
> and adding trivial keyword in subject.
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 

Oops, the patch is correct but there are some fixes that require
the return 0 to stay around...

https://patchwork.ozlabs.org/project/kvm-ppc/list/?series=129957

> >  arch/powerpc/kvm/book3s_xive.c        | 5 +----
> >  arch/powerpc/kvm/book3s_xive_native.c | 5 +----
> >  2 files changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> > index e3ba67095895..2f6f463fcdfb 100644
> > --- a/arch/powerpc/kvm/book3s_xive.c
> > +++ b/arch/powerpc/kvm/book3s_xive.c
> > @@ -1986,10 +1986,7 @@ static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
> >  
> >  	xive->single_escalation = xive_native_has_single_escalation();
> >  
> > -	if (ret)
> > -		return ret;
> > -
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu)
> > diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
> > index a998823f68a3..7a50772f26fe 100644
> > --- a/arch/powerpc/kvm/book3s_xive_native.c
> > +++ b/arch/powerpc/kvm/book3s_xive_native.c
> > @@ -1089,10 +1089,7 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
> >  	xive->single_escalation = xive_native_has_single_escalation();
> >  	xive->ops = &kvmppc_xive_native_ops;
> >  
> > -	if (ret)
> > -		return ret;
> > -
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  /*
> 

