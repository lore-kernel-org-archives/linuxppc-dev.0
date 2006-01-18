Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6DA87688D6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 23:28:49 +1100 (EST)
Message-ID: <43CE3475.9040406@varma-el.com>
Date: Wed, 18 Jan 2006 15:28:37 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: General GIT MO question
References: <43CB3127.7060107@dlasys.net> <43CD2003.3020903@secretlab.ca>
In-Reply-To: <43CD2003.3020903@secretlab.ca>
Content-Type: text/plain; charset=KOI8-R
Cc: "David H. Lynch Jr." <dhlii@dlasys.net>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> David H. Lynch Jr. wrote:
>> 	I appreciate you feedback on the E12/UartLite stuff I posted earlier.
> no problem
> 
>> 	I have gotten sufficiently compitent with git that I can use it as a
>> source code manager.
>> 	But despite perusing through a fairly significant amount of git docs, I
>> have not really grasped how to get from how I work to what seems to be
>> the norm for patch subimissions.
> Heh, your tracking the same path of pain that I went through 2 months
> ago.  :)
> 
>> 	Fixing a bug or adding a small feature is one thing. You have a base,
>> and and end result and a simple diff. But I am porting to a whole new
>> board, adding support for two new serial drivers, and adding boot to
>> init serial IO support - all at once, as well as dealing with bugs and
>> mis-steps along the way.
>>
>> 	I can figure out how to get git to do alot of nice things, but I can
>> not figure out how to get it to produce a nice modularized set of
>> patches that includes only those things relevant for kernel submission.
> Here's what I do, assuming that my changes are in the 'master' branch,
> and 'master' is based off of 'origin'.  BTW, I also use the cogito with git.
> 
> 1. create a new branch 'cleanup' off of origin so it doesn't have any of
> my patches in it.
> $ git branch cleanup origin
> $ git checkout origin
> 
> 2. get a list of all my patches; I use 'cg log' and look for the sha1
> 'commit' tags.
> $ cg log master
> p
> 3a. start 'cherry-picking' my patches one-by-one from 'master' to
> 'cleanup'.  Feel free to use this to reorder patches
> $ git cherry-pick -r <first-commit-sha1>
> $ git cherry-pick -r <second-commit-sha1>
> $ git cherry-pick -r <third-commit-sha1>
> 
> 3b. If I want to modify the patch before committing; I use the -n flag
> to only apply the changes; clean up the change, then commit it with the
> -c flag.  Also do this if a patch conflicts.
> $ git cherry-pick -r -n <messy-commit-sha1>
> $ <edit stuff>
> $ cg commit -c <messy-commit-sha1>   # Use the original change message
> 
> 3c. Cherry picking works for merging patches too
> $ git cherry-pick -r -n <partial-patch1>
> $ git cherry-pick -r -n <partial-patch2>
> $ git cherry-pick -r -n <partial-patch3>
> $ cg commit
> 
> 4. generate patch files for submission to the mailing list
> $ git-format-patch -o <output dir> origin cleanup
> 
> 5. (optional) make 'cleanup' the new 'master
> $ git branch -f master cleanup
> $ git checkout master
> 
>> 	I am looking for a clue here. How do you produce a clean set of
>> granular patches including only what you want and not the all the steps
>> and mis-steps along the way ?
> 
> 

Or use stg (http://www.procode.org/stgit/),
steps 1-2 you could made by
 stg new
steps 3 trough 5 by :
 stg refresh/stg export

--
Regards
Andrey Volkov
