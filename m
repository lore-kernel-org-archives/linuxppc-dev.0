Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgXtf1mnxzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 16:36:42 +1000 (AEST)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 7 Apr 2016 16:36:41 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C34852BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 16:36:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u376a5Kp36176050
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 16:36:13 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u376YdXd015257
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Apr 2016 16:34:40 +1000
Date: Thu, 7 Apr 2016 12:02:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/2] perf/powerpc: Fix kprobe and kretprobe handling with
 kallsyms
Message-ID: <20160407063233.GJ15993@naverao1-tp.in.ibm.com>
References: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
 <97bd954477bc7a94e676d3510c6f945ff9c9e0cc.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
 <20160407043019.GD3620@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160407043019.GD3620@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/07 10:00AM, Ananth N wrote:
> On Wed, Apr 06, 2016 at 06:02:57PM +0530, Naveen N. Rao wrote:
> 
> > +	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
> >  		tev->point.offset += PPC64LE_LEP_OFFSET;
> 
> uprobes check against kallsysms? Am I missing something here?

Ah yes. That check shouldn't be necessary since symtab_type would be 
different anyway. I will remove that check.

Thanks for the review!
- Naveen
