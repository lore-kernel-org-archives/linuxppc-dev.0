Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFh4d2VCyzF0Px
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 03:46:41 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w08GhxsI139743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jan 2018 11:46:38 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fcc3e97ys-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 11:46:38 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 09:46:37 -0700
Subject: Re: [PATCH 1/6] cxlflash: Reset command ioasc
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/html; charset=us-ascii
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
In-Reply-To: <20180107193604.GB45065@p8tul1-build.aus.stglabs.ibm.com>
Date: Mon, 8 Jan 2018 10:43:49 -0600
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 James Bottomley <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
References: <1515020002-43551-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1515020042-43590-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <be8c1d08-f78a-a7f0-d912-e638646db80e@au1.ibm.com>
 <20180107193604.GB45065@p8tul1-build.aus.stglabs.ibm.com>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Message-Id: <32405550-D504-416D-96B6-658E9DB2601C@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head></head><body dir=3D"auto" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><div =
class=3D"ApplePlainTextBody"><br><blockquote type=3D"cite">On Jan 7, =
2018, at 1:36 PM, Matthew R. Ochs &lt;mrochs@linux.vnet.ibm.com&gt; =
wrote:<br><br>On Thu, Jan 04, 2018 at 05:33:48PM +1100, Andrew Donnellan =
wrote:<br><blockquote type=3D"cite">On 04/01/18 09:54, Uma Krishnan =
wrote:<br><blockquote type=3D"cite">In the event of a command failure, =
cxlflash returns the failure to the<br>upper layers to process. After =
processing the error, when the command is<br>queued again, the private =
command structure will not be zeroed and the<br>ioasc could be stale. =
Per the SISLite specification, the AFU only sets the<br>ioasc in the =
presence of a failure. Thus, even though the original =
command<br>succeeds the second time, the command is considered a failure =
due to stale<br>ioasc. This cycle repeats indefinitely and can cause a =
hang or IO failure.<br><br>To fix the issue, clear the ioasc before =
queuing any command.<br><br>Fixes: 479ad8e9d48c ("scsi: cxlflash: Remove =
zeroing of private command<br>data")<br>Signed-off-by: Uma Krishnan =
&lt;ukrishn@linux.vnet.ibm.com&gt;<br></blockquote><br>Should this go to =
stable?<br></blockquote><br>Not a bad =
idea.<br><br></blockquote><br><br>I will forward the patch to stable =
once the patch is in next/master. <br>Unless there is a need to send a =
V2. Thanks for pointing out Andrew !!</div></body></html>=
