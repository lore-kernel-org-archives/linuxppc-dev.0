Mime-Version: 1.0
Message-Id: <v04220800b56236d3e80e@[10.0.0.42]>
In-Reply-To: <Pine.LNX.4.05.10006051614100.5397-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10006051614100.5397-100000@callisto.of.borg>
Date: Mon, 5 Jun 2000 22:15:55 -0700
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Michel Lanners <mlan@mcp.cpu.lu>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: [patch] VRAM detection in controlfb
Cc: Tony Mantler <nicoya@apia.dhs.org>, mlan@cpu.lu, drow@false.org,
        linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:15 PM +0200 6/5/00, Geert Uytterhoeven wrote:
>On Mon, 5 Jun 2000, Michel Lanners wrote:
>>  So I guess the optimum would be to mark the VRAM cacheable, but in
>>a way that
>>  writes don't go into the cache. Would that be write-through?
>
>That's indeed write-through. Note that writes will still be cached in such a
>way that a consecutive read from the same location will return the cached
>value.  But writes will immediately be sent to the host bridge.

Unfortunately a side effect of write-through mode is that it prevents
burst writes.  Memory must be cacheable in copy-back mode for
existing PowerPC CPUs to perform burst writes.

Many Intel CPUs implement write combining for precisely this region.
In a memory region marked as OK for write combining, the CPU is free
to wait and collect data from several writes to perform a burst write
rather than performing a write immediately.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
