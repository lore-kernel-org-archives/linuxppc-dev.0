Return-Path: <arndbergmann@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410Z3v68pFzF1nG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2018 00:31:04 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id 76-v6so3640557itx.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 07:31:04 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <e11832b0-f071-b709-be34-417f2d3bc343@roeck-us.net>
References: <e11832b0-f071-b709-be34-417f2d3bc343@roeck-us.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 5 Jun 2018 16:31:00 +0200
Message-ID: <CAK8P3a3CFhkjPCX8bgZbx7aYwrUVsKE5ct4ghnMxJLo5OSYqbA@mail.gmail.com>
Subject: Re: Problems building ppc images in v4.14.y and v4.16.y using gcc
 7.3.0 / 8.1.0 from kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 5, 2018 at 3:52 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi Arnd,
>
> when using the ppc64 compiler from kernel.org, I see the following problems
> when trying to compile ppc:allnoconfig in v4.14.y or v4.16.y.
>
> gcc 7.3.0: Compilation of kernel.cpu.o hangs
>
> The problem goes away if I apply the following two patches (tested with
> 4.16.y)
>
> 17a2f1ced028 cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states
> fcb3029a8d89 cpu/hotplug: Fix unused function warning

This is probably the same as
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84038

I thought I had included the fix in my builds.

> gcc 8.1.0: Compilation of kernel/cpu.o results in the following error
>
> powerpc64-linux-gcc: error: unrecognized command line option '-mno-spe'; did
> you mean '-fno-see'?
> powerpc64-linux-gcc: error: unrecognized command line option '-mspe=no'; did
> you mean '-misel=no'?
>
> This problem is also seen with mainline.

I've seen it, but couldn't figure out what the right fix is. I ended
up commenting
out those two lines in my private builds:

--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -215,8 +215,8 @@ KBUILD_CFLAGS += $(call cc-option,-mno-vsx)

 # No SPE instruction when building kernel
 # (We use all available options to help semi-broken compilers)
-KBUILD_CFLAGS += $(call cc-option,-mno-spe)
-KBUILD_CFLAGS += $(call cc-option,-mspe=no)
+#KBUILD_CFLAGS += $(call cc-option,-mno-spe)
+#KBUILD_CFLAGS += $(call cc-option,-mspe=no)

 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.

I think there were some changes in how cc-option gets evaluated, maybe
those rely on something else to be enabled or disabled first?

        Arnd
