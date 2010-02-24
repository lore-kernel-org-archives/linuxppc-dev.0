Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FFF2B7C48
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 13:49:27 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o1O2nMfW027225
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 20:49:23 -0600
Subject: [Fwd: [PATCH] windfarm: init sysfs attributes]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-MPH5QEcSSkVRLMyGVxh7"
Date: Wed, 24 Feb 2010 13:49:21 +1100
Message-ID: <1266979761.23523.1671.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-MPH5QEcSSkVRLMyGVxh7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-MPH5QEcSSkVRLMyGVxh7
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH] windfarm: init sysfs
 attributes
Content-Type: message/rfc822

Return-Path: <johannes@sipsolutions.net>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=5.0 tests=AWL,BAYES_40 autolearn=ham
 version=3.1.9
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217]) by
 gate.crashing.org (8.14.1/8.13.8) with ESMTP id o1KFhjpP028273 for
 <benh@kernel.crashing.org>; Sat, 20 Feb 2010 09:43:45 -0600
Received: by sipsolutions.net with esmtpsa
 (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71) (envelope-from
 <johannes@sipsolutions.net>) id 1NirTz-0003Zr-3f; Sat, 20 Feb 2010 16:43:03
 +0100
Subject: [PATCH] windfarm: init sysfs attributes
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <greg@kroah.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20100220154049.GM3000@hack>
References: <1266485543.6539.4.camel@jlt3.sipsolutions.net>
	 <2375c9f91002200126x22b262b3r8b9b58e3cee34077@mail.gmail.com>
	 <1266664814.11514.5.camel@jlt3.sipsolutions.net>
	 <20100220135122.GB3000@hack>
	 <1266674493.18465.9.camel@jlt3.sipsolutions.net>
	 <20100220150327.GG3000@hack>
	 <1266678496.32309.1.camel@jlt3.sipsolutions.net>
	 <20100220152010.GI3000@hack>
	 <1266679687.17363.1.camel@jlt3.sipsolutions.net>
	 <20100220154049.GM3000@hack>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 20 Feb 2010 16:43:02 +0100
Message-ID: <1266680582.17363.7.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.29.3.2 
Content-Transfer-Encoding: 7bit

This is required for lockdep.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 drivers/macintosh/windfarm_core.c         |    1 +
 drivers/macintosh/windfarm_smu_controls.c |    1 +

--- wireless-testing.orig/drivers/macintosh/windfarm_smu_controls.c	2010-02-20 16:05:55.738721565 +0100
+++ wireless-testing/drivers/macintosh/windfarm_smu_controls.c	2010-02-20 16:07:51.996717974 +0100
@@ -173,6 +173,7 @@ static struct smu_fan_control *smu_fan_c
 
 	fct->fan_type = pwm_fan;
 	fct->ctrl.type = pwm_fan ? WF_CONTROL_PWM_FAN : WF_CONTROL_RPM_FAN;
+	sysfs_attr_init(&fct->ctrl.attr.attr);
 
 	/* We use the name & location here the same way we do for SMU sensors,
 	 * see the comment in windfarm_smu_sensors.c. The locations are a bit
--- wireless-testing.orig/drivers/macintosh/windfarm_core.c	2010-02-20 16:15:14.701580166 +0100
+++ wireless-testing/drivers/macintosh/windfarm_core.c	2010-02-20 16:15:38.416369684 +0100
@@ -321,6 +321,7 @@ int wf_register_sensor(struct wf_sensor 
 	kref_init(&new_sr->ref);
 	list_add(&new_sr->link, &wf_sensors);
 
+	sysfs_attr_init(&new_sr->attr.attr);
 	new_sr->attr.attr.name = new_sr->name;
 	new_sr->attr.attr.mode = 0444;
 	new_sr->attr.show = wf_show_sensor;


--=-MPH5QEcSSkVRLMyGVxh7--
