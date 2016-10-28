Return-Path: <Andreas.Krebbel@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t58P462ZVzDvRT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 03:30:00 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9SGSgZ6080846
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 12:29:58 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26c9b7css1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 12:29:58 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <Andreas.Krebbel@de.ibm.com>;
 Fri, 28 Oct 2016 17:29:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8499917D805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 17:32:08 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9SGTqU628836092
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 16:29:52 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9SGTq1o011265
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 10:29:52 -0600
Received: from d50lp03.ny.us.ibm.com (d50lp03.pok.ibm.com [146.89.104.211])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u9SGTpcj011250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 10:29:52 -0600
Received: from localhost
 by d50lp03.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <Andreas.Krebbel@de.ibm.com>;
 Fri, 28 Oct 2016 12:29:51 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <Andreas.Krebbel@de.ibm.com>;
 Fri, 28 Oct 2016 16:29:45 -0000
In-Reply-To: <132d8dc4-e8d0-6eba-9ae2-4a7e2c9a589b@linux.vnet.ibm.com>
To: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Dick Kennedy <dick.kennedy@avagotech.com>,
 "open list:FCOE SUBSYSTEM (libfc, libfcoe, fcoe)"
 <fcoe-devel@open-fcoe.org>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>,
 heicars2@linux.vnet.ibm.com, James Smart <james.smart@avagotech.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 Johannes Thumshirn <jth@kernel.org>, Johannes
 Thumshirn <jthumshirn@suse.de>, Linux Kernel Mailinglist
 <linux-kernel@vger.kernel.org>, "open list:S390 ZFCP DRIVER"
 <linux-s390@vger.kernel.org>, Linux SCSI Mailinglist
 <linux-scsi@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Michael Ellerman
 <mpe@ellerman.id.au>, mschwid2@linux.vnet.ibm.com, Paul Mackerras
 <paulus@samba.org>, "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER"
 <qla2xxx-upstream@qlogic.com>, Richard Biener <rguenther@suse.de>,
 Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, Tyrel Datwyler
 <tyreld@linux.vnet.ibm.com>, "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Subject: Re: [PATCH v2 02/16] scsi: don't use fc_bsg_job::request and
 fc_bsg_job::reply directly
From: "Andreas Krebbel1" <Andreas.Krebbel@de.ibm.com>
Date: Fri, 28 Oct 2016 18:29:38 +0200
References: <cover.1476276823.git.jthumshirn@suse.de>
 <b92d12e4f78c4998bc8ad000359c127e673379f3.1476276823.git.jthumshirn@suse.de>
 <2ea07f3f-88eb-b795-fa37-a223bf80e581@linux.vnet.ibm.com>
 <20161013162405.aoxy3bdkc4bqtwsk@linux-x5ow.site>
 <4b411836-e76f-b67a-3d49-ad3d51b8f216@linux.vnet.ibm.com>
 <d9a73963-1ade-2b6f-77bd-044e19675fd8@suse.de>
 <132d8dc4-e8d0-6eba-9ae2-4a7e2c9a589b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Message-Id: <OF02C91110.A5599383-ONC125805A.00581A77-C125805A.005A9A28@notes.na.collabserv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On 10/28/2016 01:31 PM, Hannes Reinecke wrote:
> > On 10/28/2016 11:53 AM, Steffen Maier wrote:
> >> On 10/13/2016 06:24 PM, Johannes Thumshirn wrote:
> >>> On Thu, Oct 13, 2016 at 05:15:25PM +0200, Steffen Maier wrote:
...
> fc=5Fbsg=5Frequest=5Fhandler()
>                          req->errors =3D -ENXIO;
>=20
> > 0x7c8e6e <fc=5Fbsg=5Frequest=5Fhandler+0x86>: mvhi    260(%r12),-6
>=20
> crash> struct -od request.errors
> struct request {
>    [260] int errors;
> }
>=20
> ********************************************************************
>=20
> BUT this seems the first time %r12 is used in fc=5Fbsg=5Frequest=5Fhandle=
r(),
> especially I seem to miss %r12 being initalized with anything.
> But then again I'm not at all well versed in disassembly.
> Maybe fc=5Fbsg=5Frequest=5Fhandler() is itself in turn inlined and I woul=
d=20
> need to start disassembling even earlier to get to %r12 init?
> s390x ELF ABI says %r12:
> usage: Local variable, commonly used as GOT pointer;
> call effect: saved.
> Even if it wasn't initialized and remained NULL below why did it not=20
> already page fault at above instruction? Silly me, we did not execute=20
> this instruction as it's "if" conditional. This makes me wonder even=20
> more where the content of %r12 comes from.
>=20
> Ulli, Andreas, could you please shed some light on this?
>=20
> ********************************************************************

r12 holds variable req for that access. It is initialized here:

  req =3D blk=5Ffetch=5Frequest(q);   =20
  if (!req)  =20
    break;

The asm code ends up down below in the function and loads the return value =

into r12. The code
invoking blk=5Ffetch=5Frequest got duplicated and there are three jumps bef=
ore=20
the r12 access to these
locations.

  7c8e48:       ec a8 02 14 00 7c       cgije   %r10,0,7c9270=20
<fc=5Fbsg=5Frequest=5Fhandler+0x488>  <--- x
  7c8e4e:       d5 03 d0 04 a0 28       clc     4(4,%r13),40(%r10)
  7c8e54:       a7 74 02 02             jne     7c9258=20
<fc=5Fbsg=5Frequest=5Fhandler+0x470>         <--- y
  7c8e58:       91 04 a0 48             tm      72(%r10),4
  7c8e5c:       a7 74 01 fe             jne     7c9258=20
<fc=5Fbsg=5Frequest=5Fhandler+0x470>         <--- y
  7c8e60:       a7 f4 01 d5             j       7c920a=20
<fc=5Fbsg=5Frequest=5Fhandler+0x422>
  7c8e64:       d5 03 d0 00 a0 28       clc     0(4,%r13),40(%r10)
  7c8e6a:       a7 84 00 1a             je      7c8e9e=20
<fc=5Fbsg=5Frequest=5Fhandler+0xb6>
  7c8e6e:       e5 4c c1 04 ff fa       mvhi    260(%r12),-6
...

  7c9258:       b9 04 00 29             lgr     %r2,%r9
  7c925c:       c0 e5 ff f7 b3 a6       brasl   %r14,6bf9a8=20
<blk=5Ffetch=5Frequest>
  7c9262:       b9 04 00 c2             lgr     %r12,%r2
  7c9266:       ec 26 fd ff 00 7c       cgijne  %r2,0,7c8e64=20
<fc=5Fbsg=5Frequest=5Fhandler+0x7c>
  7c926c:       a7 f4 ff cf             j       7c920a=20
<fc=5Fbsg=5Frequest=5Fhandler+0x422>

  7c9270:       b9 04 00 29             lgr     %r2,%r9
  7c9274:       c0 e5 ff f7 b3 9a       brasl   %r14,6bf9a8=20
<blk=5Ffetch=5Frequest>
  7c927a:       b9 04 00 c2             lgr     %r12,%r2
  7c927e:       ec 26 fe 10 00 7c       cgijne  %r2,0,7c8e9e=20
<fc=5Fbsg=5Frequest=5Fhandler+0xb6>

-Andreas-
