Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjhvZ0yWPzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 19:45:14 +1000 (AEST)
Message-ID: <1467625513.30027.10.camel@neuling.org>
Subject: Re: [PATCH] powerpc/opal: Wake up kopald polling thread before
 waiting for events
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 04 Jul 2016 19:45:13 +1000
In-Reply-To: <1467607904.13965.1.camel@kernel.crashing.org>
References: <1467607904.13965.1.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-07-04 at 14:51 +1000, Benjamin Herrenschmidt wrote:
> On some environments (prototype machines, some simulators, etc...)
> there is no functional interrupt source to signal completion, so
> we rely on the fairly slow OPAL heartbeat.
>=20
> In a number of cases, the calls complete very quickly or even
> immediately. We've observed that it helps a lot to wakeup the OPAL
> heartbeat thread before waiting for event in those cases, it will
> call OPAL immediately to collect completions for anything that
> finished fast enough.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Without this using drivers/mtd/devices/powernv_flash.c on mambo is
impossible. =C2=A0Feels like it's at least 1000x faster.

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/opal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A02 ++
> =C2=A0arch/powerpc/platforms/powernv/opal-async.c |=C2=A0=C2=A05 +++++
> =C2=A0arch/powerpc/platforms/powernv/opal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 12 ++++++++++--
> =C2=A03 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/opal.h
> b/arch/powerpc/include/asm/opal.h
> index 6135816..0c76bc0 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -277,6 +277,8 @@ extern int opal_error_code(int rc);
> =C2=A0
> =C2=A0ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count);
> =C2=A0
> +void opal_wake_poller(void);
> +
> =C2=A0#endif /* __ASSEMBLY__ */
> =C2=A0
> =C2=A0#endif /* _ASM_POWERPC_OPAL_H */
> diff --git a/arch/powerpc/platforms/powernv/opal-async.c
> b/arch/powerpc/platforms/powernv/opal-async.c
> index bdc8c0c..83bebee 100644
> --- a/arch/powerpc/platforms/powernv/opal-async.c
> +++ b/arch/powerpc/platforms/powernv/opal-async.c
> @@ -117,6 +117,11 @@ int opal_async_wait_response(uint64_t token, struct
> opal_msg *msg)
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> +	/* Wakeup the poller before we wait for events to speed things
> +	=C2=A0* up on platforms or simulators where the interrupts aren't
> +	=C2=A0* functional.
> +	=C2=A0*/
> +	opal_wake_poller();
> =C2=A0	wait_event(opal_async_wait, test_bit(token,
> opal_async_complete_map));
> =C2=A0	memcpy(msg, &opal_async_responses[token], sizeof(*msg));
> =C2=A0
> diff --git a/arch/powerpc/platforms/powernv/opal.c
> b/arch/powerpc/platforms/powernv/opal.c
> index 802f3b7..7f13302 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -55,6 +55,7 @@ struct device_node *opal_node;
> =C2=A0static DEFINE_SPINLOCK(opal_write_lock);
> =C2=A0static struct atomic_notifier_head
> opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
> =C2=A0static uint32_t opal_heartbeat;
> +static struct task_struct *kopald_tsk;
> =C2=A0
> =C2=A0void opal_configure_cores(void)
> =C2=A0{
> @@ -650,6 +651,7 @@ static void opal_i2c_create_devs(void)
> =C2=A0
> =C2=A0static int kopald(void *unused)
> =C2=A0{
> +	unsigned long timeout =3D msecs_to_jiffies(opal_heartbeat) + 1;
> =C2=A0	__be64 events;
> =C2=A0
> =C2=A0	set_freezable();
> @@ -657,12 +659,18 @@ static int kopald(void *unused)
> =C2=A0		try_to_freeze();
> =C2=A0		opal_poll_events(&events);
> =C2=A0		opal_handle_events(be64_to_cpu(events));
> -		msleep_interruptible(opal_heartbeat);
> +		schedule_timeout_interruptible(timeout);
> =C2=A0	} while (!kthread_should_stop());
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +void opal_wake_poller(void)
> +{
> +	if (kopald_tsk)
> +		wake_up_process(kopald_tsk);
> +}
> +
> =C2=A0static void opal_init_heartbeat(void)
> =C2=A0{
> =C2=A0	/* Old firwmware, we assume the HVC heartbeat is sufficient */
> @@ -671,7 +679,7 @@ static void opal_init_heartbeat(void)
> =C2=A0		opal_heartbeat =3D 0;
> =C2=A0
> =C2=A0	if (opal_heartbeat)
> -		kthread_run(kopald, NULL, "kopald");
> +		kopald_tsk =3D kthread_run(kopald, NULL, "kopald");
> =C2=A0}
> =C2=A0
> =C2=A0static int __init opal_init(void)
>=20
>=20
