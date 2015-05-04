Return-Path: <ak@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id B72EB1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 21:44:38 +1000 (AEST)
Date: Mon, 4 May 2015 04:44:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC][PATCH 4/4] perf: Create aliases for PMU events
Message-ID: <20150504114435.GQ13605@tassilo.jf.intel.com>
References: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1430463941-26109-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150502153814.GA21242@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150502153814.GA21242@krava.redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 mingo@redhat.com, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I personaly like having set of event files in JSON notation
> rather than having them directly in C structure

Yes, strings are better and JSON input is also better. 

I prototyped translating JSON into the proposed structures. I already had to
add three new fields, and it wouldn't work for uncore. The string 
format is much more extensible.

BTW as expected the binary sizes are gigantic (for 14 CPU types):

% size all.o
   text    data     bss     dec     hex filename
 662698       0       0  662698   a1caa all.o

% gcc -E all.c | wc -l
55475

-Andi
