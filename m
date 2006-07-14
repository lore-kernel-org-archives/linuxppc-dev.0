Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 2DCAD67B7C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 04:22:11 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id m3so904257ugc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 11:22:10 -0700 (PDT)
Message-ID: <528646bc0607141122t53adeb30h8c2acb4e26ba0ddf@mail.gmail.com>
Date: Fri, 14 Jul 2006 12:22:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: dhlii@comcast.net
Subject: Re: how to get individual patches
In-Reply-To: <44B7DEC3.1090308@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>
	<20060627212448.7d048b7a@White64> <44A23488.7030606@dlasys.net>
	<528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>
	<44B7DEC3.1090308@dlasys.net>
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

On 7/14/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>
>      Thank You git bisect has proven to be incredibly interesting.
>
>      One question/problem - maybe an incomplete understanding of git.
>
>      What I need to do is get to some version of 2.6.16 - as they all work
> for me.
>
>      cut in my patches.
>
>      And THEN start bisecting while retaining my patches.
>
>      Is that going to work or am I going to have to repatch each time ?

AFAIK, yes you will have to repatch every time; I typically write a
little helper script to lessen the pain:

git bisect good|bad # depends on whether it works or not
patch < [patchfile]
compile, test, etc
cg restore -f     # Remove the patches
git bisect good|bad   # lather, rinse, repeate

>
>      Basically can I use git to insert a patch into the middle of its delta
> history and then advance forward from there ?

I don't think so; no automatically; but if you don't commit your
changes then it's easy to drop the change the patch makes.

git-rebase does something similar to what you're trying to do; but
it's complex to use (especially if there are conflicts) and might
conflict w/ the git-bisect tool

>
>      It is rapidly becoming obvious that competence with git could have big
> payback.

:)

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
