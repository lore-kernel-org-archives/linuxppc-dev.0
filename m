Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bRhz6G0SzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 06:31:47 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PKNqmj090812
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 16:31:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2keyxegw09-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 16:31:44 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 25 Jul 2018 16:31:43 -0400
Date: Wed, 25 Jul 2018 17:31:35 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Cyril Bur <cyrilbur@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Balbir Singh <bsingharora@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@d-silva.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] powerpc/traps: Return early in show_signal_msg()
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-3-muriloo@linux.ibm.com>
 <20180725174228.Horde.-PsCOyKHj9skAHIMbqyLDg1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180725174228.Horde.-PsCOyKHj9skAHIMbqyLDg1@messagerie.si.c-s.fr>
Message-Id: <20180725203135.GD23643@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Wed, Jul 25, 2018 at 05:42:28PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> 
> > Modify logic of show_signal_msg() to return early, if possible.  Replace
> > printk_ratelimited() by printk() and a default rate limit burst to limit
> > displaying unhandled signals messages.
> 
> Can you explain more the benefits of this change ?

Mainly is to improve readability of the function.

The conditions to display the message were coupled together in one
single `if` statement.

Besides that, patch 5/7 adds a call to print_vma_addr(), which is not
aware of any rate limit - it simply calls printk().

So splitting out the rate limit check outside show_signal_msg() makes it
easier to the caller decide if it wants to respect a printk rate limit
or not.

Cheers
Murilo
