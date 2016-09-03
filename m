Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQxTc5HfjzDrht
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 10:20:20 +1000 (AEST)
Date: Sat, 3 Sep 2016 02:20:14 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, Felix Fietkau <nbd@nbd.name>,
 David Woodhouse <dwmw2@infradead.org>, Roman Pen <r.peniaev@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Ming Lei <ming.lei@canonical.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Vikram Mulukutla <markivx@codeaurora.org>,
 Stephen Boyd <stephen.boyd@linaro.org>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian Lamparter <chunkeey@googlemail.com>, hauke@hauke-m.de,
 Josh Boyer <jwboyer@fedoraproject.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, jslaby@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Wu Fengguang <fengguang.wu@intel.com>, rpurdie@rpsys.net,
 Jeff Mahoney <jeffm@suse.com>, j.anaszewski@samsung.com,
 Abhay_Salunke@dell.com, Julia Lawall <Julia.Lawall@lip6.fr>,
 Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
 Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
 David Howells <dhowells@redhat.com>, Alessandro Rubini <rubini@gnudd.com>,
 Kevin Cernekee <cernekee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Thierry Martinez <martinez@nsup.org>, cocci@systeme.lip6.fr,
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC] fs: add userspace critical mounts event support
Message-ID: <20160903002014.GP3296@wotan.suse.de>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de>
 <20160902235916.GO3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160902235916.GO3296@wotan.suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel_read_file_from_path() can try to read a file from
the system's filesystem. This is typically done for firmware
for instance, which lives in /lib/firmware. One issue with
this is that the kernel cannot know for sure when the real
final /lib/firmare/ is ready, and even if you use initramfs
drivers are currently initialized *first* prior to the initramfs
kicking off. During init we run through all init calls first
(do_initcalls()) and finally the initramfs is processed via
prepare_namespace():

do_basic_setup() {
   ...
   driver_init();
   ...
   do_initcalls();
   ...
}

kernel_init_freeable() {
   ...
   do_basic_setup();
   ...
   if (sys_access((const char __user *) ramdisk_execute_command, 0) != 0) {
      ramdisk_execute_command = NULL;
      prepare_namespace();
   }
}

This leaves a possible race between loading drivers and any uses
of kernel_read_file_from_path(). Because pivot_root() can be used,
this allows userspace further possibilities in terms of defining
when a kernel critical filesystem should be ready by.

We define kernel critical filesystems as filesystems which the
kernel needs for kernel_read_file_from_path(). Since only userspace
can know when kernel critical filesystems are mounted and ready,
let userspace notify the kernel of this, and enable a new kernel
configuration which lets the kernel wait for this event before
enabling reads from kernel_read_file_from_path().

A default timeout of 10s is used for now. You can override this
through the kernel-parameters using critical_mounts_timeout_ms=T
where T is in ms. cat /sys/kernel/critical_mounts_timeout_ms the
current system value.

When userspace is ready it can simply:

  echo 1 > /sys/kernel/critical_mounts_ready

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---

Note, this still leaves the puzzle of the fact that initramfs may carry
some firmware, and some drivers may be OK in using firmware from there,
the wait stuff would just get in the way. To address this I think can
perhaps instead check *one* for the file, and if its present immediately
give it back, we'd only resort to the wait in cases of failure.

Another thing -- other than firmware we have:

security/integrity/ima/ima_fs.c:        rc = kernel_read_file_from_path(path, &data, &size, 0, READING_POLICY);
sound/oss/sound_firmware.h:     err = kernel_read_file_from_path((char *)fn, (void **)fp, &size,

What paths are these? So we can document the current uses in the Kconfig
at least.

Thoughts ?

 Documentation/kernel-parameters.txt |  6 +++
 drivers/base/Kconfig                | 48 +++++++++++++++++++++++
 fs/exec.c                           |  3 ++
 include/linux/fs.h                  |  8 ++++
 kernel/ksysfs.c                     | 77 +++++++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 8ccacc44622a..1af89faa9fc9 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -849,6 +849,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 
+	critical_mounts_timeout_ms=T	[KNL] timeout in ms
+			Format: <integer>
+			Use this to override the kernel's default timeout for
+			waiting for critical system mount points to become
+			available.
+
 	cryptomgr.notests
                         [KNL] Disable crypto self-tests
 
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 12b4f5551501..21576c0a4898 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -25,6 +25,54 @@ config UEVENT_HELPER_PATH
 	  via /proc/sys/kernel/hotplug or via /sys/kernel/uevent_helper
 	  later at runtime.
 
+config CRITICAL_MOUNTS_WAIT
+	bool "Enable waiting for critical-filesystems-ready notification"
+	default n
+	help
+	  Kernel subsystems and device drivers often need to read files
+	  from the filesystem, however in doing this races are possible at
+	  bootup -- the subsystem requesting the file might look for it in /
+	  early in boot, but if we haven't yet mounted the real root
+	  filesystem we'll just tell the subsystem the file is not present and
+	  it will fail. Furthermore what path to the filesystem is used varies
+	  depending on the subsystem. To help the kernel we provide the option
+	  to let the kernel wait for all critical filesystems to mounted and
+	  ready before letting the kernel start trying to read files from the
+	  systems' filesystem. Since pivot_root() can be used and therefore a
+	  system might be configured to change its / filesystem at bootup as
+	  many times as it wishes, only userspace can realy know exactly when
+	  all critical filesystems are ready. Enabling this lets userspace
+	  communicate to the kernel when all critical filesystems are ready.
+
+	  What are the critical filesystems are obviously system specific, but
+	  examples of some are:
+
+	    o /lib/firmware/
+	    o /etc/XXX/
+
+	  If you enable this you must have a userspace init script or tool
+	  which will vet to ensure all critical filesystems are ready, once
+	  they are all ready it will inform the kenrel by setting the file
+	  /sys/kernel/critical_mounts_ready to 1.
+
+	  The kernel will wait by default 10 seconds for the event, if the
+	  the timeout is reached, it will proceed to just try to enable
+	  reading of the files from the kernel but warn.
+
+	  If not sure say "no" for now. You need proper userpace implementation
+	  for this.
+
+config CRITICAL_MOUNTS_WAIT_TIMEOUT
+	int "Timeout for critical-fs-reayd notification in miliseconds"
+	depends on CRITICAL_MOUNTS_WAIT
+	default 10000
+	help
+	  Defines the timeout for the kernel to wait for critical filesystems
+	  to be loaded. This if system specific as only the system will know
+	  exaclty when how long this typically takes. By default this is
+	  10 seconds. You can override at boot time by using the kernel
+	  parameter critical_mounts_timeout_ms.
+
 config DEVTMPFS
 	bool "Maintain a devtmpfs filesystem to mount at /dev"
 	help
diff --git a/fs/exec.c b/fs/exec.c
index 6fcfb3f7b137..0d46ad4aad11 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -57,6 +57,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/vmalloc.h>
+#include <linux/swait.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -949,6 +950,8 @@ int kernel_read_file_from_path(char *path, void **buf, loff_t *size,
 	struct file *file;
 	int ret;
 
+	wait_for_critical_mounts(id);
+
 	if (!path || !*path)
 		return -EINVAL;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bd57feb7cf37..f59213ac8a8b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3202,4 +3202,12 @@ static inline bool dir_relax_shared(struct inode *inode)
 extern bool path_noexec(const struct path *path);
 extern void inode_nohighmem(struct inode *inode);
 
+#ifdef CONFIG_CRITICAL_MOUNTS_WAIT
+void wait_for_critical_mounts(enum kernel_read_file_id id);
+#else
+static inline void wait_for_critical_mounts(enum kernel_read_file_id id)
+{
+}
+#endif /* CONFIG_CRITICAL_MOUNTS_WAIT */
+
 #endif /* _LINUX_FS_H */
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index ee1bc1bb8feb..232af58d8760 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -21,6 +21,7 @@
 #include <linux/compiler.h>
 
 #include <linux/rcupdate.h>	/* rcu_expedited and rcu_normal */
+#include <linux/swait.h>
 
 #define KERNEL_ATTR_RO(_name) \
 static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
@@ -180,6 +181,78 @@ static ssize_t rcu_normal_store(struct kobject *kobj,
 KERNEL_ATTR_RW(rcu_normal);
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+#ifdef CONFIG_CRITICAL_MOUNTS_WAIT
+static int are_critical_mounts_ready;
+
+static DECLARE_SWAIT_QUEUE_HEAD(critical_wq);
+static int critical_mounts_timeout_ms = CONFIG_CRITICAL_MOUNTS_WAIT_TIMEOUT;
+
+core_param(critical_mounts_timeout_ms, critical_mounts_timeout_ms, int, 0644);
+
+static bool critical_mounts_ready(void)
+{
+	return !!are_critical_mounts_ready;
+}
+
+
+static void __wait_for_critical_mounts(void)
+{
+	int ret;
+	struct swait_queue_head *wq = &critical_wq;
+
+	pr_debug("Waiting for critical filesystems...\n");
+	ret = swait_event_interruptible_timeout(*wq, critical_mounts_ready(),
+						msecs_to_jiffies(critical_mounts_timeout_ms));
+	if (ret > 0)
+		return;
+
+	WARN_ON(ret < 0);
+}
+static ssize_t critical_mounts_ready_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	return sprintf(buf, "%d\n", critical_mounts_ready());
+}
+static ssize_t critical_mounts_ready_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	if (kstrtoint(buf, 0, &are_critical_mounts_ready))
+		return -EINVAL;
+
+	return count;
+}
+KERNEL_ATTR_RW(critical_mounts_ready);
+
+static ssize_t critical_mounts_timeout_ms_show(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       char *buf)
+{
+	return sprintf(buf, "%d\n", critical_mounts_timeout_ms);
+}
+KERNEL_ATTR_RO(critical_mounts_timeout_ms);
+
+void wait_for_critical_mounts(enum kernel_read_file_id id)
+{
+	switch (id) {
+	case READING_FIRMWARE:
+	case READING_FIRMWARE_PREALLOC_BUFFER:
+	case READING_POLICY:
+		if (!critical_mounts_ready()) {
+			pr_info("Waiting for critical filesystems...\n");
+			__wait_for_critical_mounts();
+		}
+		else
+			pr_info("All critical filesystems are ready!\n");
+		break;
+	default:
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(wait_for_critical_mounts);
+#endif /* CONFIG_CRITICAL_MOUNTS_WAIT */
+
 /*
  * Make /sys/kernel/notes give the raw contents of our kernel .notes section.
  */
@@ -225,6 +298,10 @@ static struct attribute * kernel_attrs[] = {
 	&rcu_expedited_attr.attr,
 	&rcu_normal_attr.attr,
 #endif
+#ifdef CONFIG_CRITICAL_MOUNTS_WAIT
+	&critical_mounts_ready_attr.attr,
+	&critical_mounts_timeout_ms_attr.attr,
+#endif
 	NULL
 };
 
-- 
2.9.2
