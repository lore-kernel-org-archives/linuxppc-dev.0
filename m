Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 2FC9E688D6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 00:21:10 +1100 (EST)
Message-ID: <43A6B3C3.1080005@ru.mvista.com>
Date: Mon, 19 Dec 2005 16:21:07 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/3] ppc32: Make platform devices being able to assign
	functions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Implemented by  modification of the .name field of the platform device,
when PDs with the
same names are to be used within different drivers, as
<device_name> -> <device_name>:<function>
Corresponding drivers should change the .name in struct device_driver to
reflect upper of course.

Also helper platform_notify_map function added, making assignment of
board-specific platform_info more consistent and generic.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>


---

  arch/ppc/syslib/ppc_sys.c |  136 ++++++++++++++++++++++++++++++++++++++++++++-
  include/asm-ppc/mpc10x.h  |    1
  include/asm-ppc/mpc52xx.h |    1
  include/asm-ppc/mpc8260.h |    1
  include/asm-ppc/mpc83xx.h |    1
  include/asm-ppc/mpc85xx.h |    1
  include/asm-ppc/mpc8xx.h  |    1
  include/asm-ppc/ppc_sys.h |   24 ++++++++
  8 files changed, 164 insertions(+), 2 deletions(-)

applies-to: 4ce1b1890dc687cb1cf77f98e7a95b94c7ef3a93
a8450a334dc930d7284800c457d91ed55a1a3dd7
diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
index c0b93c4..26d2658 100644
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -15,11 +15,23 @@
   */

  #include <linux/string.h>
+#include <linux/bootmem.h>
  #include <asm/ppc_sys.h>

  int (*ppc_sys_device_fixup) (struct platform_device * pdev);

  static int ppc_sys_inited;
+static int ppc_sys_func_inited;
+
+static const char *ppc_sys_func_names[] = {
+	[FUNC_ENABLED] = "dummy",
+	[FUNC_ETH] = "eth",
+	[FUNC_UART] = "uart",
+	[FUNC_HLDC] = "hldc",
+	[FUNC_USB] = "usb",
+	[FUNC_IRDA] = "irda",
+	[FUNC_DISABLED] = "off",
+};

  void __init identify_ppc_sys_by_id(u32 id)
  {
@@ -38,13 +50,13 @@ void __init identify_ppc_sys_by_id(u32 i
  void __init identify_ppc_sys_by_name(char *name)
  {
  	unsigned int i = 0;
-	while (ppc_sys_specs[i].ppc_sys_name[0])
-	{
+	while (ppc_sys_specs[i].ppc_sys_name[0]) {
  		if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
  			break;
  		i++;
  	}
  	cur_ppc_sys_spec = &ppc_sys_specs[i];
+
  	return;
  }

@@ -128,6 +140,126 @@ void ppc_sys_device_remove(enum ppc_sys_
  	}
  }

+/* Platform-notify mapping
+ * Helper function for BSP code to assign board-specific platfom-divice bits
+ */
+
+void platform_notify_map(const struct platform_notify_dev_map *map,
+			 struct device *dev)
+{
+	struct platform_device *pdev;
+	int len, idx;
+	const char *s;
+
+	/* do nothing if no device or no bus_id */
+	if (!dev || !dev->bus_id)
+		return;
+
+	/* call per device map */
+	while (map->bus_id != NULL) {
+		idx = -1;
+		s = strrchr(dev->bus_id, '.');
+		if (s != NULL)
+			idx = (int)simple_strtol(s + 1, NULL, 10);
+		else
+			s = dev->bus_id + strlen(s);
+
+		len = s - dev->bus_id;
+
+		if (!strncmp(dev->bus_id, map->bus_id, len)) {
+			pdev = container_of(dev, struct platform_device, dev);
+			map->rtn(pdev, idx);
+		}
+		map++;
+	}
+}
+
+/*
+   Function assignment stuff.
+ Intended to work as follows:
+ the device name defined in foo_devices.c will be concatenated with :"func",
+ where func is string map of respective function from platfom_device_func enum
+
+ The FUNC_ENABLED function is intended to remove all assignments, making the device to appear
+ in platform bus with unmodified name.
+ */
+
+/*
+   Here we'll replace .name pointers with fixed-lenght strings
+   Hereby, this should be called *before* any func stuff triggeded.
+ */
+void ppc_sys_device_initfunc(void)
+{
+	int i;
+	const char *name;
+	static char new_names[NUM_PPC_SYS_DEVS][BUS_ID_SIZE];
+	enum ppc_sys_devices cur_dev;
+
+	/* If inited yet, do nothing */
+	if (ppc_sys_func_inited)
+		return;
+
+	for (i = 0; i < cur_ppc_sys_spec->num_devices; i++) {
+		if ((cur_dev = cur_ppc_sys_spec->device_list[i]) < 0)
+			continue;
+
+		if (ppc_sys_platform_devices[cur_dev].name) {
+			/*backup name */
+			name = ppc_sys_platform_devices[cur_dev].name;
+			strlcpy(new_names[i], name, BUS_ID_SIZE);
+			ppc_sys_platform_devices[cur_dev].name = new_names[i];
+		}
+	}
+
+	ppc_sys_func_inited = 1;
+}
+
+/*The "engine" of the func stuff. Here we either concat specified function string description
+ to the name, or remove it if FUNC_ENABLED parameter is passed here*/
+void ppc_sys_device_setfunc(enum ppc_sys_devices dev,
+			    enum platform_device_func func)
+{
+	char *s;
+	char *name = (char *)ppc_sys_platform_devices[dev].name;
+	char tmp[BUS_ID_SIZE];
+
+	if (!ppc_sys_func_inited) {
+		printk(KERN_ERR "Unable to alter function - not inited!\n");
+		return;
+	}
+
+	if (ppc_sys_inited) {
+		platform_device_unregister(&ppc_sys_platform_devices[dev]);
+	}
+
+	if ((s = (char *)strchr(name, ':')) != NULL) {	/* reassign */
+		/* Either change the name after ':' or remove func modifications */
+		if (func != FUNC_ENABLED)
+			strlcpy(s + 1, ppc_sys_func_names[func], BUS_ID_SIZE);
+		else
+			*s = 0;
+	} else if (func != FUNC_ENABLED) {
+		/* do assignment if it is not just "enable"  request */
+		sprintf(tmp, "%s:%s", name, ppc_sys_func_names[func]);
+		strlcpy(name, tmp, BUS_ID_SIZE);
+	}
+
+	if (ppc_sys_inited) {
+		platform_device_register(&ppc_sys_platform_devices[dev]);
+	}
+}
+
+void ppc_sys_device_set_func_all(enum platform_device_func func)
+{
+	enum ppc_sys_devices cur_dev;
+	int i;
+
+	for (i = 0; i < cur_ppc_sys_spec->num_devices; i++) {
+		cur_dev = cur_ppc_sys_spec->device_list[i];
+		ppc_sys_device_setfunc(cur_dev, func);
+	}
+}
+
  static int __init ppc_sys_init(void)
  {
  	unsigned int i, dev_id, ret = 0;
diff --git a/include/asm-ppc/mpc10x.h b/include/asm-ppc/mpc10x.h
index 77b1e09..976ad3d 100644
--- a/include/asm-ppc/mpc10x.h
+++ b/include/asm-ppc/mpc10x.h
@@ -165,6 +165,7 @@ enum ppc_sys_devices {
  	MPC10X_DMA1,
  	MPC10X_UART0,
  	MPC10X_UART1,
+	NUM_PPC_SYS_DEVS,
  };

  int mpc10x_bridge_init(struct pci_controller *hose,
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index e5f80c2..b2cb44f 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -49,6 +49,7 @@ enum ppc_sys_devices {
  	MPC52xx_ATA,
  	MPC52xx_I2C1,
  	MPC52xx_I2C2,
+	NUM_PPC_SYS_DEVS,
  };


diff --git a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
index 3214526..6ba69a8 100644
--- a/include/asm-ppc/mpc8260.h
+++ b/include/asm-ppc/mpc8260.h
@@ -83,6 +83,7 @@ enum ppc_sys_devices {
  	MPC82xx_CPM_SMC2,
  	MPC82xx_CPM_USB,
  	MPC82xx_SEC1,
+	NUM_PPC_SYS_DEVS,
  };

  #ifndef __ASSEMBLY__
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
index 7cdf60f..3c23fc4 100644
--- a/include/asm-ppc/mpc83xx.h
+++ b/include/asm-ppc/mpc83xx.h
@@ -108,6 +108,7 @@ enum ppc_sys_devices {
  	MPC83xx_USB2_DR,
  	MPC83xx_USB2_MPH,
  	MPC83xx_MDIO,
+	NUM_PPC_SYS_DEVS,
  };

  #endif /* CONFIG_83xx */
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
index 9d14bae..2a77884 100644
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
@@ -135,6 +135,7 @@ enum ppc_sys_devices {
  	MPC85xx_eTSEC4,
  	MPC85xx_IIC2,
  	MPC85xx_MDIO,
+	NUM_PPC_SYS_DEVS,
  };

  /* Internal interrupts are all Level Sensitive, and Positive Polarity */
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
index 46f159c..90e3d59 100644
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -111,6 +111,7 @@ enum ppc_sys_devices {
  	MPC8xx_CPM_SMC1,
  	MPC8xx_CPM_SMC2,
  	MPC8xx_CPM_USB,
+	NUM_PPC_SYS_DEVS,
  };

  #ifndef BOARD_CHIP_NAME
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index 83d8c77..76f259f 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -47,6 +47,21 @@ struct ppc_sys_spec {
  	enum ppc_sys_devices 	*device_list;
  };

+struct platform_notify_dev_map {
+	const char *bus_id;
+	void (*rtn)(struct platform_device * pdev, int idx);
+};
+
+enum platform_device_func {
+	FUNC_ENABLED = 0,
+	FUNC_ETH = 1,
+	FUNC_UART = 2,
+	FUNC_HLDC = 3,
+	FUNC_USB = 4,
+	FUNC_IRDA = 5,
+	FUNC_DISABLED = 6,
+};
+
  /* describes all specific chips and which devices they have on them */
  extern struct ppc_sys_spec ppc_sys_specs[];
  extern struct ppc_sys_spec *cur_ppc_sys_spec;
@@ -72,5 +87,14 @@ extern void *ppc_sys_get_pdata(enum ppc_
  /* remove a device from the system */
  extern void ppc_sys_device_remove(enum ppc_sys_devices dev);

+/*Function assignment stuff*/
+void ppc_sys_device_initfunc(void);
+void ppc_sys_device_setfunc(enum ppc_sys_devices dev,
+			    enum platform_device_func func);
+void ppc_sys_device_set_func_all(enum platform_device_func func);
+
+void platform_notify_map(const struct platform_notify_dev_map *map,
+			 struct device *dev);
+
  #endif				/* __ASM_PPC_SYS_H */
  #endif				/* __KERNEL__ */
---
Sincerely,
Vitaly
