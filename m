Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 98B38DDECF
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 13:39:42 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3830220wag.13
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 18:39:41 -0800 (PST)
Message-ID: <9e4733910712171839h214e0bc3q179266c86e5987b1@mail.gmail.com>
Date: Mon, 17 Dec 2007 21:39:37 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] update module-init-tools to support the i2c subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Follow on to: "Series to add device tree naming to i2c"
Teach module-init-tools about the i2c subsystem.

diff --git a/depmod.c b/depmod.c
index 0281c79..209eb0c 100644
--- a/depmod.c
+++ b/depmod.c
@@ -793,6 +793,7 @@ static struct depfile depfiles[] = {
 	{ "modules.inputmap", output_input_table },
 	{ "modules.ofmap", output_of_table },
 	{ "modules.seriomap", output_serio_table },
+	{ "modules.i2cmap", output_i2c_table },
 	{ "modules.alias", output_aliases },
 	{ "modules.symbols", output_symbols },
 };
diff --git a/depmod.h b/depmod.h
index 6cea36e..1040214 100644
--- a/depmod.h
+++ b/depmod.h
@@ -55,6 +55,8 @@ struct module
 	unsigned int input_table_size;
 	unsigned int serio_size;
 	void *serio_table;
+	unsigned int i2c_size;
+	void *i2c_table;
 	unsigned int of_size;
 	void *of_table;

diff --git a/moduleops_core.c b/moduleops_core.c
index 56c85d3..a7ca350 100644
--- a/moduleops_core.c
+++ b/moduleops_core.c
@@ -230,6 +230,11 @@ static void PERBIT(fetch_tables)(struct module *module)
 					"__mod_serio_device_table",
 					NULL, module->conv);

+	module->i2c_size = PERBIT(I2C_DEVICE_SIZE);
+	module->i2c_table = PERBIT(deref_sym)(module->data,
+					"__mod_i2c_device_table",
+					NULL, module->conv);
+
 	module->of_size = PERBIT(OF_DEVICE_SIZE);
 	module->of_table = PERBIT(deref_sym)(module->data,
 					"__mod_of_device_table",
diff --git a/tables.c b/tables.c
index 6dfd165..82e162d 100644
--- a/tables.c
+++ b/tables.c
@@ -496,6 +496,35 @@ void output_serio_table(struct module *modules, FILE *out)
 }


+static void output_i2c_entry(struct i2c_device_id *i2c, char *name, FILE *out)
+{
+	fprintf(out,
+		"%-20s %-20s\n",
+		name,
+		i2c->name);
+}
+
+
+void output_i2c_table(struct module *modules, FILE *out)
+{
+	struct module *i;
+
+	fprintf(out, "# i2c module         name\n");
+
+	for (i = modules; i; i = i->next) {
+		struct i2c_device_id *e;
+		char shortname[strlen(i->pathname) + 1];
+
+		if (!i->i2c_table)
+			continue;
+
+		make_shortname(shortname, i->pathname);
+		for (e = i->i2c_table; e->name[0]; e = (void *)e + i->i2c_size)
+			output_i2c_entry(e, shortname, out);
+	}
+}
+
+
 static void
 strip_whitespace (char *str, char chr)
 {
diff --git a/tables.h b/tables.h
index e5f6f35..263369d 100644
--- a/tables.h
+++ b/tables.h
@@ -164,6 +164,12 @@ struct serio_device_id {
 #define SERIO_DEVICE_SIZE32 (4 * 1)
 #define SERIO_DEVICE_SIZE64 (4 * 1 + 4)

+struct i2c_device_id {
+	char name[48];
+};
+#define I2C_DEVICE_SIZE32 (48 + 4)
+#define I2C_DEVICE_SIZE64 (48 + 8)
+
 struct of_device_id {
 	char name[32];
 	char type[32];
@@ -182,6 +188,7 @@ void output_ccw_table(struct module *modules, FILE *out);
 void output_isapnp_table(struct module *modules, FILE *out);
 void output_input_table(struct module *modules, FILE *out);
 void output_serio_table(struct module *modules, FILE *out);
+void output_i2c_table(struct module *modules, FILE *out);
 void output_of_table(struct module *modules, FILE *out);

 #endif /* MODINITTOOLS_TABLES_H */

-- 
Jon Smirl
jonsmirl@gmail.com
