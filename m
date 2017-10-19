Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHt2M36cXzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 02:22:02 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JFLoRo073411
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 11:21:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpv5fjdvx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 11:21:54 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 19 Oct 2017 16:21:38 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9JFLYO014483574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:21:35 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9JFLXiA025125
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 02:21:33 +1100
Subject: Re: [PATCH] powerpc/xmon: check before calling xive functions
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Ellerman
 <mpe@ellerman.id.au>,
 Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 17:21:24 +0200
In-Reply-To: <OF2FDAF97B.BDA3E74C-ON002581BE.004846E4@notes.na.collabserv.com>
References: <1508264418-13448-1-git-send-email-leitao@debian.org>
 <87vajchamw.fsf@concordia.ellerman.id.au>
 <1508397046.25065.313.camel@au1.ibm.com>
 <OF2FDAF97B.BDA3E74C-ON002581BE.004846E4@notes.na.collabserv.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508426484.25065.316.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-19 at 15:09 +0200, Cédric Le Goater wrote:
> > No that's wrong. xive_enabled() is only set if Linux is using native
> > xive mode but some of those xmon functions dump the emulated state.
> > 
> > We should fix the actual cause of the crash.
> 
> which should be in the OPAL XIVE dump routines then ? 

Yup, probably needs a NULL check or something...

Cheers,
Ben.
