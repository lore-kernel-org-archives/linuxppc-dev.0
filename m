Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 99C5F6895C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 07:04:34 +1100 (EST)
Message-ID: <43B2EFD0.4010709@ru.mvista.com>
Date: Wed, 28 Dec 2005 23:04:32 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/2] ppc32: Make platform devices being able to assign
 functions (resend)
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

 arch/ppc/syslib/ppc_sys.c |  165 ++++++++++++++++++++++++++++++++++++++++++++-
 include/asm-ppc/mpc10x.h  |    1 
 include/asm-ppc/mpc52xx.h |    1 
 include/asm-ppc/mpc8260.h |    1 
 include/asm-ppc/mpc83xx.h |    1 
 include/asm-ppc/mpc85xx.h |    1 
 include/asm-ppc/mpc8xx.h  |    1 
 include/asm-ppc/ppc_sys.h |   26 +++++++
 8 files changed, 194 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
index c0b93c4..e3856e7 100644
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -15,11 +15,22 @@
  */
 
 #include <linux/string.h>
+#include <linux/bootmem.h>
 #include <asm/ppc_sys.h>
 
 int (*ppc_sys_device_fixup) (struct platform_device * pdev);
 
 static int ppc_sys_inited;
+static int ppc_sys_func_inited;
+
+static const char *ppc_sys_func_names[] = {
+	[PPC_SYS_FUNC_DUMMY] = "dummy",
+	[PPC_SYS_FUNC_ETH] = "eth",
+	[PPC_SYS_FUNC_UART] = "uart",
+	[PPC_SYS_FUNC_HLDC] = "hldc",
+	[PPC_SYS_FUNC_USB] = "usb",
+	[PPC_SYS_FUNC_IRDA] = "irda",
+};
 
 void __init identify_ppc_sys_by_id(u32 id)
 {
@@ -38,13 +49,13 @@ void __init identify_ppc_sys_by_id(u32 i
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
 
@@ -128,6 +139,153 @@ void ppc_sys_device_remove(enum ppc_sys_
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
+			s = dev->bus_id;
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
+ The PPC_SYS_FUNC_DUMMY function is intended to remove all assignments, making the device to appear
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
+ to the name, or remove it if PPC_SYS_FUNC_DUMMY parameter is passed here*/
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
+		if (func != PPC_SYS_FUNC_DUMMY)
+			strlcpy(s + 1, ppc_sys_func_names[func], BUS_ID_SIZE);
+		else
+			*s = 0;
+	} else if (func != PPC_SYS_FUNC_DUMMY) {
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
+void ppc_sys_device_disable(enum ppc_sys_devices dev)
+{
+	BUG_ON(cur_ppc_sys_spec == NULL);
+
+	/*Check if it is enabled*/
+	if(cur_ppc_sys_spec->config[dev] & PPC_SYS_CONFIG_ENABED) {
+		if (ppc_sys_inited) {
+			platform_device_unregister(&ppc_sys_platform_devices[dev]);
+		}
+		cur_ppc_sys_spec->config[dev] &= ~PPC_SYS_CONFIG_ENABED;
+	}
+}
+
+void ppc_sys_device_enable(enum ppc_sys_devices dev)
+{
+	BUG_ON(cur_ppc_sys_spec == NULL);
+	
+	/*Check if it is disabled*/
+	if(!(cur_ppc_sys_spec->config[dev] & PPC_SYS_CONFIG_ENABED)) {
+		if (ppc_sys_inited) {
+			platform_device_register(&ppc_sys_platform_devices[dev]);
+		}
+		cur_ppc_sys_spec->config[dev] |= PPC_SYS_CONFIG_ENABED;
+	}
+
+}
+
+void ppc_sys_device_enable_all(enum platform_device_func func)
+{
+	enum ppc_sys_devices cur_dev;
+	int i;
+
+	for (i = 0; i < cur_ppc_sys_spec->num_devices; i++) {
+		cur_dev = cur_ppc_sys_spec->device_list[i];
+		ppc_sys_device_enable(cur_dev);
+	}
+}
+
 static int __init ppc_sys_init(void)
 {
 	unsigned int i, dev_id, ret = 0;
@@ -136,7 +294,8 @@ static int __init ppc_sys_init(void)
 
 	for (i = 0; i < cur_ppc_sys_spec->num_devices; i++) {
 		dev_id = cur_ppc_sys_spec->device_list[i];
-		if (dev_id != -1) {
+		if ((dev_id != -1) || 
+		(cur_ppc_sys_spec->config[dev_id] & PPC_SYS_CONFIG_ENABED)) {
 			if (ppc_sys_device_fixup != NULL)
 				ppc_sys_device_fixup(&ppc_sys_platform_devices
 						     [dev_id]);
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
index 83d8c77..e6f83ad 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -44,9 +44,26 @@ struct ppc_sys_spec {
 	u32 			value;
 	u32 			num_devices;
 	char 			*ppc_sys_name;
+	u8			config[NUM_PPC_SYS_DEVS];
 	enum ppc_sys_devices 	*device_list;
 };
 
+struct platform_notify_dev_map {
+	const char *bus_id;
+	void (*rtn)(struct platform_device * pdev, int idx);
+};
+
+enum platform_device_func {
+	PPC_SYS_FUNC_DUMMY = 0,
+	PPC_SYS_FUNC_ETH = 1,
+	PPC_SYS_FUNC_UART = 2,
+	PPC_SYS_FUNC_HLDC = 3,
+	PPC_SYS_FUNC_USB = 4,
+	PPC_SYS_FUNC_IRDA = 5,
+};
+
+#define PPC_SYS_CONFIG_ENABED		1
+
 /* describes all specific chips and which devices they have on them */
 extern struct ppc_sys_spec ppc_sys_specs[];
 extern struct ppc_sys_spec *cur_ppc_sys_spec;
@@ -72,5 +89,14 @@ extern void *ppc_sys_get_pdata(enum ppc_
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
