Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1DCC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 14:55:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B7B217D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 14:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B7B217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LFDq1BrfzDqxd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 01:55:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.76.65; helo=2.mo6.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo6.mail-out.ovh.net (2.mo6.mail-out.ovh.net [46.105.76.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LFBV5FJ0zDqkc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 01:53:38 +1100 (AEDT)
Received: from player695.ha.ovh.net (unknown [10.109.143.24])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id B75761A011F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 15:53:34 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 76037EDF6C2;
 Thu, 20 Dec 2018 14:53:28 +0000 (UTC)
Date: Thu, 20 Dec 2018 15:53:27 +0100
From: Greg Kurz <groug@kaod.org>
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: Re: [PATCH] ocxl: Fix endiannes bug in ocxl_link_update_pe()
Message-ID: <20181220155327.1f963769@bahia.lan>
In-Reply-To: <facf5e15f5791dd8ddf92d25aee0d2c0a0cdda95.camel@au1.ibm.com>
References: <154499573000.310603.8247296576061305045.stgit@bahia.lan>
 <facf5e15f5791dd8ddf92d25aee0d2c0a0cdda95.camel@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12460897219870103883
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudejfedgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 17 Dec 2018 11:38:51 +1100
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> On Sun, 2018-12-16 at 22:28 +0100, Greg Kurz wrote:
> > All fields in the PE are big-endian. Use cpu_to_be32() like
> > everywhere
> > else something is written to the PE. Otherwise a wrong TID will be
> > used
> > by the NPU. If this TID happens to point to an existing thread
> > sharing
> > the same mm, it could be woken up by error. This is highly improbable
> > though. The likely outcome of this is the NPU not finding the target
> > thread and forcing the AFU into sending an interrupt, which userspace
> > is supposed to handle anyway.
> > 
> > Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on
> > POWER9")
> > Cc: stable@vger.kernel.org      # v4.18
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > 
> > This bug remained unnoticed so far because the current OCXL test
> > suite
> > happens to call OCXL_IOCTL_ENABLE_P9_WAIT before attaching a context.
> > This causes ocxl_link_update_pe() to be called before
> > ocxl_link_add_pe()
> > which re-writes the TID in the PE with the appropriate endianness.
> > 
> > I have some patches that change the behavior of the OCXL test suite
> > so that
> > it can catch the issue:
> > 
> > https://github.com/gkurz/libocxl/commits/wake-host-thread-rework
> > ---
> >  drivers/misc/ocxl/link.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> > index 31695a078485..646d16450066 100644
> > --- a/drivers/misc/ocxl/link.c
> > +++ b/drivers/misc/ocxl/link.c
> > @@ -566,7 +566,7 @@ int ocxl_link_update_pe(void *link_handle, int
> > pasid, __u16 tid)
> >  
> >  	mutex_lock(&spa->spa_lock);
> >  
> > -	pe->tid = tid;
> > +	pe->tid = cpu_to_be32(tid);
> >  
> >  	/*
> >  	 * The barrier makes sure the PE is updated
> >   
> 
> Good catch, thanks.
> 
> Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
> 

Friendly ping before Xmas break :)
