Message-ID: <3CA108B3.21854885@mvista.com>
Date: Tue, 26 Mar 2002 18:48:03 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203270135.AA02861@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> Now if you actually implement your way in code and make it work, I'll accept it
> even though I dislike it, but if your above proposal remains verbiage, my patch
> must be pushed instead. Unimplemented verbiage must not take precedence over
> working code.

First, we need to see if this is going to fit with everything else in
2_4/2_4_devel and then it will get implemented.

Its not that much work:

1) Make a function (or two) like what's already been talked about to search for
bi_recs of certain types (starting from a specified location so you don't keep
finding the same one).

2) Change parse_bootinfo to use that function but only look up truly generic ones
like BI_CMD_LINE

3) Change the gt64260_enet driver to search for the ones specific to it (and
remove the code for it that is in parse_bootinfo in your patch)

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
