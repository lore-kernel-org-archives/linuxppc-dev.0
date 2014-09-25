Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EE981A0069
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 18:59:38 +1000 (EST)
Date: Thu, 25 Sep 2014 10:58:58 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 01/10] tools/perf: support parsing parameterized events
Message-ID: <20140925085858.GA20915@krava.brq.redhat.com>
References: <1411586844-21381-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1411586844-21381-2-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411586844-21381-2-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, Michael Ellerman <michaele@au1.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org, eranian@google.com,
 dev@codyps.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2014 at 12:27:15PM -0700, Sukadev Bhattiprolu wrote:
> From: Cody P Schafer <cody@linux.vnet.ibm.com>
> 
> Enable event specification like:
> 
> 	pmu/event_name,param1=0x1,param2=0x4/
> 
> Assuming that
> 
> 	/sys/bus/event_source/devices/pmu/events/event_name
> 
> Contains something like
> 
> 	param2=foo,bar=1,param1=baz

hum, so what happened to the '?' ... AFAIU from out last discussion,
you wanted to mark terms which are mandatory and user must provide
values for them.. and I thought the decision was to have following
alias record:

  $ cat /sys/bus/event_source/devices/pmu/events/event_name
  param2=?,bar=1,param1=?

while perf would scream if any of param1/2 wasnt filled like for:
  pmu/event_name,param1=0x1/


thanks,
jirka
