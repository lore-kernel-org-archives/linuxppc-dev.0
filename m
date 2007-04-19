Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.154])
	by ozlabs.org (Postfix) with ESMTP id 0384CDDE42
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 09:45:49 +1000 (EST)
Message-ID: <4627FF29.1050409@gmail.com>
Date: Thu, 19 Apr 2007 19:45:45 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [U-Boot-Users] [PATCH: dtc take 2] Assemble the blob in memory
	before writing it out.
References: <20070419015951.GA9339@dellserver.lan>	<1177007241.14328.21.camel@ld0161-tx32>	<4627B9C7.8010800@smiths-aerospace.com>
	<E1HefA8-0008Tl-VA@jdl.com>
In-Reply-To: <E1HefA8-0008Tl-VA@jdl.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	u-boot-users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> So, like, the other day Jerry Van Baren mumbled:
>> Patch #2 and #3...
>>    [PATCH dtc take 3] Fix reserve map output for asm format.
>>    Tue, 17 Apr 2007 18:14:41 -0400
>>    [PATCH: dtc take 2] Assemble the blob in memory before writing it out.
>>    Wed, 18 Apr 2007 21:59:51 -0400
> 
> [snip]
> 
>> AAAARGH!  Sorry, I see I left a debug statement in flattree.c around 
>> line 390:
> 
>> Your option:
>> 1) Take the last two patches as is and remove the fprintf yourself
> 
> 
> Applied #2 and #3 listed above.
> Cleaned out the debug fprintf().
> 
> Thanks,
> jdl

Oh oh, does NOT look good.  I lost the rewrite of the header size with 
the new, bigger size when -S is specified.

Ahh, I think I see the problem, sloppy programming bites me again. 
Modifying "bph.totalsize" worked before I changed to the struct data 
blob.  Grrrr.   I need to figure out the padding and apply it to the bph 
before starting the blob assembly.  Before the line:

         blob = data_append_data(blob, &bph, sizeof(bph));

Patch will take a bit because I have a meeting to go to :-(.

sorry,
gvb
