Date: Tue, 29 Jan 2002 00:26:41 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	Momchil Velikov <velco@fadata.bg>, geert@linux-m68k.org
Subject: Re: Broken asm/div64.h macro
Message-ID: <20020129002640.M14339@altus.drgw.net>
References: <20020129003720.GA25973@opus.bloom.county> <200201290508.OAA07699@mail.highway.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200201290508.OAA07699@mail.highway.ne.jp>; from k_fukui@highway.ne.jp on Tue, Jan 29, 2002 at 02:05:28PM +0900
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> So you copy the code from the libgcc sources, cfr. arch/m68k/lib/.
> >
> > Or optimize that, yes.  But linking directly is a no-no. :)
>
> Yes,it's should has the source in the kernel.
>
> However,the other archies(arm,cris,sh) use libgcc.a with static
> link.
> Those makefiles have
> LIBGCC  := $(shell $(CC) $(CFLAGS) --print-libgcc-file-name)
>
> If it's static link, it is same result isn't it?


libgcc is a no-no.. it's big, and also encourages users to do silly
things like long long divides and multiples in kernel fast-paths.

I posted a patch to linux-kernel (subject was 64 bit divides, or
something), regarding a cleanup for the whole asm/div64.h macro mess.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
