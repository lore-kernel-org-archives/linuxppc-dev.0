Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAC2C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:36:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA9C2084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsVsUpDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA9C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKHg6YhLzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:36:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JsVsUpDo"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YK8V0FblzDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:30:34 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id y3so6004807pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D3TIN7GVmzZf2vc4K8K5AuMdS/7XAlZhj8cjpR6bpjs=;
 b=JsVsUpDoZ8mC7tNQGcsRzmeEU0alBBVqm5MslrRSC6T2ZRVw+zUqt5rkWJPxMciLun
 u1i9k9xtM7TlZs7oEbetVzr+i3i4A49Y87c5Mnd8cseTs6iZILi+vQRtwcijBUdNfCRb
 +nTtiJ1hSXrpi2IK5px1Acc9Z4uLWXcrCIikshC3zYiwtMYyHAh8twl5Iy3ELpSpOvT4
 Uo3t9KZC8d5Egtkyew32U3Qx7qUMG6Om1tO8BNDXO30ragx0q7HIT5cpWIZOjUYVnoT+
 SoXITqElV2aKCzMkVYJGgaYBQYAiVGcrKp3GZezuaueYlH+Zlp4NqkPcIDSkw9996Gt0
 V8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D3TIN7GVmzZf2vc4K8K5AuMdS/7XAlZhj8cjpR6bpjs=;
 b=RUsWEmBjIFMIS+8LG+xeH1SYkkuburNMU2TrncYgT0hhTykezItQmv7SgGS4dPLkMW
 xAJnRZ9gus1P+Ixwqzjpq+PnT1PdApSEpV+vwqZxha5FcTdbAfckHmXRiD6APZk9OZYS
 apR4OGpEatgwKzaGodq5mKOlkhwVk83lJX9R2ITMZ7IyuQY6x4gOMJu7Tky0RlFVOhve
 2U8N4XhIdYM5PWynHbof+wBm6GAaLXl6oVS8V9RzOG2ka70bFH1haeZFFIuyWBaaK1Cq
 d12+lK1+gH7mG1vppmAHxOBuNhtbJSFi/Lf9Xpw3Wc1PZat87L0J3WtRGs4bs+/B8/T2
 htWw==
X-Gm-Message-State: APjAAAWPEANNa/By1hMqQzKyndxfVctqbIxEfyloB5BI5G5xQSk5Dx79
 pun4+pd/Cuk/46iULznHXg4=
X-Google-Smtp-Source: APXvYqzSeGoSAa/6Nug0zyY9tEFUnup6xUq83Lxmbp4KhfmcdS/VfA1Xkq1I1CPJp/NHDZYDlGfFwQ==
X-Received: by 2002:a63:fc43:: with SMTP id r3mr47039829pgk.44.1554186632252; 
 Mon, 01 Apr 2019 23:30:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:30:31 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 02/18] counter: Documentation: Add Generic Counter sysfs
 documentation
Date: Tue,  2 Apr 2019 15:30:37 +0900
Message-Id: <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, david@lechnology.com,
 William Breathitt Gray <vilhelm.gray@gmail.com>, robh+dt@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, tglx@linutronix.de,
 fabrice.gasnier@st.com, esben@haabendal.dk, shawnguo@kernel.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, knaack.h@gmx.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch adds standard documentation for the userspace sysfs
attributes of the Generic Counter interface.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 230 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 2 files changed, 231 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
new file mode 100644
index 000000000000..566bd99fe0a5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -0,0 +1,230 @@
+What:		/sys/bus/counter/devices/counterX/countY/count
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count data of Count Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/countY/ceiling
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value ceiling for Count Y. This is the upper limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/floor
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count value floor for Count Y. This is the lower limit for the
+		respective counter.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count mode for channel Y. The ceiling and floor values for
+		Count Y are used by the count mode where required. The following
+		count modes are available:
+
+		normal:
+			Counting is continuous in either direction.
+
+		range limit:
+			An upper or lower limit is set, mimicking limit switches
+			in the mechanical counterpart. The upper limit is set to
+			the Count Y ceiling value, while the lower limit is set
+			to the Count Y floor value. The counter freezes at
+			count = ceiling when counting up, and at count = floor
+			when counting down. At either of these limits, the
+			counting is resumed only when the count direction is
+			reversed.
+
+		non-recycle:
+			The counter is disabled whenever a counter overflow or
+			underflow takes place. The counter is re-enabled when a
+			new count value is loaded to the counter via a preset
+			operation or direct write.
+
+		modulo-n:
+			A count value boundary is set between the Count Y floor
+			value and the Count Y ceiling value. The counter is
+			reset to the Count Y floor value at count = ceiling when
+			counting up, while the counter is set to the Count Y
+			ceiling value at count = floor when counting down; the
+			counter does not freeze at the boundary points, but
+			counts continuously throughout.
+
+What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
+What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
+What:		/sys/bus/counter/devices/counterX/countY/function_available
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/direction
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the count direction of Count
+		Y. Two count directions are available: forward and backward.
+
+		Some counter devices are able to determine the direction of
+		their counting. For example, quadrature encoding counters can
+		determine the direction of movement by evaluating the leading
+		phase of the respective A and B quadrature encoding signals.
+		This attribute exposes such count directions.
+
+What:		/sys/bus/counter/devices/counterX/countY/enable
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter is enabled. Valid attribute values are
+		boolean.
+
+		This attribute is intended to serve as a pause/unpause mechanism
+		for Count Y. Suppose a counter device is used to count the total
+		movement of a conveyor belt: this attribute allows an operator
+		to temporarily pause the counter, service the conveyor belt,
+		and then finally unpause the counter to continue where it had
+		left off.
+
+What:		/sys/bus/counter/devices/counterX/countY/error_noise
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates whether excessive noise is
+		present at the channel Y counter inputs.
+
+What:		/sys/bus/counter/devices/counterX/countY/function
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Count function mode of Count Y; count function evaluation is
+		triggered by conditions specified by the Count Y signalZ_action
+		attributes. The following count functions are available:
+
+		increase:
+			Accumulated count is incremented.
+
+		decrease:
+			Accumulated count is decremented.
+
+		pulse-direction:
+			Rising edges on signal A updates the respective count.
+			The input level of signal B determines direction.
+
+		quadrature x1 a:
+			If direction is forward, rising edges on quadrature pair
+			signal A updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal A
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		quadrature x1 b:
+			If direction is forward, rising edges on quadrature pair
+			signal B updates the respective count; if the direction
+			is backward, falling edges on quadrature pair signal B
+			updates the respective count. Quadrature encoding
+			determines the direction.
+
+		quadrature x2 a:
+			Any state transition on quadrature pair signal A updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		quadrature x2 b:
+			Any state transition on quadrature pair signal B updates
+			the respective count. Quadrature encoding determines the
+			direction.
+
+		quadrature x4:
+			Any state transition on either quadrature pair signals
+			updates	the respective count. Quadrature encoding
+			determines the direction.
+
+What:		/sys/bus/counter/devices/counterX/countY/name
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Count Y. If possible, this should match the name of the
+		respective channel as it appears in the device datasheet.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports preset registers -- registers
+		used to load counter channels to a set count upon device-defined
+		preset operation trigger events -- the preset count for channel
+		Y is provided by this attribute.
+
+What:		/sys/bus/counter/devices/counterX/countY/preset_enable
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether channel Y counter preset operation is enabled. Valid
+		attribute values are boolean.
+
+What:		/sys/bus/counter/devices/counterX/countY/signalZ_action
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Action mode of Count Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the count function
+		evaluation for Count Y. The following action modes are
+		available:
+
+		none:
+			Signal does not trigger the count function. In
+			Pulse-Direction count function mode, this Signal is
+			evaluated as Direction.
+
+		rising edge:
+			Low state transitions to high state.
+
+		falling edge:
+			High state transitions to low state.
+
+		both edges:
+			Any state transition.
+
+What:		/sys/bus/counter/devices/counterX/name
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		the Counter. This should match the name of the device as it
+		appears in its respective datasheet.
+
+What:		/sys/bus/counter/devices/counterX/num_counts
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Counts
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/num_signals
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the total number of Signals
+		belonging to the Counter.
+
+What:		/sys/bus/counter/devices/counterX/signalY/signal
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signal data of Signal Y represented as a string.
+
+What:		/sys/bus/counter/devices/counterX/signalY/name
+KernelVersion:	5.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y. If possible, this should match the name of the
+		respective signal as it appears in the device datasheet.
diff --git a/MAINTAINERS b/MAINTAINERS
index ef497d470501..af701863a249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3970,6 +3970,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	drivers/counter/
 F:	include/linux/counter.h
 F:	include/linux/counter_enum.h
-- 
2.21.0

