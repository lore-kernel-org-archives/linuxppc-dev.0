Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id ED12C67B48
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 19:09:26 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so2871706ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 02:09:22 -0700 (PDT)
Message-ID: <528646bc0606280209m4ce91cb0wc3cab2f2d3aec1a7@mail.gmail.com>
Date: Wed, 28 Jun 2006 03:09:22 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: dhlii@comcast.net
Subject: Re: how to get individual patches
In-Reply-To: <44A23488.7030606@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>
	<20060627212448.7d048b7a@White64> <44A23488.7030606@dlasys.net>
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

On 6/28/06, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>
>     The bsp I am working on works with 2.6.16.21 but fails with 2.6.17.
>
>     How can I find the individual patches that make up the transition
> from 2.6.16.21 to 2.6.17 ?

Unfortunately, there isn't a direct line between .16.21 and .17 which
makes it complicated.  Does your bsp work with .16?  If so; you can
use the 'git bisect' command to figure out exactly where the
regression occured.

If it doesn't work on .16; you can do a bisect between .16 and .16.21
to figure out what patch is missing between .16 and .17.

$ git bisect good v2.6.16
$ git bisect bad           # the head of the tree
compile, test, etc.
$ git bisect good|bad    # depends on whether it works or not
compile, test, etc
$ git bisect good|bad    # you get the idea... repeat until it's narrowed down
$ git log                          # see where you are in the git tree.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
