Message-ID: <3E8C52DD.8050107@embeddededge.com>
Date: Thu, 03 Apr 2003 10:27:25 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Donald White <dbwhite@asu.edu>
Cc: linux-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about porting VxWorks driver
References: <3E8BECA6.6060709@asu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Donald White wrote:

> Is this the right approach for me to take?  Does Linux support
> designating memory
> regions for writethrough caching?  If it does, should I use it rather
> than doing
> what I am doing?

Writethough policies to I/O devices seems kind of weird.  If there
is a performance advantage because you are treating the device like
memory and using it to store buffers you will soon read again (unchanged),
you are likely to see even higher performance if you allocate system
memory in copyback mode for this purpose and just copy the data to
the I/O device when necessary.

I suspect writethrough was used to avoid cache flushing operations,
but uncached would likely result in better system performance because
you aren't blowing away cache lines useful to other software in
the system.

Linux does not support writethrough attributes through any memory
management functions, it only selects between cached and uncached
policies.  On 8xx, you can globally select all cached memory to be
writethrough (usually for debugging), and *all* ioremap() areas are uncached.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
