Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A2EC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:08:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B729F2082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 09:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B729F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DYyv48QRzDqh3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 20:08:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.109.80; helo=2.mo177.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 532 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Dec 2018 20:06:53 AEDT
Received: from 2.mo177.mail-out.ovh.net (2.mo177.mail-out.ovh.net
 [178.33.109.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DYwY4QPWzDqkZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 20:06:51 +1100 (AEDT)
Received: from player763.ha.ovh.net (unknown [10.109.159.132])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id A9B0ED5195
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 09:57:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id 72851B472EC;
 Tue, 11 Dec 2018 08:57:50 +0000 (UTC)
Date: Tue, 11 Dec 2018 09:57:49 +0100
From: Greg Kurz <groug@kaod.org>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] ocxl: Simplify free_spa()
Message-ID: <20181211095749.63804184@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <43523da5-ca96-1a69-73a7-ab90306e9a98@au1.ibm.com>
References: <154445490330.866942.2430705998072942471.stgit@bahia.lan>
 <43523da5-ca96-1a69-73a7-ab90306e9a98@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8941052637910440388
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrudegiedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On Tue, 11 Dec 2018 12:05:49 +1100
Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:

> On 11/12/18 2:15 am, Greg Kurz wrote:
> > The only users of free_spa() are alloc_link() and free_link(), and
> > in both cases:
> > 
> > - link->spa != NULL
> > 
> > - free_spa(link) is immediatly followed by kfree(link)
> > 
> > The check isn't needed, and it doesn't bring much to clear the link->spa
> > pointer. Drop both.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>  
> 
> I like defensive programming but for this case I don't really care too 
> much either way
> 

I now realize that I should have mentioned the real motivation for this
change. I'm working on refactoring the code so that we can use ocxl in a
KVM guest. The concept of link can be shared by both powernv and pseries
variants but the SPA is definitely a powernv only thingy. The benefit
of this patch is hence to kick 'struct link' out of free_spa() so that
it can be utimately moved to powernv specific code.

The initial version of this change was just moving the link->spa check
and link->spa = NULL to the callers, where it was quite obvious they're
not needed... Should I re-post this as two patches for clarity ?

> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> > ---
> >   drivers/misc/ocxl/link.c |    7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> > index 31695a078485..eed92055184d 100644
> > --- a/drivers/misc/ocxl/link.c
> > +++ b/drivers/misc/ocxl/link.c
> > @@ -352,11 +352,8 @@ static void free_spa(struct link *link)
> >   	pr_debug("Freeing SPA for %x:%x:%x\n", link->domain, link->bus,
> >   		link->dev);
> >   
> > -	if (spa && spa->spa_mem) {
> > -		free_pages((unsigned long) spa->spa_mem, spa->spa_order);
> > -		kfree(spa);
> > -		link->spa = NULL;
> > -	}
> > +	free_pages((unsigned long) spa->spa_mem, spa->spa_order);
> > +	kfree(spa);
> >   }
> >   
> >   static int alloc_link(struct pci_dev *dev, int PE_mask, struct link **out_link)
> >   
> 

