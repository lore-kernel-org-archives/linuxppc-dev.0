Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 5698EDDF9A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 17:29:12 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Rework hrtimer_nanosleep to make sys_compat_nanosleep
	easier
Date: Mon, 15 Oct 2007 09:28:55 +0200
References: <20071014215437.GF26693@kryten>
	<alpine.LFD.0.9999.0710150804290.22612@localhost.localdomain>
	<20071015063833.GA15396@kryten>
In-Reply-To: <20071015063833.GA15396@kryten>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710150928.56916.arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 15 October 2007, Anton Blanchard wrote:
> Pull the copy_to_user out of hrtimer_nanosleep and into the callers
> (common_nsleep, sys_nanosleep) in preparation for converting
> compat_sys_nanosleep to use hrtimers.

Looks good, except for two micro-optimization:

> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> @@ -1361,7 +1356,14 @@ sys_nanosleep(struct timespec __user *rqtp, struct=
 timespec __user *rmtp)
> =A0=A0=A0=A0=A0=A0=A0=A0if (!timespec_valid(&tu))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EINVAL;
> =A0
> -=A0=A0=A0=A0=A0=A0=A0return hrtimer_nanosleep(&tu, rmtp, HRTIMER_MODE_RE=
L, CLOCK_MONOTONIC);
> +=A0=A0=A0=A0=A0=A0=A0ret =3D hrtimer_nanosleep(&tu, &rmt, HRTIMER_MODE_R=
EL, CLOCK_MONOTONIC);
> +
> +=A0=A0=A0=A0=A0=A0=A0if (ret && rmtp) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (copy_to_user(rmtp, &rmt=
, sizeof(*rmtp)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret=
urn -EFAULT;
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0return ret;
> =A0}
> =A0

If it's common to call sys_nanosleep with a NULL rmtp argument, we could sa=
ve a
few cycles using=20

	return hrtimer_nanosleep(&tu, rmtp ? &rmp : NULL, HRTIMER_MODE_REL,
								 CLOCK_MONOTONIC);

> diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
> index 57efe04..cce8c75 100644
> --- a/kernel/posix-timers.c
> +++ b/kernel/posix-timers.c
> @@ -980,9 +980,19 @@ sys_clock_getres(const clockid_t which_clock, struct=
 timespec __user *tp)
> =A0static int common_nsleep(const clockid_t which_clock, int flags,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
struct timespec *tsave, struct timespec __user *rmtp)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0return hrtimer_nanosleep(tsave, rmtp, flags & TIMER=
_ABSTIME ?
> +=A0=A0=A0=A0=A0=A0=A0struct timespec rmt;
> +=A0=A0=A0=A0=A0=A0=A0int ret;
> +
> +=A0=A0=A0=A0=A0=A0=A0ret =3D hrtimer_nanosleep(tsave, &rmt, flags & TIME=
R_ABSTIME ?
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 which_clock);
> +
> +=A0=A0=A0=A0=A0=A0=A0if (ret && rmtp) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (copy_to_user(rmtp, &rmt=
, sizeof(*rmtp)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret=
urn -EFAULT;
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> +=A0=A0=A0=A0=A0=A0=A0return ret;
> =A0}

I think it would be better here to propagate the move to a kernel *rmtp
down to sys_clock_nanosleep so we get the same optimization in
compat_sys_clock_nanosleep. That should probably also be a separate
patch. I can do one if you don't do it first.

	Arnd <><
