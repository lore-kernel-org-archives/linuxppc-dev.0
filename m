Subject: Re: Question about PPC __put_user_asm/__get_user_asm
To: paubert@iram.es (Gabriel Paubert)
Date: Wed, 5 Apr 2000 10:21:56 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.HPX.4.10.10004041321080.21080-100000@gra-ux1.iram.es> from "Gabriel Paubert" at Apr 04, 2000 01:35:34 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000405002157.104963C978@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:
> At least i386 does the same trick as Documentation/exception.txt explains.
> But using .text explicitly is bad style in any case, you might want to
> replace it by .previous like in this hand-built unified diff for the
> __put_user_asm case:

Thanks Gabriel; I must have been going blind yesterday when I looked at the
i386 uaccess.h file to not notice this!

> Caution: I don't claim it will solve all your problems: actually it will
> still leave some remnants in the __ex_table and .fixup sectioons which
> will be cause linker errors. But at least the code of the functions will
> stay in the appropriate section. I've no idea on how to generate per
> function __ex_table and fixup sections (actually I think it's the wrong
> approach for 6xx/7xx/7xxx PPC for other reasons).

I don't believe we want per-function __ex_table and .fixup sections, so I
think using .previous in the __get_user_asm & __put_user_asm solves my problem.
I get no link errors from the resulting kernel, but the output is way too
small, and `nm' doesn't even recognise it -- so I'll have to solve this next.

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
