Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F907B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 17:44:24 +1000 (EST)
Date: Wed, 31 Aug 2011 09:44:18 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 08/14] dwc/otg: Add PCD function
Message-ID: <20110831074418.GC9353@linutronix.de>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<1b982bbcef0019d506c79ab90621ffe7744751b4.1314704558.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1b982bbcef0019d506c79ab90621ffe7744751b4.1314704558.git.pratyush.anand@st.com>
Cc: viresh.kumar@st.com, vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	tmarri@apm.com, linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Pratyush Anand | 2011-08-30 17:27:55 [+0530]:
>diff --git a/drivers/usb/dwc/pcd.c b/drivers/usb/dwc/pcd.c
>new file mode 100644
>index 0000000..2ef6405
>--- /dev/null
>+++ b/drivers/usb/dwc/pcd.c
>+static const struct usb_gadget_ops dwc_otg_pcd_ops = {
>+	.get_frame = dwc_otg_pcd_get_frame,
>+	.wakeup = dwc_otg_pcd_wakeup,

You may want to provide udc_start and udc_stop hooks.
drivers/usb/dwc3/gadget.c and drivers/usb/musb/musb_gadget.c are two
driver which are using it. The other gadget are using .start and .stop
hooks which I would like to go.

>+	/* not selfpowered */
>+};
>+
>+/**
>+ * This function registers a gadget driver with the PCD.
>+ *
>+ * When a driver is successfully registered, it will receive control
>+ * requests including set_configuration(), which enables non-control
>+ * requests.  then usb traffic follows until a disconnect is reported.
>+ * then a host may connect again, or the driver might get unbound.
>+ */
>+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
>+			    int (*bind) (struct usb_gadget *))

You can not provide usb_gadget_probe_driver() anymore. That is why you
need to provide those hooks I mentioned.

Sebastian
