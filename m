Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 7C1F9DDEAB
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 14:49:19 +1000 (EST)
In-Reply-To: <20070719021138.GE20458@localhost.localdomain>
References: <boot-6-00.miltonm@bga.com> <boot-6-02.miltonm@bga.com>
	<20070719021138.GE20458@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <be091e2b9aa68c854d8bd77c99af91d1@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/15] boot: record header bytes in gunzip_start
Date: Wed, 18 Jul 2007 23:46:51 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 9:11 PM, David Gibson wrote:

> On Tue, Jul 10, 2007 at 05:08:05PM -0500, Milton Miller wrote:
>>
>> Record the number of header bytes skipped in the total bytes read 
>> field.
>>
>> This is needed for the initramfs parsing code to find the end of the 
>> zip file.
>>
>> Signed-off-by: Milton Miller <miltonm@bga.com>
>
> Ok... I assume you've checked that this is actually the correct
> semantics for that field of the zlib structure?

 From looking at the comments in include/linux/zlib.h, I think its 
consistent.  It talks about looking at that field for statistics and 
for the application to record how many bytes were read during 
compression.  It mentions it brifely in the inflateSync to show how 
many bytes have been processed.   So I say its consistent to say we 
have processed the header bytes in the input file.

It appears to be for recording the number of bytes processed over all 
iterations.

I dig into zlib to see if this matches the beahvior of decompressing a 
zlib header, but expect it would match.


milton
