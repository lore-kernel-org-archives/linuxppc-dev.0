In-Reply-To: <19991018105201.B17058@bassano.linuxcare.com>
Date: Mon, 18 Oct 1999 20:53:34 +0200
To: "David N. Welton" <davidw@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Kernel questions
Message-Id: <19991018205334.031557@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 18, 1999, David N. Welton <davidw@linuxcare.com> wrote:


>1) Why does everything seem to want to access NVRAM things?  I've
>   found it scattered in several places throughout the kernel, such as
>   matroxfb.c.

Mostly to find out the video mode last set by MacOS. It doesn't always
works since new MacOS versions may no longer put the mode where it used
to be. It's also used by the PMU code on some PowerBooks to read the
current backlight setting.

>3) Why does pmac_support.c assume that you have ADB stuff compiled in?

All pmacs have an ADB controller, even if it's not visible (they have at
least the controller). Some pmac-specific calls go thru /dev/adb even
when you don't have anything on the ADB bus for historical reasons, like
userland access to the real time clock (ioctls). The new UMA machines
still have various ADB calls implemented in the PMU (and used by the iBook).

>nvram_read_byte contains: "struct adb_request req".
>
>If I have understood correctly, ADB is an Apple thing, and really
>shouldn't have anything to do with my RS6000.  Is this correct?

Yes, it's correct. However, I beleive the kernel is compiled to boot on
CHRP _and_ PowerMacs, and so the ADB support is needed. Also, the CHRP
definition states that CHRP machines can have an ADB controller too.

>I'm sorry if some of these are silly questions, and hope my ignorance
>isn't too glaring:-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
