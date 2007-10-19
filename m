Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 001FCDDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 15:35:04 +1000 (EST)
In-Reply-To: <20071019013048.GC30283@localhost.localdomain>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
	<20071019013048.GC30283@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <83c7a6126bf86eaf90c6744ba43df3df@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Merge dtc
Date: Fri, 19 Oct 2007 00:34:53 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 8:30 PM, David Gibson wrote:

> On Thu, Oct 18, 2007 at 12:49:54PM -0500, Milton Miller wrote:
>> On Tue Oct 16 15:02:17 EST 2007, David Gibson wrote:
>>> Too big for the list, full patch at
>>> http://ozlabs.org/~dgibson/home/merge-dtc.patch+
>>
>> So split it up.   The obvious one is "here is the unique content, then
>> copy these files from dtc git" would have been better.
>
> *facepalm*
>
> The point of the small patches thing is not to glom together logically
> separate patches.  It's *not* to split patches up simply for the sake
> of making them smaller.

The point of posting on the list is to encourage review before merging. 
  Hiding them behind a download means a lot fewer people are looking at 
the code.

> You've suggested the closest thing to a logical split here, but even
> then - the dtc files are dead without the Makefile changes, and the
> Makefile changes won't build without the dtc files (so the patches
> would have to go in reversed order to what you suggest).
>
> Not to mention that the Makefile patch will be tiny and the raw import
> will still be way too big for the list.

I'm talking about split for review, not necessarily merge.

We split by function for review so that different people pay closer 
attention to their areas of intrest and speciality.  This helps prevent 
people being distracted by the bulk.

The files that are verbatim from the other project have been reviewed 
in that project (at least in theory), and therefore are not likely to 
draw comments.   Especially since they are (1) shadows from another 
project and (2) host files, there is more flexibility and less review 
required, eg relaxed coding standards, correctness already tested, and 
in this case multiple platform testing.

Sam's suggestion to split the generated files was because they require 
no review other than for damage.

In contrast, the files such as the make rules are original and unique 
to this import, and therefore draw comments during review.  If you 
weren't asking for a review, why did you post to the mailing list?

Oh, and the files being in the tree but dead is fine from a bisect 
standpoint.  The patch can be reverted if the makefile doesn't go in 
(not that a maintainer would commit them separately).

>> I finally went and looked at the url.  The Kbuild integration is 
>> wrong.
>
> Wrong?  Not how you'd prefer them perhaps...

Wrong in that its unlike every other program that Kbuild makes.

>>   It should build dtc in dtc-src and run the binary from there, and 
>> the
>> rules should be in a Kconfig as a normal host-target in that 
>> directory.
>
> Why?  This approach has the advantage that the subdirectory contains
> *only* verbatim imported files, which could well make updates simpler.

The file name Kbuild is unlikely to conflict with a file from that 
other repository.  It doesn't contain all the files in that repository 
(or even all in a subdirectory) so there is some filtering going on 
anyways.

>    (I don't have a problem with that Kbuild including Makefie.dtc).
>>
>> things like the dependancy on scripts_basic in the top level
>> Makefile.
>
> I'm not even sure what you mean by this.

I was trying to give a hint where you could find "compile programs in 
that directory so I can run them here" for you to draw upon.
