Message-Id: <4.3.2.20000627151503.00b6abc0@falcon.si.com>
Date: Tue, 27 Jun 2000 15:35:20 -0400
To: Dan Malek <dan@netx4.com>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: PLPRCR & Checkstop reset
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3958FD77.97001F7A@netx4.com>
References: <Pine.LNX.3.96.1000625172850.17884A-100000@tristar.cc.absoval.com>
 <3958E040.15B86909@netx4.com>
 <4.3.2.20000627142525.00b61100@falcon.si.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It is unfortunate that there apparently is no standard.  The only item
that I'm concerned with at the moment is the 8260 IMMR which is
readable but only if you know where it is first, in which case there is
no need to read it. :-(

Due to (a) laziness and (b) heredity (the board's, not mine), the power
up IMMR value on the systems I'm using is not the proper value for
running linux so we change it as part of our custom startup.  This code
cannot be re-run on a warm start because the IMMR is already moved.  If
there is no standard way to distinguish a warm start from a cold start
(e.g. different entry points), we will have to stash a special flag in
RAM that, if it is set to a magic number, tells us not to mess with the
IMMR because it is already correct.

gvb


At 03:16 PM 6/27/00 -0400, Dan Malek wrote:
>Jerry Van Baren wrote:
>
> > It would be better to not jump to the reset vector on a warm
> > start.
>
>Yes, but there isn't any standard among the 8xx boot roms.
>
>This seems to work on all of the boards I have ever tested.  If
>it doesn't work for you, let's discuss it and find something that
>does.
>
>
>
>         -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
