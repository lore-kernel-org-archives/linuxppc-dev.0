Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 4C1BFDDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 08:40:18 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LFbSe-0005Cn-E0
	for linuxppc-dev@ozlabs.org; Wed, 24 Dec 2008 13:40:12 -0800
Message-ID: <21156958.post@talk.nabble.com>
Date: Wed, 24 Dec 2008 13:40:12 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
In-Reply-To: <c384c5ea0812221422g513d2545m434d2349f32974e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <21070179.post@talk.nabble.com>
	<20081218190208.GC18201@yoda.jdub.homelinux.org>
	<21087072.post@talk.nabble.com> <200812190856.19482.sr@denx.de>
	<494C10EE.1040305@embedded-sol.com>
	<20081220003704.26bfb042@lappy.seanm.ca>
	<21102440.post@talk.nabble.com>
	<c384c5ea0812221422g513d2545m434d2349f32974e4@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Leon Woestenberg-3 wrote:
> 
> Felix,
> 
> On Sat, Dec 20, 2008 at 7:51 AM, Felix Radensky <felix@embedded-sol.com>
> wrote:
>>
>> I've found the cause of the delay. It was a stupid error on my part, not
>> related to ndfc driver, which is fine. Thanks a lot for you work on this.
>>
> Could you share the error?* (I'm sure I can easily exceed your level
> of stupidity)
> 
> It helps people who are curiously following the thread (either now or
> in two years time, hi there!) learn if it matches their problem.
> 
> 
> Regards,
> -- 
> Leon
> 
> * unless of course, it was really really really stupid in the first
> place and will cost you your daytime job. Then you are excused.
> 
> 

Well, I was simply using the wrong kernel for testing :) I did all work
on 2.6.26, and backported ndfc driver to it. At this stage of the project
it was too risky to use 2.6.28. But I did the minimal porting work, to see
how 2.8.28 behaves on this hardware, and I thought that I saw this long
delay on 2.6.28 as well as on 2.6.26. I was wrong. The reason for long
delay on 2.6.26 is nand ecc code, which was since completely rewritten.
After I've copied  new drivers/mtd/nand/nand_ecc,c to 2.6.26,  the delay
disappeared.

Felix.
-- 
View this message in context: http://www.nabble.com/Long-boot-delay-on-460EX-with-2.6.28-rc8-tp21070179p21156958.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
