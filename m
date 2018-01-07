Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF7tl6Hv0zDqs7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 06:36:15 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w07JYJEU144188
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Jan 2018 14:36:12 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fbh5dq16n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jan 2018 14:36:11 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Sun, 7 Jan 2018 14:36:11 -0500
Date: Sun, 7 Jan 2018 13:36:04 -0600
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/6] cxlflash: Reset command ioasc
References: <1515020002-43551-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1515020042-43590-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <be8c1d08-f78a-a7f0-d912-e638646db80e@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <be8c1d08-f78a-a7f0-d912-e638646db80e@au1.ibm.com>
Message-Id: <20180107193604.GB45065@p8tul1-build.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 04, 2018 at 05:33:48PM +1100, Andrew Donnellan wrote:
> On 04/01/18 09:54, Uma Krishnan wrote:
> >In the event of a command failure, cxlflash returns the failure to the
> >upper layers to process. After processing the error, when the command is
> >queued again, the private command structure will not be zeroed and the
> >ioasc could be stale. Per the SISLite specification, the AFU only sets the
> >ioasc in the presence of a failure. Thus, even though the original command
> >succeeds the second time, the command is considered a failure due to stale
> >ioasc. This cycle repeats indefinitely and can cause a hang or IO failure.
> >
> >To fix the issue, clear the ioasc before queuing any command.
> >
> >Fixes: 479ad8e9d48c ("scsi: cxlflash: Remove zeroing of private command
> >data")
> >Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> 
> Should this go to stable?

Not a bad idea.
