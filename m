Date: Mon, 22 Nov 1999 16:55:35 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Christian Zankel <chris@mvista.com>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
Message-ID: <19991122165535.A13360@hq.fsmlabs.com>
References: <19991122120429.031138@mailhost.mipsys.com> <19991122143732.B12973@hq.fsmlabs.com> <3839CF18.5D600DE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3839CF18.5D600DE@mvista.com>; from Christian Zankel on Mon, Nov 22, 1999 at 03:17:44PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Not all machines.  The gemini and yellowknife don't have a bootloader.

I don't think this would work in all cases, although it would be great if
we could do it.  We can't stomp on the interrupt vectors at physical 0
because chrp/pmac need them to do the early OF calls to setup things and
copy the device tree before we can safely stomp on physical 0.  If the
bootloader did that, there wouldn't be a problem.  Then we have to pass all
the OF info we need that the bootloader has gathered to the kernel.  The
bootloaders would have to duplicate a lot of common code to do that, though
(quik, bootx, chrpboot, arch/ppc/boot/, coffboot and so on).  We could have
a common lib for them to use, though.

I'm all for doing something along these lines, though.  I'm just not sure
how to do it.  Any suggestions one how to get around the above problem?

It would be ideal to have the kernel start at physical 0, with the bootinfo
info passed along with the necessary data the bootloader has gathered.  If
there's no bootloader then the arch specific calls can gather what they
need.

} It seems to me that on almost every machine linuxppc is running on
} depends on having a bootloader to load the kernel. Would it be possible
} to redesign all bootloaders to load the kernel to position 0, initialize
} the OF path where necessary and jump to the kernel with the MMU switched
} off? Then we could possibly remove all the conditional code (#if ...
} #else .. #endif) in head.S mm/init.c, etc.

I don't agree.  It takes some manipulation in head.S or a clever
bootloader, though.  If you have suggestions for a simpler/cleaner system I
would be happy to add them, though!

} Right now, it is painfull to add a new machine that doesn't follow the
} full PReP,CHRP specification, i.e. has no OF nor Residual Data
} structures, etc.

If you're doing the 82xx work we should talk before you do that too much.
I'd like to find something that makes 8xx,6-7xx and 4xx happy before I
start merging in large tree-changes.

} I started to restructure the arch/ppc tree. However, I would like to
} hear about your thoughts and recommendation. The goals I want to
} achieve, are:
} 
} 1. The bootloader gets a more active part, i.e. does some
} pre-initiaization, esp. to get rid of the 'bl prom_init' and the variaty
} of copying the kernel back and forth.

Do you mean something like the common build?  Right now that works on
chrp/prep/pmac but the embedded systems would really hurt if we allowed
them to bloat.  It think they're still not lean enough (they have to
include a lot of non-board/processor specific code as it is).

} 2. It should be possible to setup the kernel so that the same kernel
} runs on all those machine that it is setup for. Of course, the more
} machines you add the more overhead you get.

We have something very close to that now.  What specific problems are you
having?  I'm not disagreeing that it's a problem, I just don't see where
the problem is.

} 3. Each machine/architecture should get its own directory (pmac, prep,
} chrp, apus, geminit, etc.)
} 4. To add a new machine, only a new directory has to be added and only a
} few files have to be changed (mainly: Config.in and Makefile).
} 5. The _machine-ID is seperated into to fields, Vendor and Board.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
