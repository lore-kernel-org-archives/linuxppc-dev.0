Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id E640067BC6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jul 2006 15:31:02 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1567743ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Jul 2006 22:30:57 -0700 (PDT)
Message-ID: <528646bc0607162230p6bc33ee0xc6f5e74e8def251d@mail.gmail.com>
Date: Sun, 16 Jul 2006 23:30:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: dhlii@comcast.net
Subject: Re: how to get individual patches
In-Reply-To: <44BB080E.6060107@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>
	<20060627212448.7d048b7a@White64> <44A23488.7030606@dlasys.net>
	<528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>
	<44B7DEC3.1090308@dlasys.net>
	<528646bc0607141122t53adeb30h8c2acb4e26ba0ddf@mail.gmail.com>
	<44BB080E.6060107@dlasys.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/16/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>     The zlib library was updated within the past month.
>     The new zlib code does not work in my environment.
>     I have guesses as to why, but I am not a zlib expert and not looking
> to be one.
>     I have solved my personal problem by reverting to the older zlib code.
>     With that I have 2.6.18-rc4 or whatever is in the linux-2.6 git tree
> as of today working for me.
>     I was stuck at 2.6.16.21 before.
>
>     So my questions:
>
>     How/where do I report a problem ? I would be perfectly happy to help
> whoever is responsible for zlib to work this out.
>     But I am not up to doing it myself.

Once you've got the patch extracted (see below); post it to the lkml
with a description of your symptoms and what you are trying to do.
(or post it here, and if nobody knows; then move over to the lkml)

>
>     git bisect got me down to a good/bad scenario. But I could not
> provoke git to either pull the offending patch or export the change as a
> patch so that I could back it out myself.
>     Now that the final git bisect screen is gone all I have (besides a
> fixed 2.6.18-xx kernel) is I guess the sha has number for the particular
> commit.

git-format-patch <good_sha1>..<bad_sha1>

for example:
$ git-format-patch
0ce030395b92270567423d57d9d432eb77df32f2..8d92bc2270d67a43b1d7e94a8cb6f81f1435fe9a
0001-PCI-Error-handling-on-PCI-device-resume.txt

extracts a single patch file for the
PCI-Error-handling-on-PCI-device-resume.txt commit.  If there are more
than one commits between <good_sha1> and <bad_sha1>, then you'll get
more than one patch file extracted.

Then, you can apply the patch reversed to backout the change.

>     I suspect that would have been enough to yank just that patch but I
> googled every permutation of git backout or similar things I could think
> of and browsed the git tutorials etc.
>     and could not seem to decipher how to do anything usefull with the
> sha id of a single patch.

"git-log <sha1>" will give you the history starting at a particular
commit, which is useful for finding the next commit after it for doing
the git-format-patch command.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
