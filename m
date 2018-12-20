Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B94C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 15:12:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0803521852
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 15:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0803521852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LFcf4MPHzDqyZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 02:12:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.63.100; helo=6.mo68.mail-out.ovh.net;
 envelope-from=groug@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo68.mail-out.ovh.net (6.mo68.mail-out.ovh.net
 [46.105.63.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LFZ30znGzDqw4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 02:10:34 +1100 (AEDT)
Received: from player734.ha.ovh.net (unknown [10.109.146.5])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8D33810A7FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 15:53:11 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id EBD6BFDC8DA;
 Thu, 20 Dec 2018 14:53:04 +0000 (UTC)
Date: Thu, 20 Dec 2018 15:53:04 +0100
From: Greg Kurz <groug@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] ocxl: Fix endiannes bug in read_afu_name()
Message-ID: <20181220155304.7ac65e6f@bahia.lan>
In-Reply-To: <6119504a-1400-3ccf-0a90-310025081708@au1.ibm.com>
References: <154455110114.974105.12136076223072629095.stgit@bahia.lan>
 <6119504a-1400-3ccf-0a90-310025081708@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12454423294890908081
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

On Wed, 12 Dec 2018 13:26:10 +1100
Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:

> On 12/12/18 4:58 am, Greg Kurz wrote:
> > The AFU Descriptor Template in the PCI config space has a Name Space
> > field which is a 24 Byte ASCII character string of descriptive name
> > space for the AFU. The OCXL driver read the string four characters at
> > a time with pci_read_config_dword().
> > 
> > This optimization is valid on a little-endian system since this is PCI,
> > but a big-endian system ends up with each subset of four characters in
> > reverse order.
> > 
> > This could be fixed by switching to read characters one by one. Another
> > option is to swap the bytes if we're big-endian.
> > 
> > Go for the latter with le32_to_cpu().
> > 
> > Cc: stable@vger.kernel.org      # v4.16
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>  
> 
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 

Friendly ping before Xmas break :)

> > ---
> > v2: - silence sparse with (__force __le32) cast
> >      - new changelog
> > ---
> >   drivers/misc/ocxl/config.c |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> > index 57a6bb1fd3c9..8f2c5d8bd2ee 100644
> > --- a/drivers/misc/ocxl/config.c
> > +++ b/drivers/misc/ocxl/config.c
> > @@ -318,7 +318,7 @@ static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
> >   		if (rc)
> >   			return rc;
> >   		ptr = (u32 *) &afu->name[i];
> > -		*ptr = val;
> > +		*ptr = le32_to_cpu((__force __le32) val);
> >   	}
> >   	afu->name[OCXL_AFU_NAME_SZ - 1] = '\0'; /* play safe */
> >   	return 0;
> >   
> 

