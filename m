Date: Sat, 25 Jan 2003 18:47:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Till Straumann <Till.Straumann@TU-Berlin.de>
Cc: linuxppc-dev@lists.linuxppc.org, vojtech@suse.cz
Subject: Re: [patch] ignore trackpad/mouse while typing
Message-ID: <20030125184701.A16865@ucw.cz>
References: <3DE6C428.5000403@TU-Berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DE6C428.5000403@TU-Berlin.de>; from Till.Straumann@TU-Berlin.de on Thu, Nov 28, 2002 at 05:34:32PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 28, 2002 at 05:34:32PM -0800, Till Straumann wrote:
> OK, here's a trivial patch (linux-2.4.18) for disabling/ignoring
> the mouse/trackpad while typing. It can be very convenient on notebook
> computers.
> NOTE: this patch works only on machines using the 'new' input layer
> (e.g. Apple Powerbook, ibook, ...)
>
> The holdoff time can be adjusted via sysctl/procfs - see description
> in the patch file.

It's a very nice idea, but I'd prefer this to be handled somewhere
higher than the IDE code, preferably in X ...

> -- Till
>
> PS: Please CC me if there are comments/questions; I'm not subscribed to
> this mailing list.

> This is a patch for linux-2.4.18
>
> Author: Till Straumann <strauman@slac.stanford.edu>
>
> Apply this patch as follows:
>     - chdir to the linux kernel source topdir
>     - issue 'patch -p0 < <this file>'
>       NOTE: it is alway a good idea to use --dry-run first
>
> Using this patch, it is possible to ignore mouse events
> while your are typing which can be very convenient on
> notebook computers equipped with trackpads.
>
> NOTE: Works only for mice/keyboards who use the 'new' input
>       layer (USB, powermac, ...).
>
> You will get a new file (and a respective sysctl)
>
>     /proc/sys/dev/input/mouse_holdoff_ms
>
> for tuning the time period during which the mouse is to
> be ignored after a keystroke (valid range from
> 0 [disabled]  ... 3000 ).
>
> NOTE: Official 'SYSCTL' numbers should be assigned
>       for the 'input' and 'input/mouse_holdoff_ms' nodes.
>
>
> *** drivers/input/input.c.orig	Thu Nov 28 12:00:07 2002
> --- drivers/input/input.c	Thu Nov 28 12:18:58 2002
> ***************
> *** 28,33 ****
> --- 28,37 ----
>    * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
>    */
>
> + #include <linux/config.h>
> + #include <linux/proc_fs.h>
> + #include <linux/sysctl.h>
> +
>   #include <linux/init.h>
>   #include <linux/sched.h>
>   #include <linux/smp_lock.h>
> ***************
> *** 60,65 ****
> --- 64,74 ----
>   static int input_number;
>   static long input_devices[NBITS(INPUT_DEVICES)];
>
> + static unsigned long mouse_holdoff_jiffies = 0;
> + static unsigned long mouse_holdoff_ms_min  = 0;
> + static unsigned long mouse_holdoff_ms_max  = 3000;
> + static unsigned long mouse_holdoff_last_jiffie = 0;
> +
>   void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
>   {
>   	struct input_handle *handle = dev->handle;
> ***************
> *** 71,76 ****
> --- 80,94 ----
>   	if (type > EV_MAX || !test_bit(type, dev->evbit))
>   		return;
>
> + 	if ( EV_KEY == type && code < BTN_MISC ) {
> + 		/* a 'true' key event */
> + 		mouse_holdoff_last_jiffie = jiffies;
> + 	} else if ( EV_ABS == type || EV_REL == type || (EV_KEY == type && code >= BTN_MISC ) ) {
> + 		if ( jiffies - mouse_holdoff_last_jiffie < mouse_holdoff_jiffies )
> + 			return;
> + 		/* Note: we could lose mouse events when the jiffie counter rolls over... */
> + 	}
> +
>   	switch (type) {
>
>   		case EV_KEY:
> ***************
> *** 417,422 ****
> --- 435,470 ----
>   	devfs_unregister(handle);
>   }
>
> + #if defined(CONFIG_SYSCTL)
> +
> + static struct ctl_table_header *mouse_holdoff_header;
> +
> + static ctl_table mouse_holdoff_files[] =
> + {
> + 	{ 0xdead, "mouse_holdoff_ms",
> + 	  &mouse_holdoff_jiffies, sizeof(mouse_holdoff_jiffies),
> + 	  0666, NULL,
> + 	  proc_doulongvec_ms_jiffies_minmax, NULL, NULL,
> + 	  (void*)&mouse_holdoff_ms_min,
> + 	  (void*)&mouse_holdoff_ms_max
> + 	},
> + 	{ 0 }
> + };
> +
> + static ctl_table mouse_holdoff_input_dir[] =
> + {
> + 	{ 0xbeef, "input", NULL, 0, 0555, mouse_holdoff_files },
> + 	{ 0 }
> + };
> +
> + static ctl_table mouse_holdoff_root_dir[] =
> + {
> + 	{ CTL_DEV, "dev", NULL, 0, 0555, mouse_holdoff_input_dir },
> + 	{ 0 }
> + };
> +
> + #endif
> +
>   static int __init input_init(void)
>   {
>   	if (devfs_register_chrdev(INPUT_MAJOR, "input", &input_fops)) {
> ***************
> *** 424,434 ****
> --- 472,488 ----
>   		return -EBUSY;
>   	}
>   	input_devfs_handle = devfs_mk_dir(NULL, "input", NULL);
> + #if defined(CONFIG_SYSCTL)
> + 	mouse_holdoff_header = register_sysctl_table(mouse_holdoff_root_dir, 1);
> + #endif
>   	return 0;
>   }
>
>   static void __exit input_exit(void)
>   {
> + #if defined(CONFIG_SYSCTL)
> + 	unregister_sysctl_table(mouse_holdoff_header);
> + #endif
>   	devfs_unregister(input_devfs_handle);
>           if (devfs_unregister_chrdev(INPUT_MAJOR, "input"))
>                   printk(KERN_ERR "input: can't unregister char major %d", INPUT_MAJOR);


--
Vojtech Pavlik
SuSE Labs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
