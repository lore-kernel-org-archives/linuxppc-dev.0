Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E9051A0C86
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 23:45:01 +1100 (AEDT)
Date: Thu, 4 Dec 2014 13:44:22 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/4] tools/perf: support parsing parameterized events
Message-ID: <20141204124422.GA4195@krava.brq.redhat.com>
References: <1417572578-9051-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1417572578-9051-2-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417572578-9051-2-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, peterz@infradead.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 dev@codyps.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 02, 2014 at 06:09:35PM -0800, Sukadev Bhattiprolu wrote:
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
> 	param2=$foo,bar=1,param1=$baz

oops.. sorry to be PITA on this one.. I might have missed something
in the previous discussion but I guess I might have finally some
opinion on this ;-)

here's how I think your patchset works:

in /sys/bus/event_source/devices/pmu/events/event_name you can actually have:

   param2=foo,bar=1,param1=baz

notice no '$', thats what you add later in 'perf list' output, right?

Moreover it actually does not matter whats in value 'param2=HERE',
because it's not used in the config code at all apart from the
'perf list' display processing.

So when we discussed the '$' name way, I thought it'd be like:

in /sys/bus/event_source/devices/pmu/events/event_name you have:
  param2=$foo,bar=1,param1=$baz

and on command line you'd use:
  pmu/event_name,foo=0x1,bar=0x4/

to assign directly to the $var, which would justify the $var
syntax I think..

anyway we could assign directly to the param term name as you do,
but I think we just need to mark the term as parametrized, like:

in /sys/bus/event_source/devices/pmu/events/event_name you have:
  param2=?,bar=1,param1=?

and on command line you'd use:
  pmu/event_name,param2=0x1,param1=0x4/

while the config code would check that the param substitution is
done only for terms with '?' in value, like 'param2=?' and not
for all PARSE_EVENTS__TERM_TYPE_STR type terms (as of now)

thanks,
jirka
