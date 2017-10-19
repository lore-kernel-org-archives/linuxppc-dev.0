Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHvw3480mzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 03:46:43 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JGkdJE122248
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:46:41 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpvu3nuak-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:46:41 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 19 Oct 2017 12:46:40 -0400
Date: Thu, 19 Oct 2017 09:46:33 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 18/25] powerpc: check key protection for user page access
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-27-git-send-email-linuxram@us.ibm.com>
 <20171019065732.670b426a@MiWiFi-R3-srv>
 <20171018212924.GL5617@ram.oc3035372033.ibm.com>
 <20171019100857.5e79570e@MiWiFi-R3-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019100857.5e79570e@MiWiFi-R3-srv>
Message-Id: <20171019164633.GT5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 10:08:57AM +1100, Balbir Singh wrote:
> On Wed, 18 Oct 2017 14:29:24 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > On Thu, Oct 19, 2017 at 06:57:32AM +1100, Balbir Singh wrote:
> > > On Fri,  8 Sep 2017 15:45:06 -0700
> > > Ram Pai <linuxram@us.ibm.com> wrote:
> > >   
> > > > Make sure that the kernel does not access user pages without
> > > > checking their key-protection.
> > > >  
> > > 
> > > Why? This makes the routines AMR/thread specific? Looks like
> > > x86 does this as well  
> > 
> > Yes. the memkey semantics implemented by x86, assumes that the keys and
> > their access-permission are per thread.  In other words, a key which is
> > enabled in the context of one thread, will not be enabled in the context
> > of another thread.
> > 
> > > but these routines are used by GUP from
> > > the kernel.  
> > 
> > See a problem?
> >
> 
> No, I don't understand why gup (called from driver context, probably) should
> worry about permissions and keys?

There are some user level features; eg: pipe,  where the userspace
donates one of its pages to the kernel, to buffer the pipe stream.

But if the donated page has a non-permissive key associated, the
kernel should reject and return failure. Access to a page
associated with a non-permissive key should fail regardless of who
accesses the page (userspace, or kernel on userspace's behalf).

That is the reason we tap into the GUP routines to validate such
access.

RP
