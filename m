Date: Sat, 17 Feb 2001 20:34:01 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: some kernel patches I have (vs. kinda recent BK-2.4)
Message-ID: <20010217203401.C12991@altus.drgw.net>
References: <20010216124720.691e57d5.jpgarcia@execpc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010216124720.691e57d5.jpgarcia@execpc.com>; from jpgarcia@execpc.com on Fri, Feb 16, 2001 at 12:47:20PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 16, 2001 at 12:47:20PM -0600, Joseph P. Garcia wrote:
> Attached are some patches I have against a slightly modified BK linuxppc_2_4 rsync from february 9th.  The modifications not included here are the standard 2.4 crypto and Iain Sandoe's dmasound patch, #21 IIRC.
>
> Figured these should get out there sooner or later so people can test, review, rewrite, get ideas from, or otherwise ignore.
>
> bmac.patch:
>   -if compiled in, powers off bmac when not in use. could be modified to work with module as well if take care not to completely disable IO before removing module
>   -bmac Tx patch as listed before.  appears to work in crossover and some other non-switched situations.  nothing new in the other patch.
>
> ictc.patch:
>   -instruction cache throttling control /proc entry for 2.4.  just for fun i guess.  nothing new
>
> pcmcia.patch:
>   -wallstreet ejection support in 2.4 using Yenta socket (seems to need yenta)
>   -miscelaneus ISA fix
>
> temp.patch:
>   -/proc/cpu temperature support, still uses the asm in misc.S, which should eventually be macros (according to comment)

Could you please take a look at the CONFIG_TAU support in linuxppc_2_5?
(arch/ppc/kernel/temp.c)

I wrote an interrupt-driven driver for the TAU that you can't DOS by
reading /proc/cpuinfo, as well as providing a nice way you could do the
ICTC throttling without continously polling..

>
> misc.patch:
>   -my extraversion in Makefile (VolTemIc = volume,temperature,ictc; pcmcia added with JPG02)
>   -PCIBIOS_MIN_MEM change so my video control doesn't sit at 256M address and panic my system.  (i haven't found where to put the ATI resource fix.  pmac_pcibios_fixup doesnt seem to run, and quirks.c in HEADER mode doesn't do it completely.  help?)
>
> volume.patch:
>   -powerbook volume button control using new input layer.  used to be based on backlight code, now different.  only works once soundcard has been used; key emulation seems broken.  Supports dmasound as a module. (module is the only way I think sound chip can be turned off, saving power)
>
> That's it.  I should be putting these on my page sooner or later. (click on dancing Yurika)
>
> --
> Joseph P. Garcia
> http://www.execpc.com/~jpgarcia


--
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shulz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
