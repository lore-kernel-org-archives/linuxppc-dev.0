Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 6AB4FDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Feb 2007 05:17:54 +1100 (EST)
In-Reply-To: <45CC45C4.6070501@selta.it>
References: <45CC45C4.6070501@selta.it>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <702AA1B6-621F-4317-842F-1DD2BE26C4A9@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: question about m8260_cpm_hostalloc
Date: Sat, 10 Feb 2007 13:11:12 -0500
To: stefania magistrali <s.magistrali@selta.it>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 9, 2007, at 4:58 AM, stefania magistrali wrote:

> Hi!
> I am using the m8260_cpm_hostalloc function. My question is: does this
> function return cached or uncached memory?

It returns a cache coherent address space.
Whether it's cached or uncached is determined
by the capabilities of the processor.

> I need to have uncached memory,

Why?  The CPM on the 82xx performs
cache coherent data transfers with the
G2 core.

Make sure you are using the proper memory
allocation functions.  The XXX_cpm_hostalloc()
function is intended to provide an efficient
allocator for the small memory resident FIFOs
or control structures needed by the CPM.
It's not a data transfer buffer allocator.

Thanks.


	-- Dan
