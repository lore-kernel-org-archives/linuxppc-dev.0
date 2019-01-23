Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D14C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 10:33:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D8C20861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="My8Ib7ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D8C20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l1pk43b6zDqLr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 21:33:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43l1kv3HVczDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 21:30:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="My8Ib7ND"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43l1kt5hZqz9s9h; Wed, 23 Jan 2019 21:30:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548239414; bh=adIa6hXcHC3mrI5YqMsudP1dpdMw6Rv9xn2IZjDYs9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=My8Ib7ND5JYsbzlYjd09shw47hmubhQtH6R02iqcC/ciCEhh931Pvm7UCF+kMllf+
 hk253fsF1d1KNp9sduRmUVc65B8uzECSVCtLViY9NYIE/0/L2eXjexshOCVycCFn6F
 DIQdpmLjJDYHh9iSvLHgouyh106dBORZexm9/VLisPerN6bEkVWp+BUrYTMQ9sU8E+
 fpaXrHTJuKsR5Ey0+77UmNxcccpeEyNMLEskZlopZGbhReSSJ1nUF5j1CT0Mo3xpJJ
 NSgxdBVxQqNCi+sjkDfvGRKtrWcKak6cehujCtAPJZerwv4T8k/PA/i72WnwytRrRa
 ozlXDrUMSRQLw==
Date: Wed, 23 Jan 2019 21:26:03 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 11/19] KVM: PPC: Book3S HV: add support for the XIVE
 native exploitation mode hcalls
Message-ID: <20190123102603.GA29826@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-12-clg@kaod.org>
 <20190122052346.GF15124@blackberry>
 <de777e750665d92509b1487a90acb79d70854cf3.camel@kernel.crashing.org>
 <3ada7c25-c671-32d2-4c91-dd7e84c29e48@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ada7c25-c671-32d2-4c91-dd7e84c29e48@kaod.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 23, 2019 at 09:48:31AM +0100, Cédric Le Goater wrote:
> On 1/23/19 7:44 AM, Benjamin Herrenschmidt wrote:
> > On Tue, 2019-01-22 at 16:23 +1100, Paul Mackerras wrote:
> >> Why do we need to provide real-mode versions of these hypercall
> >> handlers?  I thought these hypercalls would only get called
> >> infrequently, and in any case certainly much less frequently than once
> >> per interrupt delivered.  If they are infrequent, then let's leave out
> >> the real-mode version and just handle them in book3s_hv.c.
> > 
> > Agreed with the exception maybe of H_INT_ESB
> 
> ok. 
> 
> Some of these hcalls are really simple and only getting local info from 
> the host (h_int_get_*). I thought handling the hcall ASAP was a preferred 
> practice, even if the hcall is not called frequently. Isn't it ?

If we are going to handle a given hcall in the kernel at all, then we
have to have a virtual mode handler.  If we have a real-mode handler
as well then we in general incur a certain amount of code duplication
with consequent maintenance costs and possibility of bugs.  So we
generally only have real-mode handlers for the hcalls where it is
critical to minimize the latency.  From what Ben is saying that would
only be H_INT_ESB, and maybe not even that.

If H_INT_ESB is only used for LSIs, then is a guest going to be using
it at all?  My understanding was that with XIVE, only a small number
of interrupts that are to do with system management functions are
LSIs; all of the interrupts relating to PCI-e devices are MSIs.  So do
we actually have a real high-frequency use case for LSIs in a guest?

For now I would prefer that you remove all the real-mode hcall
handlers.  We can add them later if we get performance data showing
that they are needed.

Regarding whether or not to have a given hcall handler in the kernel
at all - if there is for example an hcall which is just called once
on guest startup, and its function is just to provide information to
the guest, and QEMU has that information, then why not have that hcall
implemented by QEMU?  Are any of the hcalls like that?

For example, if H_INT_GET_SOURCE_INFO was implemented in QEMU, could
we then remove the VC_BASE thing from the xive device?

Paul.
