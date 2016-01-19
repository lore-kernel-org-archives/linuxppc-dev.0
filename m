Return-Path: <gromero@br.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4827F1A0E76
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 08:17:01 +1100 (AEDT)
Received: from pps.filterd (m0079652.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
 u0JL8fng016210
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 16:11:04 -0500
Message-Id: <201601192111.u0JL8fng016210@mx0a-001b2d01.pphosted.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 20fjdsd03n-1
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 16:11:04 -0500
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@br.ibm.com>;
 Tue, 19 Jan 2016 19:11:01 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 457B3352005F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 16:10:52 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0JLBZ4U4554754
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 19:11:36 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0JLAv93014152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 19:10:57 -0200
Received: from d50lp01.ny.us.ibm.com (d50lp01.pok.ibm.com [146.89.104.207])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u0JLAuP2014103
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 19:10:57 -0200
Received: from /spool/local
 by d50lp01.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@br.ibm.com>;
 Tue, 19 Jan 2016 16:10:56 -0500
Received: from /spool/local
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@br.ibm.com>;
 Tue, 19 Jan 2016 21:10:52 -0000
In-Reply-To: <569EA155.5070602@br.ibm.com>
Subject: Re: Different SIGSEGV codes (x86 and ppc64le)
To: Breno Leitao <brenohl@br.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Gustavo Bueno Romero" <gromero@br.ibm.com>
Date: Tue, 19 Jan 2016 18:10:47 -0300
References: <569EA155.5070602@br.ibm.com>
Content-type: multipart/alternative;
 Boundary="0__=8FBBF5ACDFE0DE5C8f9e8a93df938690918c8FBBF5ACDFE0DE5C"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0__=8FBBF5ACDFE0DE5C8f9e8a93df938690918c8FBBF5ACDFE0DE5C
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII

Breno,

Just to complement what you said, the si->si=5Fcode value you get on Power
with the code you provided (SEGV=5FACCERR 2) comes
from .../arch/powerpc/mm/fault.c, line 375: https://goo.gl/6K40Bv

Hence, changing that line to 'code =3D SEGV=5FMAPERR;' makes your code die =
with
SIGSEGV Code ID 1, not 2:

:~/stack$ uname -a
Linux gromero12 4.4.0 #3 SMP Tue Jan 19 15:46:14 EST 2016 ppc64le ppc64le
ppc64le GNU/Linux
:~/stack$ ./overflow
Got SIGSEGV(1) at address: 0x3fffcecefff0
Segmentation fault


Regards,
--
Gustavo Romero

--0__=8FBBF5ACDFE0DE5C8f9e8a93df938690918c8FBBF5ACDFE0DE5C
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p>Breno,<br><br>Just to complement what you said, the si-&gt;s=
i=5Fcode value you get on Power with the code you provided (SEGV=5FACCERR 2=
) comes from .../arch/powerpc/mm/fault.c, line 375: <a href=3D"https://goo.=
gl/6K40Bv">https://goo.gl/6K40Bv</a><br><br>Hence, changing that line to 'c=
ode =3D SEGV=5FMAPERR;' makes your code die with SIGSEGV Code ID 1, not 2:<=
br><br>:~/stack$ uname -a<br>Linux gromero12 4.4.0 #3 SMP Tue Jan 19 15:46:=
14 EST 2016 ppc64le ppc64le ppc64le GNU/Linux<br>:~/stack$ ./overflow <br>G=
ot SIGSEGV(1) at address: 0x3fffcecefff0<br>Segmentation fault <br><br><br>=
Regards,<br>--<br>Gustavo Romero<BR>
</body></html>

--0__=8FBBF5ACDFE0DE5C8f9e8a93df938690918c8FBBF5ACDFE0DE5C--
