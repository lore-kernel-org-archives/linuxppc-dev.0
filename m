Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-39.bluehost.com (outbound-mail-39.bluehost.com
	[70.98.111.193]) by ozlabs.org (Postfix) with SMTP id 09DE868916
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 03:49:17 +1100 (EST)
Message-ID: <43CD2003.3020903@secretlab.ca>
Date: Tue, 17 Jan 2006 09:49:07 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: General GIT MO question
References: <43CB3127.7060107@dlasys.net>
In-Reply-To: <43CB3127.7060107@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
> 	I appreciate you feedback on the E12/UartLite stuff I posted earlier.
no problem

> 
> 	I have gotten sufficiently compitent with git that I can use it as a
> source code manager.
> 	But despite perusing through a fairly significant amount of git docs, I
> have not really grasped how to get from how I work to what seems to be
> the norm for patch subimissions.
Heh, your tracking the same path of pain that I went through 2 months
ago.  :)

> 
> 	Fixing a bug or adding a small feature is one thing. You have a base,
> and and end result and a simple diff. But I am porting to a whole new
> board, adding support for two new serial drivers, and adding boot to
> init serial IO support - all at once, as well as dealing with bugs and
> mis-steps along the way.
> 
> 	I can figure out how to get git to do alot of nice things, but I can
> not figure out how to get it to produce a nice modularized set of
> patches that includes only those things relevant for kernel submission.
Here's what I do, assuming that my changes are in the 'master' branch,
and 'master' is based off of 'origin'.  BTW, I also use the cogito with git.

1. create a new branch 'cleanup' off of origin so it doesn't have any of
my patches in it.
$ git branch cleanup origin
$ git checkout origin

2. get a list of all my patches; I use 'cg log' and look for the sha1
'commit' tags.
$ cg log master
p
3a. start 'cherry-picking' my patches one-by-one from 'master' to
'cleanup'.  Feel free to use this to reorder patches
$ git cherry-pick -r <first-commit-sha1>
$ git cherry-pick -r <second-commit-sha1>
$ git cherry-pick -r <third-commit-sha1>

3b. If I want to modify the patch before committing; I use the -n flag
to only apply the changes; clean up the change, then commit it with the
-c flag.  Also do this if a patch conflicts.
$ git cherry-pick -r -n <messy-commit-sha1>
$ <edit stuff>
$ cg commit -c <messy-commit-sha1>   # Use the original change message

3c. Cherry picking works for merging patches too
$ git cherry-pick -r -n <partial-patch1>
$ git cherry-pick -r -n <partial-patch2>
$ git cherry-pick -r -n <partial-patch3>
$ cg commit

4. generate patch files for submission to the mailing list
$ git-format-patch -o <output dir> origin cleanup

5. (optional) make 'cleanup' the new 'master
$ git branch -f master cleanup
$ git checkout master

> 
> 	I am looking for a clue here. How do you produce a clean set of
> granular patches including only what you want and not the all the steps
> and mis-steps along the way ?


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
