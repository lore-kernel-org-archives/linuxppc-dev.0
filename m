Return-Path: <ak@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 973781A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 15:49:29 +1000 (AEST)
Date: Fri, 29 May 2015 22:49:27 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] perf, tools: Handle header line in mapfile
Message-ID: <20150530054927.GB1187@tassilo.jf.intel.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150528124221.GK12392@krava.redhat.com>
 <20150529054506.GA3088@us.ibm.com>
 <20150529091140.GA20512@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150529091140.GA20512@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 29, 2015 at 11:13:15AM +0200, Jiri Olsa wrote:
> On Thu, May 28, 2015 at 10:45:06PM -0700, Sukadev Bhattiprolu wrote:
> > Jiri Olsa [jolsa@redhat.com] wrote:
> > | >  		if (line[0] == '#' || line[0] == '\n')
> > | >  			continue;
> > | > +		if (!strncmp(line, "Family", 6))
> > | > +			continue;
> > | 
> > | I think we should fix mapfiles to put the 'Family' starting
> > | line as a comment.. the way powerpc mapfile is done
> > 
> > You mean add something like this to the Intel mapfile:
> > 
> > 	# Power8 entries
> > 	004d0100,1,power8.json,core
> > 
> > and drop this patch?
> 
> right

But it's a CSV file. CSV files are supposed to have column headers.
There are lots of tools that work better with them if they have headers.
Please keep the header.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
