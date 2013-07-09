Return-Path: <michael@ellerman.id.au>
Date: Tue, 9 Jul 2013 11:29:52 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
Message-ID: <20130709012952.GA7185@concordia>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130704125700.GM18898@dyad.programming.kicks-ass.net>
Cc: vincent.weaver@maine.edu, Vince Weaver <vince@deater.net>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 acme@redhat.com, paulus@samba.org, xiaoguangrong@linux.vnet.ibm.com,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 04, 2013 at 02:57:00PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 04, 2013 at 10:52:18PM +1000, Michael Ellerman wrote:
> > I don't think it even needs libpfm4, just some csv files in tools/perf
> > would do the trick.
> 
> Right; I think Stephane and Jiri are in favour of creating a 'new' project that
> includes just the event definitions in a plain text format and a little library
> with parser to be used by all interested parties.

OK that would be great.

The part that seems to be missing to make that work is we have no way of
matching the PMU that appears in /sys with a list of events.

Eg. on my system I have /sys/bus/event_source/devices/cpu - but there's
nothing in there to identify that it's a Sandy Bridge.

For the cpu you can obviously just detect what processor you're on with
cpuid or whatever, but it's a bit of a hack. And that really doesn't
work for non-cpu PMUs.

So it seems to me we need to add an attribute to the PMU in sysfs so
that we can identify it and match it up with a list of events?

cheers
