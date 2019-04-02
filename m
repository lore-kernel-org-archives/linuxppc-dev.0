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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B9C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:38:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8769E2070B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 06:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/YU9Wqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8769E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKKQ1dFrzDqGG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 17:38:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="m/YU9Wqu"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YK8j6Q6ZzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:30:45 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id i19so5834110pfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Apr 2019 23:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lKsEEW9zGC7z+vMiNGYsEakXMLu4Ku5min8yoaBqYdY=;
 b=m/YU9WquU9JxGHokLkAUweNMwtJP8IUYe2IrUE253dHBmNL9x7Vy9j7PZRxl7iN5/+
 /uyZU+my3pwdZ/IR43LjfwoP2H3Po8lAXLcFItQ0UqcGdvaqrZFWoWfsu82Z61g03B13
 Up6qmtH6OrAJFOD/N4zCjEIAEv5cs05y6acf313KOsHsR5cT3otZWFi9NwWKZwDJ2Dmt
 s1Dj89/NDxMyHDXpn5T5Wz6GtT6pMfAhKurgjWJotiK1Q6ObrchjNDU8EmUftbwItPxu
 H3GAaq5hEai6m65YhK7ErHzEkcC3sPFe5E6I/feUErH+d9eDf0z9RHx6GSRfZ75Zin8g
 piaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lKsEEW9zGC7z+vMiNGYsEakXMLu4Ku5min8yoaBqYdY=;
 b=hyDE2deXR67eNqtX2/jrq1xcb6WKvIM0c+k5D8b8P/azTUPrp/YOPIPCMkZq/jveU6
 MyX3bL2hQe6J0deYQrahmBvlVX/00wPJsjsF64uvM92bq1BREZbrIe0xpGPASgrkfYC9
 y4g5lHQNlGuBEq29q8NrvBeCr4HYYhu6ukpxHVR/ASHdZa4XCjVwhNKVKsmiANgxK48S
 gTcvbycU1qWSNo/6H9LgJch5bkHSZmeeeJQBpY2gu2ruxsi1S0/3/60k4mV6fH3WuJrI
 3DiU/IPjhLYQ7uB1U9d9oZJT5uh4EBDwBOY+ltlQwingC2vYpDMRuAj6ctRFicGwLHyA
 ym+w==
X-Gm-Message-State: APjAAAW/8P/q781wiqTxjKJDBU3ZfFlDfBCVPcwAjjM50cn4KsrIBGI0
 ZvA5pHrjD0v/JlEftVZSNN8=
X-Google-Smtp-Source: APXvYqweF4OgPR3Bh2MXNEgp2fs9TLID62C/xhXUlzaAid8hKvU0ECtorgzz9nRsZc1/88rSyHEydA==
X-Received: by 2002:a63:700f:: with SMTP id l15mr19831057pgc.3.1554186643341; 
 Mon, 01 Apr 2019 23:30:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.30.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2019 23:30:42 -0700 (PDT)
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v10 03/18] docs: Add Generic Counter interface documentation
Date: Tue,  2 Apr 2019 15:30:38 +0900
Message-Id: <1a232b5fdfe434b5e066f389f839243bcf151a33.1554184734.git.vilhelm.gray@gmail.com>
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

This patch adds high-level documentation about the Generic Counter
interface.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 342 +++++++++++++++++++
 Documentation/driver-api/index.rst           |   1 +
 MAINTAINERS                                  |   1 +
 3 files changed, 344 insertions(+)
 create mode 100644 Documentation/driver-api/generic-counter.rst

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
new file mode 100644
index 000000000000..f51db893f595
--- /dev/null
+++ b/Documentation/driver-api/generic-counter.rst
@@ -0,0 +1,342 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Generic Counter Interface
+=========================
+
+Introduction
+============
+
+Counter devices are prevalent within a diverse spectrum of industries.
+The ubiquitous presence of these devices necessitates a common interface
+and standard of interaction and exposure. This driver API attempts to
+resolve the issue of duplicate code found among existing counter device
+drivers by introducing a generic counter interface for consumption. The
+Generic Counter interface enables drivers to support and expose a common
+set of components and functionality present in counter devices.
+
+Theory
+======
+
+Counter devices can vary greatly in design, but regardless of whether
+some devices are quadrature encoder counters or tally counters, all
+counter devices consist of a core set of components. This core set of
+components, shared by all counter devices, is what forms the essence of
+the Generic Counter interface.
+
+There are three core components to a counter:
+
+* Count:
+  Count data for a set of Signals.
+
+* Signal:
+  Input data that is evaluated by the counter to determine the count
+  data.
+
+* Synapse:
+  The association of a Signal with a respective Count.
+
+COUNT
+-----
+A Count represents the count data for a set of Signals. The Generic
+Counter interface provides the following available count data types:
+
+* COUNT_POSITION:
+  Unsigned integer value representing position.
+
+A Count has a count function mode which represents the update behavior
+for the count data. The Generic Counter interface provides the following
+available count function modes:
+
+* Increase:
+  Accumulated count is incremented.
+
+* Decrease:
+  Accumulated count is decremented.
+
+* Pulse-Direction:
+  Rising edges on signal A updates the respective count. The input level
+  of signal B determines direction.
+
+* Quadrature:
+  A pair of quadrature encoding signals are evaluated to determine
+  position and direction. The following Quadrature modes are available:
+
+  - x1 A:
+    If direction is forward, rising edges on quadrature pair signal A
+    updates the respective count; if the direction is backward, falling
+    edges on quadrature pair signal A updates the respective count.
+    Quadrature encoding determines the direction.
+
+  - x1 B:
+    If direction is forward, rising edges on quadrature pair signal B
+    updates the respective count; if the direction is backward, falling
+    edges on quadrature pair signal B updates the respective count.
+    Quadrature encoding determines the direction.
+
+  - x2 A:
+    Any state transition on quadrature pair signal A updates the
+    respective count. Quadrature encoding determines the direction.
+
+  - x2 B:
+    Any state transition on quadrature pair signal B updates the
+    respective count. Quadrature encoding determines the direction.
+
+  - x4:
+    Any state transition on either quadrature pair signals updates the
+    respective count. Quadrature encoding determines the direction.
+
+A Count has a set of one or more associated Signals.
+
+SIGNAL
+------
+A Signal represents a counter input data; this is the input data that is
+evaluated by the counter to determine the count data; e.g. a quadrature
+signal output line of a rotary encoder. Not all counter devices provide
+user access to the Signal data.
+
+The Generic Counter interface provides the following available signal
+data types for when the Signal data is available for user access:
+
+* SIGNAL_LEVEL:
+  Signal line state level. The following states are possible:
+
+  - SIGNAL_LEVEL_LOW:
+    Signal line is in a low state.
+
+  - SIGNAL_LEVEL_HIGH:
+    Signal line is in a high state.
+
+A Signal may be associated with one or more Counts.
+
+SYNAPSE
+-------
+A Synapse represents the association of a Signal with a respective
+Count. Signal data affects respective Count data, and the Synapse
+represents this relationship.
+
+The Synapse action mode specifies the Signal data condition which
+triggers the respective Count's count function evaluation to update the
+count data. The Generic Counter interface provides the following
+available action modes:
+
+* None:
+  Signal does not trigger the count function. In Pulse-Direction count
+  function mode, this Signal is evaluated as Direction.
+
+* Rising Edge:
+  Low state transitions to high state.
+
+* Falling Edge:
+  High state transitions to low state.
+
+* Both Edges:
+  Any state transition.
+
+A counter is defined as a set of input signals associated with count
+data that are generated by the evaluation of the state of the associated
+input signals as defined by the respective count functions. Within the
+context of the Generic Counter interface, a counter consists of Counts
+each associated with a set of Signals, whose respective Synapse
+instances represent the count function update conditions for the
+associated Counts.
+
+Paradigm
+========
+
+The most basic counter device may be expressed as a single Count
+associated with a single Signal via a single Synapse. Take for example
+a counter device which simply accumulates a count of rising edges on a
+source input line::
+
+                Count                Synapse        Signal
+                -----                -------        ------
+        +---------------------+
+        | Data: Count         |    Rising Edge     ________
+        | Function: Increase  |  <-------------   / Source \
+        |                     |                  ____________
+        +---------------------+
+
+In this example, the Signal is a source input line with a pulsing
+voltage, while the Count is a persistent count value which is repeatedly
+incremented. The Signal is associated with the respective Count via a
+Synapse. The increase function is triggered by the Signal data condition
+specified by the Synapse -- in this case a rising edge condition on the
+voltage input line. In summary, the counter device existence and
+behavior is aptly represented by respective Count, Signal, and Synapse
+components: a rising edge condition triggers an increase function on an
+accumulating count datum.
+
+A counter device is not limited to a single Signal; in fact, in theory
+many Signals may be associated with even a single Count. For example, a
+quadrature encoder counter device can keep track of position based on
+the states of two input lines::
+
+                   Count                 Synapse     Signal
+                   -----                 -------     ------
+        +-------------------------+
+        | Data: Position          |    Both Edges     ___
+        | Function: Quadrature x4 |  <------------   / A \
+        |                         |                 _______
+        |                         |
+        |                         |    Both Edges     ___
+        |                         |  <------------   / B \
+        |                         |                 _______
+        +-------------------------+
+
+In this example, two Signals (quadrature encoder lines A and B) are
+associated with a single Count: a rising or falling edge on either A or
+B triggers the "Quadrature x4" function which determines the direction
+of movement and updates the respective position data. The "Quadrature
+x4" function is likely implemented in the hardware of the quadrature
+encoder counter device; the Count, Signals, and Synapses simply
+represent this hardware behavior and functionality.
+
+Signals associated with the same Count can have differing Synapse action
+mode conditions. For example, a quadrature encoder counter device
+operating in a non-quadrature Pulse-Direction mode could have one input
+line dedicated for movement and a second input line dedicated for
+direction::
+
+                   Count                   Synapse      Signal
+                   -----                   -------      ------
+        +---------------------------+
+        | Data: Position            |    Rising Edge     ___
+        | Function: Pulse-Direction |  <-------------   / A \ (Movement)
+        |                           |                  _______
+        |                           |
+        |                           |       None         ___
+        |                           |  <-------------   / B \ (Direction)
+        |                           |                  _______
+        +---------------------------+
+
+Only Signal A triggers the "Pulse-Direction" update function, but the
+instantaneous state of Signal B is still required in order to know the
+direction so that the position data may be properly updated. Ultimately,
+both Signals are associated with the same Count via two respective
+Synapses, but only one Synapse has an active action mode condition which
+triggers the respective count function while the other is left with a
+"None" condition action mode to indicate its respective Signal's
+availability for state evaluation despite its non-triggering mode.
+
+Keep in mind that the Signal, Synapse, and Count are abstract
+representations which do not need to be closely married to their
+respective physical sources. This allows the user of a counter to
+divorce themselves from the nuances of physical components (such as
+whether an input line is differential or single-ended) and instead focus
+on the core idea of what the data and process represent (e.g. position
+as interpreted from quadrature encoding data).
+
+Userspace Interface
+===================
+
+Several sysfs attributes are generated by the Generic Counter interface,
+and reside under the /sys/bus/counter/devices/counterX directory, where
+counterX refers to the respective counter device. Please see
+Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
+information on each Generic Counter interface sysfs attribute.
+
+Through these sysfs attributes, programs and scripts may interact with
+the Generic Counter paradigm Counts, Signals, and Synapses of respective
+counter devices.
+
+Driver API
+==========
+
+Driver authors may utilize the Generic Counter interface in their code
+by including the include/linux/counter.h header file. This header file
+provides several core data structures, function prototypes, and macros
+for defining a counter device.
+
+.. kernel-doc:: include/linux/counter.h
+   :internal:
+
+.. kernel-doc:: drivers/counter/generic-counter.c
+   :export:
+
+Implementation
+==============
+
+To support a counter device, a driver must first allocate the available
+Counter Signals via counter_signal structures. These Signals should
+be stored as an array and set to the signals array member of an
+allocated counter_device structure before the Counter is registered to
+the system.
+
+Counter Counts may be allocated via counter_count structures, and
+respective Counter Signal associations (Synapses) made via
+counter_synapse structures. Associated counter_synapse structures are
+stored as an array and set to the the synapses array member of the
+respective counter_count structure. These counter_count structures are
+set to the counts array member of an allocated counter_device structure
+before the Counter is registered to the system.
+
+Driver callbacks should be provided to the counter_device structure via
+a constant counter_ops structure in order to communicate with the
+device: to read and write various Signals and Counts, and to set and get
+the "action mode" and "function mode" for various Synapses and Counts
+respectively.
+
+A defined counter_device structure may be registered to the system by
+passing it to the counter_register function, and unregistered by passing
+it to the counter_unregister function. Similarly, the
+devm_counter_register and devm_counter_unregister functions may be used
+if device memory-managed registration is desired.
+
+Extension sysfs attributes can be created for auxiliary functionality
+and data by passing in defined counter_device_ext, counter_count_ext,
+and counter_signal_ext structures. In these cases, the
+counter_device_ext structure is used for global configuration of the
+respective Counter device, while the counter_count_ext and
+counter_signal_ext structures allow for auxiliary exposure and
+configuration of a specific Count or Signal respectively.
+
+Architecture
+============
+
+When the Generic Counter interface counter module is loaded, the
+counter_init function is called which registers a bus_type named
+"counter" to the system. Subsequently, when the module is unloaded, the
+counter_exit function is called which unregisters the bus_type named
+"counter" from the system.
+
+Counter devices are registered to the system via the counter_register
+function, and later removed via the counter_unregister function. The
+counter_register function establishes a unique ID for the Counter
+device and creates a respective sysfs directory, where X is the
+mentioned unique ID:
+
+    /sys/bus/counter/devices/counterX
+
+Sysfs attributes are created within the counterX directory to expose
+functionality, configurations, and data relating to the Counts, Signals,
+and Synapses of the Counter device, as well as options and information
+for the Counter device itself.
+
+Each Signal has a directory created to house its relevant sysfs
+attributes, where Y is the unique ID of the respective Signal:
+
+    /sys/bus/counter/devices/counterX/signalY
+
+Similarly, each Count has a directory created to house its relevant
+sysfs attributes, where Y is the unique ID of the respective Count:
+
+    /sys/bus/counter/devices/counterX/countY
+
+For a more detailed breakdown of the available Generic Counter interface
+sysfs attributes, please refer to the
+Documentation/ABI/testing/sys-bus-counter file.
+
+The Signals and Counts associated with the Counter device are registered
+to the system as well by the counter_register function. The
+signal_read/signal_write driver callbacks are associated with their
+respective Signal attributes, while the count_read/count_write and
+function_get/function_set driver callbacks are associated with their
+respective Count attributes; similarly, the same is true for the
+action_get/action_set driver callbacks and their respective Synapse
+attributes. If a driver callback is left undefined, then the respective
+read/write permission is left disabled for the relevant attributes.
+
+Similarly, extension sysfs attributes are created for the defined
+counter_device_ext, counter_count_ext, and counter_signal_ext
+structures that are passed in.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index ab38ced66a44..37dce988c7fd 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -55,6 +55,7 @@ available subsections can be seen below.
    slimbus
    soundwire/index
    fpga/index
+   generic-counter
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index af701863a249..208c92ff4801 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3971,6 +3971,7 @@ M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-counter*
+F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
 F:	include/linux/counter_enum.h
-- 
2.21.0

