Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AFFF42C02B8
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:42:34 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 12 Jul 2013 01:38:13 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3C874357804E
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:42:29 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6B4RK0H721268
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:27:21 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6B4gSSW020471
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jul 2013 14:42:28 +1000
Message-ID: <1373517747.19894.54.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix the corrupt r3 error during MCE handling.
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 11 Jul 2013 14:42:27 +1000
In-Reply-To: <51DE35D5.5070005@linux.vnet.ibm.com>
References: <20130710130155.4993.61577.stgit@mars>
 <8761wild20.fsf@linux.vnet.ibm.com> <51DE35D5.5070005@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-07-11 at 10:04 +0530, Mahesh Jagannath Salgaonkar wrote:
> > I always got that error and used to wonder why I find FWNMI
> > corrupt. IS this a rtas bug or is it documented in papr ?
> 
> Nope. There is no mention of it in PAPR. It looks like a bug in RTAS.

Typically, the top bit in real mode means to ignore the HRMOR... I think
it's some old bug in RTAS indeed.

Cheers,
Ben.
