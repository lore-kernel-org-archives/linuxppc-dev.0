Date: Thu, 27 Jan 2000 18:15:38 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Kevin M. Myer" <kevin_myer@elanco.k12.pa.us>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.40 + offb.c problem
In-Reply-To: <Pine.LNX.4.20.0001271014260.6226-100000@marble.elanco.k12.pa.us>
Message-ID: <Pine.LNX.4.05.10001271815001.17766-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 Jan 2000, Kevin M. Myer wrote:
> Compilation goes along happily until I get to the video driver
> section.  At that point, I get:
>
> offb.c: In function `offb_init_driver':
> offb.c:474: parse error before `{'
> offb.c: At top level:
> offb.c:479: parse error before `return'
>
> which is the code section:
>
> #ifdef CONFIG_FB_CLGEN
>     if ((!strncmp(dp->name, "MacPicasso",10) ||
>         (!strncmp(dp->name, "54m30",5)) {
>        clgen_of_init(dp);
>        return 1;
>     }
> #endif /* CONFIG_FB_CLGEN */
>
> This is with the Open Firmware framebuffer option checked in the kernel
> configuration.
>
> I'm more than a little green when it comes to kernel hacking but there
> doesn't seem to be anything wrong with that code snippet.  I thought at
> first some of the changes I had made to incorporate the other cirrus54m30
> driver were goofing things up so I grabbed a pristine source of 2.3.40 and
> am still having the same problems.

Count the braces and you'll notice two `)'s are missing.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
