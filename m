Date: Mon, 17 Jan 2000 19:04:16 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000118020416.ZM17186@saguaro.lan>
In-Reply-To: Sean Chitwood <darkmane@w-link.net>
        "Re: Help w/ gdb" (Jan 17,  4:40pm)
References: <Pine.LNX.4.10.10001171637020.3713-100000@darkmane.w-link.net>
To: darkmane@w-link.net
Subject: Re: Help w/ gdb
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 17,  4:40pm, Sean Chitwood wrote:

> Ok, I'm assuming you mean to change the CFLAGS in the Makefile... 
> correct?  I'll do that tonight and hopefully let you know in th
> emorning....

Yes.  (Or whatever variable your Makefile uses to set the -g debugging
flag for the compiler.)

BTW, make sure you specify it as -gdwarf-2 and NOT -gdwarf2.  Oddly
enough, these mean completely different things.  (The former says to
use the DWARF2 format while the latter says to use the DWARF format at
debugging level 2.)

> Just for my edification, what is the difference between -g and
> -gdwarf-2...  I have a bad feeling one produces elf binaries and one
> produces dwarf binaries....  Not that I would know the difference...

ELF binaries are created in both instances.  It's the debugging format
which will be different.  Many platforms use the stabs debugging
format by default -- I think this is the default format for linux/ppc. 
You can explicitly use a different format by using one of the other
-g switches.  (-gstabs, -gstabs+, -gdwarf, -gdwarf+, ...)

To be quite honest with you, I haven't checked recently to see which
debug format linux/ppc uses by default or even if DWARF2 will work at
all.  But it is something to try.  Even if DWARF2 isn't completely
satisfactory for debugging (e.g, it could generate outrageously large
symbolic information), if it addresses the specific problem that you
reported, it'll let me know if it's worth it for you to try a patch
which does a better job of resolving zero-valued N_FUN symbols for the
stabs format.

I noted in another message that there's a patch at the end of

    http://sourceware.cygnus.com/ml/gdb/1999-q3/msg00325.html

that you could try, but I doubt that it will apply cleanly.  (I think
I have one that should apply cleanly though.  But before I send it to
you, I'd like to know the results of your DWARF2 tests.)

Kevin

-- 
Kevin Buettner
kev@primenet.com, kevinb@cygnus.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
