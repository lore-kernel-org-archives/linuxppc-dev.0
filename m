Return-Path: <pratyush.anand@gmail.com>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 33037B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 21:26:11 +1000 (EST)
Received: by yib12 with SMTP id 12so2088802yib.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 02 Sep 2011 04:26:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110831074418.GC9353@linutronix.de>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<1b982bbcef0019d506c79ab90621ffe7744751b4.1314704558.git.pratyush.anand@st.com>
	<20110831074418.GC9353@linutronix.de>
Date: Fri, 2 Sep 2011 16:56:08 +0530
Message-ID: <CAHM4w1=-T1iH7kbvKibzJE3N-Y7UU5Wmww2_aMwN35m9_hw6kQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] dwc/otg: Add PCD function
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
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

On Wed, Aug 31, 2011 at 1:14 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Pratyush Anand | 2011-08-30 17:27:55 [+0530]:
>>diff --git a/drivers/usb/dwc/pcd.c b/drivers/usb/dwc/pcd.c
>>new file mode 100644
>>index 0000000..2ef6405
>>--- /dev/null
>>+++ b/drivers/usb/dwc/pcd.c
>>+static const struct usb_gadget_ops dwc_otg_pcd_ops =3D {
>>+ =A0 =A0 =A0.get_frame =3D dwc_otg_pcd_get_frame,
>>+ =A0 =A0 =A0.wakeup =3D dwc_otg_pcd_wakeup,
>
> You may want to provide udc_start and udc_stop hooks.
> drivers/usb/dwc3/gadget.c and drivers/usb/musb/musb_gadget.c are two
> driver which are using it. The other gadget are using .start and .stop
> hooks which I would like to go.
>
>>+ =A0 =A0 =A0/* not selfpowered */
>>+};
>>+
>>+/**
>>+ * This function registers a gadget driver with the PCD.
>>+ *
>>+ * When a driver is successfully registered, it will receive control
>>+ * requests including set_configuration(), which enables non-control
>>+ * requests. =A0then usb traffic follows until a disconnect is reported.
>>+ * then a host may connect again, or the driver might get unbound.
>>+ */
>>+int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int (*bind) (struct =
usb_gadget *))
>
> You can not provide usb_gadget_probe_driver() anymore. That is why you
> need to provide those hooks I mentioned.

will correct.

Regards
Pratyush

>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
