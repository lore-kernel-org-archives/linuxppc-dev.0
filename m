Return-Path: <cyeoh@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17542.9980.803879.151529@localhost.localdomain>
Date: Wed, 7 Jun 2006 11:08:12 +1000
From: "Christopher Yeoh" <cyeoh@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: Collecting hypervisor call stats
In-Reply-To: <20060606164646.GA3161@w-mikek2.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<AEFF6654-C958-42F7-93CF-64103B015CB1@watson.ibm.com>
	<17534.30511.192632.558778@localhost.localdomain>
	<20060606164646.GA3161@w-mikek2.ibm.com>
Cc: Chris Yeoh <yeohc@au1.ibm.com>, Bryan Rosenburg <rosnbrg@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At 2006/6/6 09:46-0700  Mike Kravetz writes:
> On Thu, Jun 01, 2006 at 03:12:15PM +1000, Christopher Yeoh wrote:
> > Here's a patch we've used for collecting hcall counts and times.
> 
> Thanks for the patch/code Chris!  I'm using this as a basis for something
> that we may want to merge into the tree.  Just a couple of questions.
> 
> Your 'wrappers' have the following general form:
> 
> 
> Can you explain the need for barrier(s) before and after the call to the
> real routine?  It usually takes me a couple days of thought to figure out
> exactly where these are needed. :)

Ah oops, it turns out I was wrong and they're not necessary after all.

> The use of get_cpu_var/put_cpu_var result in disabling/enabling preemption.
> I can understand why this would be desirable to assure the accuracy of the
> statistics.  But, I was wondering if the desired accuracy is worth the added
> overhead.  My thought was to make these as lightweight as possible and
> sacrifice some accuracy if necessary.  After all, no 'internal decisions' are
> being made because of this data.  It is simply exposed to user land.
> Thoughts?

For what we were using them for at the time we weren't really
concerned about a small degradation in performance and were more
interested in accuracy. I guess I'd recommend doing some benchmarking
to see what difference they really make.

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
