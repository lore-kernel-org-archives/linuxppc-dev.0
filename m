Return-Path: <maier@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ8w93QWLzDvjJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 01:31:36 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFEOAL4049284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 09:31:33 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26r1cjgyw6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 09:31:33 -0500
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maier@linux.vnet.ibm.com>;
 Tue, 15 Nov 2016 14:31:31 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 77CDC1B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 14:33:45 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAFEVUJb33161308
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 14:31:30 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAFEVSr5028336
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 07:31:29 -0700
Subject: Re: [PATCH v3 02/16] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
To: Johannes Thumshirn <jthumshirn@suse.de>
References: <cover.1476369687.git.jthumshirn@suse.de>
 <bbc682928173d64848ab0cbff689b1ad3d715fb7.1476369687.git.jthumshirn@suse.de>
 <ebc46cfa-0bee-aa71-ba0b-d7c86628df0c@linux.vnet.ibm.com>
 <20161014073821.qvkpjtwraqnwzzs3@linux-x5ow.site>
 <20161025074313.4ma4czgdj46imaei@linux-x5ow.site>
 <20161115115622.j4ker3atejcodqrc@linux-x5ow.site>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
 Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Johannes Thumshirn <jth@kernel.org>, James Smart
 <james.smart@avagotech.com>, Dick Kennedy <dick.kennedy@avagotech.com>,
 "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" <qla2xxx-upstream@qlogic.com>,
 "open list:S390 ZFCP DRIVER" <linux-s390@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe)" <fcoe-devel@open-fcoe.org>
From: Steffen Maier <maier@linux.vnet.ibm.com>
Date: Tue, 15 Nov 2016 15:31:27 +0100
MIME-Version: 1.0
In-Reply-To: <20161115115622.j4ker3atejcodqrc@linux-x5ow.site>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8647eacd-a029-dff0-4f78-dafef89a5ad9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Johannes,

On 11/15/2016 12:56 PM, Johannes Thumshirn wrote:
> On Tue, Oct 25, 2016 at 09:43:14AM +0200, Johannes Thumshirn wrote:
>> On Fri, Oct 14, 2016 at 09:38:21AM +0200, Johannes Thumshirn wrote:
>>> On Thu, Oct 13, 2016 at 05:55:11PM +0200, Steffen Maier wrote:
>>>> Hm, still behaves for me like I reported for v2:
>>>> http://marc.info/?l=3Dlinux-scsi&m=3D147637177902937&w=3D2
>
> [...]
>
>>>
>>> The rational behind this is, in fc_req_to_bsgjob() we're assigning
>>> job->request as req->cmd and job->request_len =3D req->cmd_len. But w=
ithout
>>> checkinf job->request_len we don't know whether we're save to touch
>>> job->request (a.k.a. bsg_request).
>>
>> Hi Steffen,
>> Did you have any chance testing this? I hacked fcping to work with non=
-FCoE
>> and rports as well and tested with FCoE and lpfc. No problems seen fro=
m my
>> side. I've also pused the series (With this change folded in) to my gi=
t
>> tree at [1] if this helps you in any way.
>>
>> [1] https://git.kernel.org/cgit/linux/kernel/git/jth/linux.git/log/?h=3D=
scsi-bsg-rewrite-v4
>>
>
> So I finally have a test system up and running. I have good and bad new=
s. The
> good news is, I can't get the system crashing with my patches, the bad =
news is
> I can't get zfcp_ping and zfcp_show to output something but HBA_STATUS_=
ERROR
> with my patches and without.

Assuming you run the latest package version on s390x:

Do steps 2 and 3 of the procedure in
http://www.ibm.com/support/knowledgecenter/linuxonibm/com.ibm.linux.z.lhd=
d/lhdd_t_fcp_api_runappl.html
help?

The only other thing I can think of from the top of my head is that BSG=20
ioctls are sensitive regarding ABI and I once had the kernel ioctl=20
return EINVAL due to unmatching kernel-headers and libzfcphbaapi maps=20
this EINVAL to HBA_STATUS_ERROR because there is no more specifically=20
suitable HBA constant [old SUSE bugs 834498 and 834500].

> And btw, I renamed the branch to fc-bsg-rewrite-v4 in case you want to =
clone
> from it (it has patch 2/16 changed to the v3 submission).
>
> Can you please have a look with your setup?

I'm going to re-test hopefully within the next few days.

--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
