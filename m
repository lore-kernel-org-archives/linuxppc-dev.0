Message-ID: <3C5A74FB.5010104@pacbell.net>
Date: Fri, 01 Feb 2002 10:59:07 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: 4xx ocp proc_fs & pm
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I would like to add the ability of the ocp devices to provide a way to
supply device information to users and to expand the power management of
these devices through the proc file system.

I have modeled the proc file system after the pci proc and pci pm
implimentations.  Each driver would register a driver struct via a
ocp_register.

struct ocp_driver {
	struct list_head global_list;
	char name[16];
	u16  num;
	enum ocp_type type;		/* OCP device type */
	u16 irq;
	u32 base_addr;
         void		*driver_data;	/* data private to the driver */
#if defined(CONFIG_PM)
	u32             current_state;  /* Current operating state /*
	int  (*save_state) ( u32 state);    /* Save Device Context */
	int  (*suspend)( u32 state);	/* Device suspended */
	int  (*resume) (u32 state);	/* Device woken up */
	int  (*enable_wake) (u32 state, int enable);   /* Enable wake event */
#endif
#if defined(CONFIG_PROC_FS)
	struct proc_dir_entry *procdir;	/* dir entry in /proc/bus */
	struct proc_dir_entry *procent;	/* device entry in /proc/bus/ocp */
#endif
};

With the type  field, I can customize how data is read & written to the
proc entries. So for the ethernet driver I can provide additional values
for the nubmer of buffers so it can be tweek w/o recompiling.  Also the
type field could allow me to incorperate the other device registration
calls so there would only be one registration call in the module_init().

There will be a an entry under /proc/bus/ocp with an entry
for each ocp device and an acsii version containing all devices in
/bus/ocp/devices.

With a proc_fs , I can expand the power management support for the ocp
devices.

I do have a basic proc working.

I would like some feedback.

regards,

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
