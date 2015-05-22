Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0DBC1A0BF5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 04:09:51 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 22 May 2015 12:09:49 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DB81419D8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 12:00:49 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4MI9H9q33751116
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 11:09:17 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4MI9jLj029681
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 12:09:47 -0600
Date: Fri, 22 May 2015 11:09:17 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150522180917.GA5471@us.ibm.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150522145615.GA16473@krava.redhat.com>
 <20150522155822.GA15904@us.ibm.com>
 <20150522180110.GI7484@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150522180110.GI7484@tassilo.jf.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andi Kleen [ak@linux.intel.com] wrote:
| > pmu-events.c depends only on JSON files relevant to the arch perf is
| > being built on and there could be several JSON files per arch. So it
| > would complicate the Makefiles.
| 
| Could just use a wildcard dependency on */$(ARCH)/*.json 

Sure, but shouldn't we allow JSON files to be in subdirs

	pmu-events/arch/x86/HSX/Haswell_core.json

and this could go to arbitrary levels?

| 
| Also it would be good to move the generated file into the object
| directory. I tried it but it needs some more changes to the Makefiles.
| 
| -Andi
