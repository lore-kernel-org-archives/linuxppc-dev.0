Return-Path: <groeck@redback.com>
Received: from imr3.ericy.com (imr3.ericy.com [198.24.6.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82B4E1007D2
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 15:42:14 +1000 (EST)
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: "James E.J. Bottomley" <James.Bottomley@suse.de>,
	Richard Purdie <rpurdie@rpsys.net>, Greg Kroah-Hartman <gregkh@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/6] leds: Remove owner field from attribute initialization in
	bd2802 driver
Date: Wed, 28 Jul 2010 22:09:23 -0700
Message-ID: <1280380166-29196-4-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
References: <1280380166-29196-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Guenter Roeck <guenter.roeck@ericsson.com>,
	Nick Cheng <nick.cheng@areca.com.tw>,
	Linus Walleij <linus.walleij@stericsson.com>,
	James Smart <james.smart@emulex.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@aristanetworks.com>,
	Dmitry Torokhov <dtor@mail.ru>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
	Tejun Heo <tj@kernel.org>, Alex Iannicelli <alex.iannicelli@emulex.com>,
	Jani Nikula <ext-jani.1.nikula@nokia.com>,
	Jean Delvare <khali@linux-fr.org>,
	Benjamin Thery <benjamin.thery@bull.net>,
	linux-scsi@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/leds/leds-bd2802.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-bd2802.c b/drivers/leds/leds-bd2802.c
index 5dcdf9d..19dc4b6 100644
--- a/drivers/leds/leds-bd2802.c
+++ b/drivers/leds/leds-bd2802.c
@@ -351,7 +351,7 @@ static ssize_t bd2802_store_reg##reg_addr(struct device *dev,		\
 	return count;							\
 }									\
 static struct device_attribute bd2802_reg##reg_addr##_attr = {		\
-	.attr = {.name = reg_name, .mode = 0644, .owner = THIS_MODULE},	\
+	.attr = {.name = reg_name, .mode = 0644},			\
 	.store = bd2802_store_reg##reg_addr,				\
 };
 
@@ -482,7 +482,6 @@ static struct device_attribute bd2802_adv_conf_attr = {
 	.attr = {
 		.name = "advanced_configuration",
 		.mode = 0644,
-		.owner = THIS_MODULE
 	},
 	.show = bd2802_show_adv_conf,
 	.store = bd2802_store_adv_conf,
@@ -519,7 +518,6 @@ static struct device_attribute bd2802_##attr_name##_attr = {		\
 	.attr = {							\
 		.name = name_str,					\
 		.mode = 0644,						\
-		.owner = THIS_MODULE					\
 	},								\
 	.show = bd2802_show_##attr_name,				\
 	.store = bd2802_store_##attr_name,				\
-- 
1.7.0.87.g0901d
