Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410c9y2444zF1Rt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 02:06:29 +1000 (AEST)
Date: Tue, 5 Jun 2018 09:06:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Problems building ppc images in v4.14.y and v4.16.y using gcc
 7.3.0 / 8.1.0 from kernel.org
Message-ID: <20180605160624.GA30373@roeck-us.net>
References: <e11832b0-f071-b709-be34-417f2d3bc343@roeck-us.net>
 <CAK8P3a3CFhkjPCX8bgZbx7aYwrUVsKE5ct4ghnMxJLo5OSYqbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a3CFhkjPCX8bgZbx7aYwrUVsKE5ct4ghnMxJLo5OSYqbA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 05, 2018 at 04:31:00PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 5, 2018 at 3:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > Hi Arnd,
> >
> > when using the ppc64 compiler from kernel.org, I see the following problems
> > when trying to compile ppc:allnoconfig in v4.14.y or v4.16.y.
> >
> > gcc 7.3.0: Compilation of kernel.cpu.o hangs
> >
> > The problem goes away if I apply the following two patches (tested with
> > 4.16.y)
> >
> > 17a2f1ced028 cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states
> > fcb3029a8d89 cpu/hotplug: Fix unused function warning
> 
> This is probably the same as
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84038
> 
> I thought I had included the fix in my builds.
> 
Guess not.

> > gcc 8.1.0: Compilation of kernel/cpu.o results in the following error
> >
> > powerpc64-linux-gcc: error: unrecognized command line option '-mno-spe'; did
> > you mean '-fno-see'?
> > powerpc64-linux-gcc: error: unrecognized command line option '-mspe=no'; did
> > you mean '-misel=no'?
> >
> > This problem is also seen with mainline.
> 
> I've seen it, but couldn't figure out what the right fix is. I ended
> up commenting
> out those two lines in my private builds:
> 
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -215,8 +215,8 @@ KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
> 
>  # No SPE instruction when building kernel
>  # (We use all available options to help semi-broken compilers)
> -KBUILD_CFLAGS += $(call cc-option,-mno-spe)
> -KBUILD_CFLAGS += $(call cc-option,-mspe=no)
> +#KBUILD_CFLAGS += $(call cc-option,-mno-spe)
> +#KBUILD_CFLAGS += $(call cc-option,-mspe=no)
> 
>  # Enable unit-at-a-time mode when possible. It shrinks the
>  # kernel considerably.
> 
> I think there were some changes in how cc-option gets evaluated, maybe
> those rely on something else to be enabled or disabled first?
> 
I think it may have cached the flags from the other compiler version.
"make mrproper" prior to "make defconfig" took care of the issue.

However, that doesn't really help - I get lots of
	error: 'sys_spu_create' alias between functions of incompatible types
	error: 'strncpy' output truncated before terminating nul
if I try to use gcc 8.1.0.

Oh well. I'll try gcc 6.4.0 next.

Thanks,
Guenter
