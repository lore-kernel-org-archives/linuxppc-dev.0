Return-Path: <zhong@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYXG713jpzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:47:58 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L2j1A1052732
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:47:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2ek8v05-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 22:47:56 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:47:56 -0400
Subject: Re: [RFC PATCH 1/2] KVM: PPC: divide the ics lock into smaller ones
 for each irq
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/html; charset=utf-8
From: Li Zhong <zhong@linux.vnet.ibm.com>
In-Reply-To: <20160620052513.GB29366@fergus.ozlabs.ibm.com>
Date: Tue, 21 Jun 2016 10:47:44 +0800
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>, agraf@suse.com,
 kvm-ppc@vger.kernel.org
References: <1463381898.19947.6.camel@TP420>
 <20160620052513.GB29366@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Message-Id: <F10BD825-3AD8-4B9F-A5CD-1655C26875D6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><head></head><body dir=3D"auto" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><br><blockquote type=3D"cite">On Jun 20, 2016, at =
13:25, Paul Mackerras &lt;paulus@ozlabs.org&gt; wrote:<br><br>On Mon, =
May 16, 2016 at 02:58:18PM +0800, Li Zhong wrote:<br><blockquote =
type=3D"cite">This patch tries to use smaller locks for each irq in the =
ics, instead<br>of a lock at the ics level, to provide better =
scalability.<br></blockquote><br>This looks like a worth-while thing to =
do. &nbsp;Do you have any<br>performance measurements to justify the =
change? &nbsp;This will increase<br>the size of struct kvmppc_ics by =
4kB, so it would be useful to show<br>the performance increase that =
justifies it.<br></blockquote><br>Actually, I saw some =E2=80=9Cimprovemen=
t=E2=80=9D because of the vcpus were not binded, io jobs and irqs on the =
guest were not binded. After I fixed those random factors, the result =
became stable, but I couldn=E2=80=99t see any obvious improvements from =
the patches... <br><br>Maybe I need find some other test cases that =
could support this change. <br><br><blockquote type=3D"cite"><br>Also, =
when you resend the patch, please make the patch description<br>more =
definite - say "With this patch, we use" rather than "this =
patch<br>tries to use", for instance.<br></blockquote><br>OK, I will =
change that when doing a resend, if I can find some workload that could =
benefit from this change. <br><br>Thanks, Zhong<br><br><blockquote =
type=3D"cite"><br>Regards,<br>Paul.<br>___________________________________=
____________<br>Linuxppc-dev mailing =
list<br>Linuxppc-dev@lists.ozlabs.org<br>https://lists.ozlabs.org/listinfo=
/linuxppc-dev<br></blockquote><br></body></html>=
