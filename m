In-Reply-To: <Pine.HPX.4.10.10002221001530.4957-100000@gra-ux1.iram.es>
Date: Tue, 22 Feb 2000 11:50:01 +0100
To: Gabriel Paubert <paubert@iram.es>, paulus@linuxcare.com,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Patch for optimize context switch
Message-Id: <20000222115001.027256@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 22, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>Exactly, context switches are infrequent and should be benchmarked at
>least after having invalidated the code from the instruction cache
>(whether it should also be pushed out of the L2 cache is more questionable
>but I would also push it out since L2 cache is only direct mapped or 2 way
>set associative on most processors). Besides the time of the loop is
>dominated by the execution synchronized mtsrin. Actually the only
>processor on which it might be a clear win is the 601.

BTW. There's an idea that have been idling in my mind for some time:

Do you think there would be any interest into adding code to some drivers
for invalidating the data cache of buffers before doing DMA-read i/os to
them ? (For example invalidating the block buffers before or just after
having started a DMA read in the IDE driver).

Those datas will be replaced by new datas, so invalidating them before
(or at the beginning of) the transfer will help avoiding snooping hits
during the transfer itself, and eventually help keeping more useful
things in the cache.

I'm not sure this would have any measurable impact, I may just setup a
lmbench and try it out once I'm finished with my current stuffs.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
