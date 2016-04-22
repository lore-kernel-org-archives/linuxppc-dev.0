Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrv0k4y49zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 21:44:21 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id e201so3568128wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:44:20 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
 Tejun Heo <tj@kernel.org>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH v1 08/23] ata: sata_dwc_460ex: don't call
 ata_sff_qc_issue() on DMA commands
Date: Fri, 22 Apr 2016 13:44:15 +0200
Message-ID: <1873082.m6E4AZmIX5@debian64>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4A7ECF@AcuExch.aculab.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461262544-115408-9-git-send-email-andriy.shevchenko@linux.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4A7ECF@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, April 22, 2016 11:32:00 AM David Laight wrote:
> From: Andy Shevchenko
> > Sent: 21 April 2016 19:15
> > ata_sff_qc_issue() can't handle DMA commands and thus we have to avoid it for
> > them. Do call ata_bmdma_qc_issue() instead for this case.
> > 
> > Suggested-by: Christian Lamparter <chunkeey@googlemail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/ata/sata_dwc_460ex.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> > index 038e5fb..845c35d 100644
> > --- a/drivers/ata/sata_dwc_460ex.c
> > +++ b/drivers/ata/sata_dwc_460ex.c
> > @@ -1061,10 +1061,12 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
> >  			__func__, tag, qc->ap->link.sactive, sactive);
> > 
> >  		ap->ops->sff_tf_load(ap, &qc->tf);
> > -		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag,
> > +		sata_dwc_exec_command_by_tag(ap, &qc->tf, tag,
> >  					     SATA_DWC_CMD_ISSUED_PEND);
> > +	} else if (ata_is_dma(qc->tf.protocol)) {
> > +		return ata_bmdma_qc_issue(qc);
> >  	} else {
> > -		ata_sff_qc_issue(qc);
> > +		return ata_sff_qc_issue(qc);
> >  	}
> >  	return 0;
> >  }
> 
> I'd nuke those 'else if', they make it very hard to read.
> I Think the code is:
> 
> 		sata_dwc_exec_command_by_tag(...);
> 		return 0;
> 	}
> 
> 	if (ata_is_dma(qc->tf.protocol))
> 		return ata_bmdma_qc_issue(qc);
> 
> 	return ata_sff_qc_issue(qc);
> }

What about something like this instead? ata_bmdma_qc_issue already calls
ata_sff_qc_issue, if it's not a dma transfere anyway [0].
---
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6a61184..67cce54 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1096,12 +1096,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 		ap->ops->sff_tf_load(ap, &qc->tf);
 		sata_dwc_exec_command_by_tag(ap, &qc->tf, tag,
 					     SATA_DWC_CMD_ISSUED_PEND);
-	} else if (ata_is_dma(qc->tf.protocol)) {
+		return 0;
+	} else
 		return ata_bmdma_qc_issue(qc);
-	} else {
-		return ata_sff_qc_issue(qc);
-	}
-	return 0;
 }
 
 static void sata_dwc_error_handler(struct ata_port *ap)
---

[0] <http://lxr.free-electrons.com/source/drivers/ata/libata-sff.c#L2787>
