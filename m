Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3CC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 08:44:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02A62081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 08:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02A62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DYQ81jwJzDqvV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 19:44:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.118; helo=19.mo7.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 19.mo7.mail-out.ovh.net (19.mo7.mail-out.ovh.net
 [178.33.251.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DYMY3VLrzDqfY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 19:41:45 +1100 (AEDT)
Received: from player773.ha.ovh.net (unknown [10.109.146.173])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 388BAEF79C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:36:28 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id 6D71EB2AA20;
 Tue, 11 Dec 2018 08:36:21 +0000 (UTC)
Date: Tue, 11 Dec 2018 09:33:01 +0100
From: Greg Kurz <groug@kaod.org>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] ocxl: Fix endiannes bug in read_afu_name()
Message-ID: <20181211093301.297a9ec4@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <d1b81705-c5b3-80d8-4e4e-8717b530f179@au1.ibm.com>
References: <154445465027.866316.3631489273007908874.stgit@bahia.lan>
 <761f925d-4dcb-8522-8a5e-b730cd2c58ad@au1.ibm.com>
 <d1b81705-c5b3-80d8-4e4e-8717b530f179@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8577949916552075716
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudegiedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 11 Dec 2018 11:24:08 +1100
Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:

> On 11/12/18 11:05 am, Andrew Donnellan wrote:
> > On 11/12/18 2:10 am, Greg Kurz wrote:  
> >> The double word returned by read_afu_info(OCXL_DVSEC_TEMPL_NAME) contains
> >> four characters of the AFU name, read from the PCI config space, hence
> >> with a little-endian ordering. When composing the string, a big-endian
> >> system must swap the bytes so that the characters appear in the right
> >> order.
> >>
> >> Do this with le32_to_cpu().
> >>
> >> Signed-off-by: Greg Kurz <groug@kaod.org>  
> > 
> > snowpatch reports the following sparse warning:
> > 
> > +drivers/misc/ocxl/config.c:321:24: warning: cast to restricted __le32
> > 
> > You probably need to change val from a u32 to a __le32.  
> 

You might be right, I'll look into this.

> Also does this need to go to stable?
> 

Oops... this bug has been there since the beginning, so yes
it does. I simply forgot to add the Cc: stable tag... :-\

Cheers,

--
Greg
