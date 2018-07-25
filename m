Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bQZh3TPKzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 05:41:16 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PJdJUc049507
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 15:41:14 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kexfvak31-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 15:41:13 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 25 Jul 2018 15:41:13 -0400
Date: Wed, 25 Jul 2018 16:41:05 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
 "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH 6/7] powerpc/traps: Print signal name for unhandled signals
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-7-muriloo@linux.ibm.com>
 <0364bdc4-ddf9-85de-1128-8fc8791d63dd@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0364bdc4-ddf9-85de-1128-8fc8791d63dd@linux.vnet.ibm.com>
Message-Id: <20180725194105.GB23643@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Gustavo.

On Wed, Jul 25, 2018 at 12:19:00PM -0300, Gustavo Romero wrote:
> Hi Murilo,
> 
> LGTM.
> 
> Just a comment:
> 
> On 07/24/2018 04:27 PM, Murilo Opsfelder Araujo wrote:
> > This adds a human-readable name in the unhandled signal message.
> > 
> > Before this patch, a page fault looked like:
> > 
> >      Jul 11 16:04:11 localhost kernel: pandafault[6303]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00007fff93c55100 code 2 in pandafault[10000000+10000]
> > 
> > After this patch, a page fault looks like:
> > 
> >      Jul 11 18:14:48 localhost kernel: pandafault[6352]: segfault (11) at 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100 code 2 in pandafault[13a2a0000+10000]
> 
> I _really_ don't want to bikeshed here, but I vouch for keeping the
> "unhandled" word before the signal name, like:
> 
> [...] pandafault[6352]: unhandled segfault (11) at 000000013a2a09f8 nip [...]
> 
> because the issue reported here is really that we got a segfault _and_
> there was no handler to catch it.

Either way works for me.

> But feel free to wait for additional comments to decide it.

Sure.  I intend to wait a couple of weeks to respin the series based on
community feedback.

Cheers
Murilo
