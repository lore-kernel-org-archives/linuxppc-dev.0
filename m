Message-Id: <200106291744.f5THia810339@stimpy.networkrobots.com>
Date: Fri, 29 Jun 2001 10:48:45 -0700
To: Dan Malek <dan@mvista.com>, jtm@smoothsmoothie.com
From: Paul White <pwhite@networkrobots.com>
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B3C30CD.34B20F02@mvista.com>
References: <20010626160844.A20988@shamus.smoothsmoothie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Btw...Where are these "consistent_alloc()" functions?  I've not seen theses
anywhere.

I also can't imagine how they would possibly work on any CPU using BATs.
Since the BAT is setup as cacheable space, you can't just take a "chunk"
of it and make it non-cacheable.  Not possible.

Now, yes, for the 4xx and 8xx proccessors that don't use BATs, I would
assume that when you do one of these "non-cache" allocs, it would
simply allocate you a batch of 4k pages, and set them as Caching
Inhibited.

Is there something I'm missing here?

Paul W.

At 03:39 AM 6/29/2001 -0400, Dan Malek wrote:
>
>jtm@smoothsmoothie.com wrote:
>
>> .... The buffer memory will get filled
>> via DMA, and therefore must not be cached.
>
>Huh????  The 8260 is cache coherent, you don't need to do that.
>
>For processors that are not cache coherent (4xx and 8xx), there
>are standard 'consistent_alloc()' functions available.
>
>
>	-- Dan
>
>
-------------------------------------------------------------
Network Robots, Inc.         /--\               Paul H. White
                           / ____ \
4695 Chabot Dr. #200      / ( oo ) \       Software Developer
Pleasanton, CA 94588     /   ----   \             Engineering
(925) 924-8600           \   ----   /          (925) 580-4883
                          \  V--V  /
                           \      /
                             \--/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
