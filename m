Date: Mon, 18 Oct 1999 12:13:53 -0700
From: "David N. Welton" <davidw@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel questions
Message-ID: <19991018121353.D17058@bassano.linuxcare.com>
References: <19991018105201.B17058@bassano.linuxcare.com> <19991018205334.031557@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991018205334.031557@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Mon, Oct 18, 1999 at 08:53:34PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 18, 1999 at 08:53:34PM +0200, Benjamin Herrenschmidt wrote:
> 
> On Mon, Oct 18, 1999, David N. Welton <davidw@linuxcare.com> wrote:

> >1) Why does everything seem to want to access NVRAM things?  I've
> >   found it scattered in several places throughout the kernel, such as
> >   matroxfb.c.
 
> Mostly to find out the video mode last set by MacOS. It doesn't
> always works since new MacOS versions may no longer put the mode
> where it used to be. It's also used by the PMU code on some
> PowerBooks to read the current backlight setting.

Well, supposing one doesn't have a Macintosh or MacOS, then this stuff
is basically useless, no?  At least for how it's being used currently.

> >3) Why does pmac_support.c assume that you have ADB stuff compiled in?
> 
> All pmacs have an ADB controller, even if it's not visible (they have at
> least the controller). Some pmac-specific calls go thru /dev/adb even
> when you don't have anything on the ADB bus for historical reasons, like
> userland access to the real time clock (ioctls). The new UMA machines
> still have various ADB calls implemented in the PMU (and used by the iBook).

Once again, I don't have a pmac...

> >nvram_read_byte contains: "struct adb_request req".
> >
> >If I have understood correctly, ADB is an Apple thing, and really
> >shouldn't have anything to do with my RS6000.  Is this correct?
 
> Yes, it's correct. However, I beleive the kernel is compiled to boot
> on CHRP _and_ PowerMacs, and so the ADB support is needed. Also, the
> CHRP definition states that CHRP machines can have an ADB controller
> too.

There are a few options:

PowerMac
Prep/MTX
CHRP
PowerMac/PReP/CHRP
Gemini
APUS

I'm compiling as CHRP, and since ADB is selectable as an option, it
seems it could be added in anyway, pmac or not?

So would it be a worthwhile endeavour to try and ifdef this stuff out,
for those of us who don't need it?

Thanks,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
dwelton@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
