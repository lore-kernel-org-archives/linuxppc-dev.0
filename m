Return-Path: <harshal.patil@in.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjB5j2Q63zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 21:38:01 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2EASkhg047595
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 06:37:57 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 295xm3u7pj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 06:37:57 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <harshal.patil@in.ibm.com>;
 Tue, 14 Mar 2017 16:07:54 +0530
Received: from d50lp02.ny.us.ibm.com (d50lp02.pok.ibm.com [146.89.104.208])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2EAboCG18088076
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 16:07:51 +0530
Received: from localhost
 by d50lp02.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <harshal.patil@in.ibm.com>;
 Tue, 14 Mar 2017 06:37:50 -0400
Received: from localhost
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <harshal.patil@in.ibm.com>;
 Tue, 14 Mar 2017 10:37:47 -0000
In-Reply-To: 
Subject: ioctl structs differ from x86_64?
From: "Harshal Patil" <harshal.patil@in.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Sudipto Ghosh" <sudiptoghosh@in.ibm.com>
Date: Tue, 14 Mar 2017 10:37:44 +0000
References: 
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Message-Id: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@notes.na.collabserv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial, H=
elvetica, sans-serif;font-size:10.5pt" ><div class=3D"socmaildefaultfont" d=
ir=3D"ltr" style=3D"font-family:Arial, Helvetica, sans-serif;font-size:10.5=
pt" ><div dir=3D"ltr" >Hello,</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >I am looking into a bug,&nbsp;<a href=3D"https://bugzilla=
.linux.ibm.com/show=5Fbug.cgi?id=3D152493" >https://bugzilla.linux.ibm.com/=
show=5Fbug.cgi?id=3D152493</a>&nbsp;( external mirror is at,&nbsp;<a href=
=3D"https://github.com/opencontainers/runc/issues/1364" >https://github.com=
/opencontainers/runc/issues/1364</a>)&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Recently in runc&nbsp;code, they added this code&nbsp;<a =
href=3D"https://github.com/opencontainers/runc/commit/eea28f480db435dbef4a2=
75de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR155" >https://git=
hub.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c=
#diff-5f5c07d0cab3ce2086437d3d43c0d25fR155</a>. As you can see they set -on=
lcr&nbsp;to get rid of \r (line no. 164). Golang,&nbsp;in which runc is wri=
tten, doesn't have any bindings for ioctls. &nbsp;This means you have to in=
voke C code directly (that's what they are doing there).</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Our guess is the ioctls in ppc64le differ than x86=5F64, =
and thats why the code which is clearing onclr bit (<a href=3D"https://gith=
ub.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#=
diff-5f5c07d0cab3ce2086437d3d43c0d25fR164" >https://github.com/opencontaine=
rs/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#diff-5f5c07d0cab3ce=
2086437d3d43c0d25fR164</a>) is failing on ppc64le but works fine on x86=5F6=
4.&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Any pointers on the possible solution would be really hel=
pful.&nbsp;</div>
<div dir=3D"ltr" >&nbsp;</div>
<div dir=3D"ltr" >Thanks,</div>
<div dir=3D"ltr" ><div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"fo=
nt-family:Arial;font-size:10.5pt" ><div class=3D"socmaildefaultfont" dir=3D=
"ltr" style=3D"font-family:Arial;font-size:10.5pt" ><div dir=3D"ltr" style=
=3D"margin-top: 20px;" ><div style=3D"font-size: 12pt; font-weight: bold; f=
ont-family: sans-serif; color: #7C7C5F;" >Harshal&nbsp;Patil</div>
<div style=3D"font-size: 8pt; font-family: sans-serif; margin-top: 10px;" >=
<div><span style=3D"font-weight: bold; color: #336699;" >E-mail: </span><a =
href=3D"mailto:harshal.patil@in.ibm.com" style=3D"color: #555" >harshal.pat=
il@in.ibm.com</a></div></div></div></div></div></div></div></div><BR>
