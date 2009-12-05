Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 61E0DB7BF9
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Dec 2009 04:56:16 +1100 (EST)
Date: Sat, 5 Dec 2009 20:56:14 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Tyser <ptyser@xes-inc.com>
Subject: Re: [PATCH] powerpc: mpc8xxx_gpio: Add ability to mask off unused
	GPIO pins
Message-ID: <20091205175614.GA10057@oksana.dev.rtsoft.ru>
References: <1259955820-28565-1-git-send-email-ptyser@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1259955820-28565-1-git-send-email-ptyser@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On Fri, Dec 04, 2009 at 01:43:40PM -0600, Peter Tyser wrote:
> This change resolves 2 issues:
> - Different chips have a different number of GPIO pins per controller.
>   For example, the MPC8347 has 32, the P2020 16, and the mpc8572 8.
>   Previously, the mpc8xxx_gpio driver assumed every chip had 32 GPIO
>   pins which resulted in some processors reporting an incorrect 'ngpio'
>   field in /sys.  Additionally, users could export and "use" 32 GPIO
>   pins, although in reality only a subset of the 32 pins had any real
>   functionality.
> 
> - Some boards don't utilize all available GPIO pins.  Previously,
>   unused GPIO pins could still be exported and "used", even though the
>   pins had no real functionality.  This is somewhat confusing to a user
>   and also allow a user to do something "bad", like change an unused
>   floating output into a floating input.

There are hundreds of other ways to screw things up.

Think of /dev/mem, you still able to change the registers.
Before changing any GPIO (whether it is a normal or reserved GPIO),
user has to consult with schematics/docs.

> Adding a new "fsl,gpio-mask" device tree property allows a dts file to
> accurately describe what GPIO pins are available for use on a given
> board.

I don't see any real usage for this. If device tree specifies a wrong
gpio in the gpios = <> property, then it's a bug in the device tree
and should be fixed (or workarounded in the platform code).

If a user fiddles with unknown gpios via sysfs interface, then it's
user's problem.

FWIW, we don't have any masks for reserved IRQs.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
