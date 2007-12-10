Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 7F146DDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 02:40:09 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] windfarm: add PowerMac 12,1 support
Date: Mon, 10 Dec 2007 16:39:52 +0100
References: <1196904050.7132.36.camel@thilivren>
	<1196955051.6862.10.camel@thilivren>
	<1197299517.6822.2.camel@thilivren>
In-Reply-To: <1197299517.6822.2.camel@thilivren>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200712101639.52599.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 10 December 2007, =C3=89tienne Bersac wrote:
> From: =C3=89tienne Bersac <bersace03@gmail.com>
>=20
> Here is an updated patch that fix the potential bug, CPU param detection
> failure might not be detected. Please review it.=20

I didn't find much interesting to complain about, just a few style
issues that could be improved. Good work!

> -static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr)
> +static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr,
> +			      const char *loc)
>  {
>  	struct wf_6690_sensor *max;
> -	char *name =3D "backside-temp";
> +	char *name =3D NULL;
> =20

It's better not to initialize local variables like this one, instead of
assigning them to 0 or NULL. When it's not initialized, gcc is able to
warn about cases where you don't assign a meaningful value before using
it.

> +#undef	DEBUG
> +
> +#ifdef DEBUG
> +#define DBG(args...)	printk(args)
> +#else
> +#define DBG(args...)	do { } while (0)
> +#endif

Don't define your own macros like these, but instead use the ones that
are there. If possible, use 'dev_dbg()', otherwise 'pr_debug()'.

> +static int pm121_mach_model;	/* machine model id */
> +
> +/* Controls & sensors */
> +static struct wf_sensor	*sensor_cpu_power;
> +static struct wf_sensor	*sensor_cpu_temp;
> +static struct wf_sensor	*sensor_cpu_voltage;
> +static struct wf_sensor	*sensor_cpu_current;
> +static struct wf_sensor	*sensor_gpu_temp;
> +static struct wf_sensor	*sensor_north_bridge_temp;
> +static struct wf_sensor	*sensor_hard_drive_temp;
> +static struct wf_sensor	*sensor_optical_drive_temp;
> +static struct wf_sensor	*sensor_incoming_air_temp; /* unused ! */
> +static struct wf_control *controls[N_CONTROLS] =3D {};
> +
> +static unsigned int pm121_failure_state;
> +static int pm121_readjust, pm121_skipping;
> +static s32 average_power;

Having many global variables is typically a sign that you are doing
something wrong. It's better to attach all the data you have to your
device structure.

Have you checked that you are doing the right locking when accessing
these variables from concurrent threads?

> +struct pm121_correction {
> +	int	offset;
> +	int	slope;
> +};
> +
> +struct pm121_correction corrections[N_CONTROLS][PM121_NUM_CONFIGS] =3D {

This looks like it could be 'const'. 'static const' variables are better
because it becomes obvious that you don't need locking to access them.

> +static struct pm121_connection pm121_connections[] =3D {

same here.

> +static struct pm121_sys_param
> +pm121_sys_all_params[N_LOOPS][PM121_NUM_CONFIGS] =3D {

and here.


> +#ifdef HACKED_OVERTEMP
> +#define	MAX	0x4a0000
> +#else
> +#define	MAX	st->pid.param.tmax
> +#endif
> +	if (temp > MAX)
> +		pm121_failure_state |=3D FAILURE_OVERTEMP;
> +
> +#undef	MAX

You don't define HACKED_OVERTEMP anywhere, so you basicall have dead
code here. It's probably better to remove that for the upstream version,
even if it was helpful for your debugging.

> +
> +#define	pm121_register_control(control, match, id)			\
> +	if (controls[id] =3D=3D NULL && !strcmp(control->name,match)) {	\
> +		if (wf_get_control(control) =3D=3D 0)			\
> +			controls[id] =3D control;				\
> +	}								\
> +	all =3D all && controls[id];

Does this need to be a macro? If possible, use static functions
for this kind of stuff. They will normally be inlined, which gives
you the same object code in the end.

> +static int __init pm121_init(void)
> +{
> +	int rc =3D -ENODEV;
> +
> +	if (machine_is_compatible("PowerMac12,1"))
> +		rc =3D pm121_init_pm();
> +
> +	if (rc =3D=3D 0) {
> +#ifdef MODULE
> +		request_module("windfarm_smu_controls");
> +		request_module("windfarm_smu_sensors");
> +		request_module("windfarm_smu_sat");
> +		request_module("windfarm_lm75_sensor");
> +		request_module("windfarm_max6690_sensor");
> +		request_module("windfarm_cpufreq_clamp");
> +
> +#endif /* MODULE */
> +		platform_driver_register(&pm121_driver);
> +	}
> +
> +	return rc;
> +}

Why the #ifdef MODULE here? It's normally better to have identical
code for modular and built-in cases.

	Arnd <><
