Return-Path: <vince@deater.net>
Received: from smtpauth03.mfg.siteprotect.com (smtpauth03h.mfg.siteprotect.com
 [64.26.60.134]) by ozlabs.org (Postfix) with ESMTP id E3A012C00D6
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Aug 2013 13:18:45 +1000 (EST)
Date: Sun, 11 Aug 2013 23:19:52 -0400 (EDT)
From: Vince Weaver <vince@deater.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/7] powerpc/perf: Define big-endian version of
 perf_mem_data_src
In-Reply-To: <20130811235758.GA29824@concordia>
Message-ID: <alpine.DEB.2.02.1308112308040.16609@pianoman.cluster.toy>
References: <20130810174831.GA15551@us.ibm.com>
 <20130810175153.GF15551@us.ibm.com>
 <alpine.DEB.2.02.1308102232120.4119@pianoman.cluster.toy>
 <20130811235758.GA29824@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Aug 2013, Michael Ellerman wrote:
> 
> Yes I think so. The interface is already defined and it's little endian,
> so on big endian we just need to swap.
> 
> The only part I'm not clear on is how things are handled in perf
> userspace, it seems to already do some byte swapping.

It would be nice to clarify this.

"struct perf_branch_entry" also has bitfields like this, though to make
things more confusing that structure isn't exported via the uapi header
so it's not clear how userspace code is supposed to interpret the values.

As you say it gets complicated with perf userspace, especially in cases
where you record the data on big-endian but then try to analyze the
results on a little-endian machine.

It would be nice to get confirmation that these bitfields will always be 
little-endian.  I guess they currently are by definition because only 
x86/pebs sets data.data_src.val so far?

Vince
