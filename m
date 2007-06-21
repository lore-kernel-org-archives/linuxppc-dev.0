Return-Path: <krafft@de.ibm.com>
Date: Thu, 21 Jun 2007 13:16:44 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: [patch 1/5] cell: pmi remove support for mutiple devices.
Message-ID: <20070621131644.03a8ec31@localhost>
In-Reply-To: <20070621130944.083f8fa5@localhost>
References: <20070621130944.083f8fa5@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_Zft7Y4AhQj2RL4O7/.sSNyf";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_Zft7Y4AhQj2RL4O7/.sSNyf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

From: Christian Krafft <krafft@de.ibm.com>

The pmi driver got simplified by removing support for multiple devices.
As there is no more than one pmi device per maschine, there is no need to
specify the device for listening and sending messages.

This way the caller (cbe_cpufreq) doesn't need to scan the device tree.
When registering the handler on a board without a pmi
interface, pmi.c will just return -ENODEV.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -68,12 +68,14 @@ static u64 MIC_Slow_Next_Timer_table[] =3D
 };
=20
 static unsigned int pmi_frequency_limit =3D 0;
+
 /*
  * hardware specific functions
  */
=20
-static struct of_device *pmi_dev;
+static bool cbe_cpufreq_has_pmi;
=20
+#ifdef CONFIG_PPC_PMI
 static int set_pmode_pmi(int cpu, unsigned int pmode)
 {
 	int ret;
@@ -90,7 +92,7 @@ static int set_pmode_pmi(int cpu, unsign
 	time =3D (u64) get_cycles();
 #endif
=20
-	pmi_send_message(pmi_dev, pmi_msg);
+	pmi_send_message(pmi_msg);
 	ret =3D pmi_msg.data2;
=20
 	pr_debug("PMI returned slow mode %d\n", ret);
@@ -102,7 +104,7 @@ static int set_pmode_pmi(int cpu, unsign
 #endif
 	return ret;
 }
-
+#endif
=20
 static int get_pmode(int cpu)
 {
@@ -156,14 +158,16 @@ static int set_pmode_reg(int cpu, unsign
 	return 0;
 }
=20
-static int set_pmode(int cpu, unsigned int slow_mode) {
-	if (pmi_dev)
+static int set_pmode(int cpu, unsigned int slow_mode)
+{
+#ifdef CONFIG_PPC_PMI
+	if (cbe_cpufreq_has_pmi)
 		return set_pmode_pmi(cpu, slow_mode);
-	else
-		return set_pmode_reg(cpu, slow_mode);
+#endif
+	return set_pmode_reg(cpu, slow_mode);
 }
=20
-static void cbe_cpufreq_handle_pmi(struct of_device *dev, pmi_message_t pm=
i_msg)
+static void cbe_cpufreq_handle_pmi(pmi_message_t pmi_msg)
 {
 	u8 cpu;
 	u8 cbe_pmode_new;
@@ -250,7 +254,7 @@ static int cbe_cpufreq_cpu_init(struct c
=20
 	cpufreq_frequency_table_get_attr(cbe_freqs, policy->cpu);
=20
-	if (pmi_dev) {
+	if (cbe_cpufreq_has_pmi) {
 		/* frequency might get limited later, initialize limit with max_freq */
 		pmi_frequency_limit =3D max_freq;
 		cpufreq_register_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER);
@@ -262,7 +266,7 @@ static int cbe_cpufreq_cpu_init(struct c
=20
 static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	if (pmi_dev)
+	if (cbe_cpufreq_has_pmi)
 		cpufreq_unregister_notifier(&pmi_notifier_block, CPUFREQ_POLICY_NOTIFIER=
);
=20
 	cpufreq_frequency_table_put_attr(policy->cpu);
@@ -323,27 +327,20 @@ static struct cpufreq_driver cbe_cpufreq
=20
 static int __init cbe_cpufreq_init(void)
 {
-	struct device_node *np;
-
 	if (!machine_is(cell))
 		return -ENODEV;
=20
-	np =3D of_find_node_by_type(NULL, "ibm,pmi");
-
-	pmi_dev =3D of_find_device_by_node(np);
-
-	if (pmi_dev)
-		pmi_register_handler(pmi_dev, &cbe_pmi_handler);
+	cbe_cpufreq_has_pmi =3D pmi_register_handler(&cbe_pmi_handler) =3D=3D 0;
=20
 	return cpufreq_register_driver(&cbe_cpufreq_driver);
 }
=20
 static void __exit cbe_cpufreq_exit(void)
 {
-	if (pmi_dev)
-		pmi_unregister_handler(pmi_dev, &cbe_pmi_handler);
-
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
+
+	if (cbe_cpufreq_has_pmi)
+		pmi_unregister_handler(&cbe_pmi_handler);
 }
=20
 module_init(cbe_cpufreq_init);
Index: linux/arch/powerpc/sysdev/pmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/sysdev/pmi.c
+++ linux/arch/powerpc/sysdev/pmi.c
@@ -48,15 +48,13 @@ struct pmi_data {
 	struct work_struct	work;
 };
=20
+static struct pmi_data *data;
=20
 static int pmi_irq_handler(int irq, void *dev_id)
 {
-	struct pmi_data *data;
 	u8 type;
 	int rc;
=20
-	data =3D dev_id;
-
 	spin_lock(&data->pmi_spinlock);
=20
 	type =3D ioread8(data->pmi_reg + PMI_READ_TYPE);
@@ -111,16 +109,13 @@ MODULE_DEVICE_TABLE(of, pmi_match);
=20
 static void pmi_notify_handlers(struct work_struct *work)
 {
-	struct pmi_data *data;
 	struct pmi_handler *handler;
=20
-	data =3D container_of(work, struct pmi_data, work);
-
 	spin_lock(&data->handler_spinlock);
 	list_for_each_entry(handler, &data->handler, node) {
 		pr_debug(KERN_INFO "pmi: notifying handler %p\n", handler);
 		if (handler->type =3D=3D data->msg.type)
-			handler->handle_pmi_message(data->dev, data->msg);
+			handler->handle_pmi_message(data->msg);
 	}
 	spin_unlock(&data->handler_spinlock);
 }
@@ -129,9 +124,14 @@ static int pmi_of_probe(struct of_device
 			const struct of_device_id *match)
 {
 	struct device_node *np =3D dev->node;
-	struct pmi_data *data;
 	int rc;
=20
+	if (data) {
+		printk(KERN_ERR "pmi: driver has already been initialized.\n");
+		rc =3D -EBUSY;
+		goto out;
+	}
+
 	data =3D kzalloc(sizeof(struct pmi_data), GFP_KERNEL);
 	if (!data) {
 		printk(KERN_ERR "pmi: could not allocate memory.\n");
@@ -154,7 +154,6 @@ static int pmi_of_probe(struct of_device
=20
 	INIT_WORK(&data->work, pmi_notify_handlers);
=20
-	dev->dev.driver_data =3D data;
 	data->dev =3D dev;
=20
 	data->irq =3D irq_of_parse_and_map(np, 0);
@@ -164,7 +163,7 @@ static int pmi_of_probe(struct of_device
 		goto error_cleanup_iomap;
 	}
=20
-	rc =3D request_irq(data->irq, pmi_irq_handler, 0, "pmi", data);
+	rc =3D request_irq(data->irq, pmi_irq_handler, 0, "pmi", NULL);
 	if (rc) {
 		printk(KERN_ERR "pmi: can't request IRQ %d: returned %d\n",
 				data->irq, rc);
@@ -187,11 +186,8 @@ out:
=20
 static int pmi_of_remove(struct of_device *dev)
 {
-	struct pmi_data *data;
 	struct pmi_handler *handler, *tmp;
=20
-	data =3D dev->dev.driver_data;
-
 	free_irq(data->irq, data);
 	iounmap(data->pmi_reg);
=20
@@ -202,7 +198,7 @@ static int pmi_of_remove(struct of_devic
=20
 	spin_unlock(&data->handler_spinlock);
=20
-	kfree(dev->dev.driver_data);
+	kfree(data);
=20
 	return 0;
 }
@@ -226,13 +222,13 @@ static void __exit pmi_module_exit(void)
 }
 module_exit(pmi_module_exit);
=20
-void pmi_send_message(struct of_device *device, pmi_message_t msg)
+int pmi_send_message(pmi_message_t msg)
 {
-	struct pmi_data *data;
 	unsigned long flags;
 	DECLARE_COMPLETION_ONSTACK(completion);
=20
-	data =3D device->dev.driver_data;
+	if (!data)
+		return -ENODEV;
=20
 	mutex_lock(&data->msg_mutex);
=20
@@ -256,30 +252,26 @@ void pmi_send_message(struct of_device *
 	data->completion =3D NULL;
=20
 	mutex_unlock(&data->msg_mutex);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pmi_send_message);
=20
-void pmi_register_handler(struct of_device *device,
-			  struct pmi_handler *handler)
+int pmi_register_handler(struct pmi_handler *handler)
 {
-	struct pmi_data *data;
-	data =3D device->dev.driver_data;
-
 	if (!data)
-		return;
+		return -ENODEV;
=20
 	spin_lock(&data->handler_spinlock);
 	list_add_tail(&handler->node, &data->handler);
 	spin_unlock(&data->handler_spinlock);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pmi_register_handler);
=20
-void pmi_unregister_handler(struct of_device *device,
-			    struct pmi_handler *handler)
+void pmi_unregister_handler(struct pmi_handler *handler)
 {
-	struct pmi_data *data;
-	data =3D device->dev.driver_data;
-
 	if (!data)
 		return;
=20
Index: linux/include/asm-powerpc/pmi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/asm-powerpc/pmi.h
+++ linux/include/asm-powerpc/pmi.h
@@ -55,13 +55,13 @@ typedef struct {
 struct pmi_handler {
 	struct list_head node;
 	u8 type;
-	void (*handle_pmi_message) (struct of_device *, pmi_message_t);
+	void (*handle_pmi_message) (pmi_message_t);
 };
=20
-void pmi_register_handler(struct of_device *, struct pmi_handler *);
-void pmi_unregister_handler(struct of_device *, struct pmi_handler *);
+int pmi_register_handler(struct pmi_handler *);
+void pmi_unregister_handler(struct pmi_handler *);
=20
-void pmi_send_message(struct of_device *, pmi_message_t);
+int pmi_send_message(pmi_message_t);
=20
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PMI_H */

--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_Zft7Y4AhQj2RL4O7/.sSNyf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGel4k6rqK4qDx+dcRAhadAJ9VWEc4HB20UBzLpCGk7c7OFBnrNgCfdCaZ
z8Tohpb9q94pybOjv5kNz0s=
=6D6n
-----END PGP SIGNATURE-----

--Sig_Zft7Y4AhQj2RL4O7/.sSNyf--
