Return-Path: <vanfleet@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sr9Pz1dnjzDrPL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 00:30:46 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u97DTKlQ056916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Oct 2016 09:30:43 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25xcft8eg5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Oct 2016 09:30:42 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vanfleet@us.ibm.com>;
 Fri, 7 Oct 2016 09:30:42 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id ADF0F6E804B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 09:30:13 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u97DUWZf13894094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Oct 2016 13:30:36 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90B9D28046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 09:30:36 -0400 (EDT)
Received: from d50lp33.co.us.ibm.com (unknown [9.17.249.38])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS id 5583F28041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 09:30:36 -0400 (EDT)
Received: from localhost
 by d50lp33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vanfleet@us.ibm.com>;
 Fri, 7 Oct 2016 07:30:35 -0600
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <vanfleet@us.ibm.com>;
 Fri, 7 Oct 2016 13:30:33 -0000
To: linuxppc-dev@lists.ozlabs.org
Subject: 
From: "Jim Van Fleet" <vanfleet@us.ibm.com>
Date: Fri, 7 Oct 2016 08:30:22 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_alternative 004A20F186258045_="
Message-Id: <OFC859DBD0.98D6D0D2-ON86258045.00499E36-86258045.004A31B8@notes.na.collabserv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=_alternative 004A20F186258045_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"

We have seen on a number of benchmarks that the scheduler does not operate =

like you (I) would expect. One of the tools we have examined a trace file=20
and showed that, for a "long" period of time, two processes were sharing a =

single cpu.  That, in itself, is not startling, but there were a number of =

idle processors when this was happening.

I found the article below searching for others who saw the same sort of=20
problem. What made me keep reading was:
"With so many rules about when the load balancing does or does not occur,=20
it becomes difficult to reason about how long an idle core would remain=20
idle if there is work to do and how long a task might stay in a run queue=20
waiting for its turn to run when there are idle cores in the system."=20
Exactly the issue we were experiencing!

The authors were kind enough to provide patches in their article -- we=20
built a kernel including the patches.  We have not had much time to test=20
it, but we have seen a 30% gain on one benchmark..

The assistance I would like is to have an experienced scheduler person=20
look at these changes to see how we can apply them to power.  We have=20
smt8, but need to have all the threads working for smt8 to make a=20
difference -- this fix addresses that problem and gives us an advantage.

Jim Van Fleet


https://blog.acolyer.org/2016/04/26/the-linux-scheduler-a-decade-of-wasted-=
cores/



--=_alternative 004A20F186258045_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="US-ASCII"

<font size=3D2 face=3D"sans-serif">We have seen on a number of benchmarks
that the scheduler does not operate like you (I) would expect. One of the
tools we have examined a trace file and showed that, for a &quot;long&quot;
period of time, two processes were sharing a single cpu. &nbsp;That, in
itself, is not startling, but there were a number of idle processors when
this was happening.</font><br><br><font size=3D2 face=3D"sans-serif">I foun=
d the article below searching
for others who saw the same sort of problem. What made me keep reading
was:</font><br><font size=3D2 face=3D"sans-serif">&quot;</font><font size=
=3D3>With so many
rules about when the load balancing does or does not occur, it becomes
difficult to reason about how long an idle core would remain idle if there
is work to do and how long a task might stay in a run queue waiting for
its turn to run when there are idle cores in the system.&quot; &nbsp; Exact=
ly
the issue we were experiencing!</font><br><br><font size=3D3>The authors we=
re kind enough to provide patches in their
article -- we built a kernel including the patches. &nbsp;We have not had
much time to test it, but we have seen a 30% gain on one benchmark..</font>=
<br><br><font size=3D3>The assistance I would like is to have an experienced
scheduler person look at these changes to see how we can apply them to
power. &nbsp;We have smt8, but need to have all the threads working for
smt8 to make a difference -- this fix addresses that problem and gives
us an advantage.</font><br><br><font size=3D3>Jim Van Fleet</font><br><br><=
table width=3D513 style=3D"border-collapse:collapse;"><tr valign=3Dtop heig=
ht=3D8><td width=3D511 bgcolor=3D#fafafa style=3D"border-style:none none no=
ne none;border-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px;"=
><a href=3D"https://blog.acolyer.org/2016/04/26/the-linux-scheduler-a-decad=
e-of-wasted-cores/"><font size=3D2 color=3Dblue face=3D"Arial"><b><u>https:=
//blog.acolyer.org/2016/04/26/the-linux-scheduler-a-decade-of-wasted-cores/=
</u></b></font></a></table><br><BR>
--=_alternative 004A20F186258045_=--
