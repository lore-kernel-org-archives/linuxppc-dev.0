From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: progress on l2cr
Date: Mon, 31 Jul 2000 20:42:28 +0200
Message-Id: <20000731184228.18405@192.168.1.10>
In-Reply-To: <39861753.8DB68BB6@denise.shiny.it>
References: <39861753.8DB68BB6@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >Is there any reason to keep the L2 cache data-only ?
>>
>> There are some rare cases where it can be useful, yes. Like when flushing
>> it, to avoid the flush code to pollute it.
>
>A few bytes inside a 1MB cache are't a problem IMHO. Anyway I enabled it and
>performance compiling programs is 15% lower.

You have no reason to enable "data only" in normal use. It's used during
the flush cycle of the cache to avoid polluting it while the flush code
runs, but it's set and unset automatically, so you don't need to care.

My latest rsync tree also contains an improved l2cr set routine which
should no longer require Michel's trick to manually disable&flush it
before setting it. It also work around some CPU bugs when DPM (dynamic
power management) is enabled why flushing the L2 cache.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
