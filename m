Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spBfq0MJQzDrSm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 19:20:03 +1100 (AEDT)
Date: Tue, 4 Oct 2016 10:19:58 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
 Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v21 16/19] perf, tools: Make alias matching
 case-insensitive
Message-ID: <20161004081958.GB29784@krava>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-17-git-send-email-sukadev@linux.vnet.ibm.com>
 <20161004004706.GF7143@kernel.org>
 <20161004005448.GG7143@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161004005448.GG7143@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 03, 2016 at 09:54:48PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 03, 2016 at 09:47:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Sep 15, 2016 at 03:24:53PM -0700, Sukadev Bhattiprolu escreveu:
> > > From: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Make alias matching the events parser case-insensitive. This is useful
> > > with the JSON events. perf uses lower case events, but the CPU manuals
> > > generally use upper case event names. The JSON files use lower
> > > case by default too. But if we search case insensitively then
> > > users can cut-n-paste the upper case event names.
> > > 
> > > So the following works:
> > > 
> > > % perf stat -e BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL true
> > > 
> > >  Performance counter stats for 'true':
> > > 
> > >                305      BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL
> > > 
> > >        0.000492799 seconds time elapsed
> > 
> > So now trying to figure this out:
> 
> Ok, so this is just another case of bad patch ordering: this uses 'perf
> stat' as the example, but it doesn't work at this point, one needs to go
> to the last patch, apply it and then test it again, when it will work.
> So just moved the last patch to before this one, sigh.

ok, you found it.. sry ;-)

jirka
