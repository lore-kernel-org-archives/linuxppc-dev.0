Date: Fri, 7 Mar 2003 21:02:57 -0500
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re: Runtime Altivec detection
Message-Id: <20030307210257.7b094f55.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Nathan,

> On Fri, 7 Mar 2003, Nathan Ingersoll wrote:
>
> On Fri, Mar 07, 2003 at 06:54:58PM +0000, Magnus Damm wrote:
> > mplayer and ffmpeg does some kind of detection runtime.
> > I'm playing with it right now actually.
>
> Last I heard, it was a compile time detection or flag. So you had to build
> separate binaries for your G4 and non-G4 machines.
>
> > While at it:
> >
> > I've seen that -maltivec and -mabi=altivec is passed sometimes.
> > If I want to build a binary that should be able to run on a
> > G3 without altivec and utilize altivec when present on a G4,
> > what flags should I use?
>
> There is no specific flag for doing so, you need some code to detect the
> capability, and then decide whether to use the Altivec routine.

Here is the code xine uses to do run time Altivec detection
(from xine-utils/cpu_accel.c):

#if defined (ARCH_PPC) && defined (ENABLE_ALTIVEC)
static sigjmp_buf jmpbuf;
static volatile sig_atomic_t canjump = 0;

static void sigill_handler (int sig)
{
    if (!canjump) {
        signal (sig, SIG_DFL);
        raise (sig);
    }

    canjump = 0;
    siglongjmp (jmpbuf, 1);
}

static uint32_t arch_accel (void)
{
    signal (SIGILL, sigill_handler);
    if (sigsetjmp (jmpbuf, 1)) {
        signal (SIGILL, SIG_DFL);
        return 0;
    }

    canjump = 1;

    __asm__ volatile ("mtspr 256, %0\n\t"
                  "vand %%v0, %%v0, %%v0"
                  :
                  : "r" (-1));

    signal (SIGILL, SIG_DFL);
    return MM_ACCEL_PPC_ALTIVEC;
}
#endif /* ARCH_PPC */

And here's the gcc command used to compile cpu_accel.c:

gcc -DHAVE_CONFIG_H -I. -I. -I../.. -I../.. -I../../include -I../../include -I../../src -I../../src/xine-engine -I../../src/xine-engine -I../../src/xine-utils -I/usr/X11R6/include -std=gnu89 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -DXINE_COMPILE -O3 -pipe -fomit-frame-pointer -fexpensive-optimizations -fschedule-insns2 -fno-strict-aliasing -ffast-math -funroll-loops -funroll-all-loops -finline-functions -Wa,-m7400 -I/usr/include/kde/artsc -c cpu_accel.c -Wp,-MD,.deps/cpu_accel.TPlo  -fPIC -DPIC -o cpu_accel.lo

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
