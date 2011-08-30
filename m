Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B678EB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 01:40:52 +1000 (EST)
Received: by gwj17 with SMTP id 17so5887117gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 08:40:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E5CDF2C.8030400@ru.mvista.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<d12fef0c09645ba1cd56dd011b5090cc8bde4b4b.1314704558.git.pratyush.anand@st.com>
	<4E5CDF2C.8030400@ru.mvista.com>
Date: Tue, 30 Aug 2011 21:10:48 +0530
Message-ID: <CAHM4w1k7yXP2K_Zyb5ccgRAM+vHNipzBjfon5ZMhR90oJMD9fQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] dwc/otg: Driver enable gadget support
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>, tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com,
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

On Tue, Aug 30, 2011 at 6:31 PM, Sergei Shtylyov <sshtylyov@mvista.com> wro=
te:
>
> Hello.
>
> On 08/30/2011 03:57 PM, Pratyush Anand wrote:
>
>> From: Tirumala Marri<tmarri@apm.com>
>
>> Enable gadget support
>
>> Signed-off-by: Tirumala R Marri<tmarri@apm.com>
>> Signed-off-by: Fushen Chen<fchen@apm.com>
>> Signed-off-by: Mark Miesfeld<mmiesfeld@apm.com>
>> Signed-off-by: Pratyush Anand<pratyush.anand@st.com>
>> ---
>> =A0drivers/usb/gadget/gadget_chips.h | =A0 18 +++++++++++++++++-
>> =A01 files changed, 17 insertions(+), 1 deletions(-)
>
>> diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadg=
et_chips.h
>> index 0978103..66b8018 100644
>> --- a/drivers/usb/gadget/gadget_chips.h
>> +++ b/drivers/usb/gadget/gadget_chips.h
>> @@ -148,6 +148,19 @@
>> =A0#define gadget_is_s3c_hsotg(g) =A0 =A00
>> =A0#endif
>>
>> +#if defined(CONFIG_DWC_OTG_MODE) || defined(CONFIG_DWC_DEVICE_ONLY)
>> +#define gadget_is_dwc_otg_pcd(g) =A0 =A0 =A0 (!strcmp("dwc_otg_pcd", (g=
)->name))
>> +#else
>> +#define gadget_is_dwc_otg_pcd(g) =A0 =A0 =A0 0
>> +#endif
>> +
>> +#ifdef CONFIG_USB_GADGET_CI13XXX_MSM
>> +#define gadget_is_ci13xxx_msm(g) =A0 =A0 =A0 (!strcmp("ci13xxx_msm", (g=
)->name))
>> +#else
>> +#define gadget_is_ci13xxx_msm(g) =A0 =A0 =A0 0
>> +#endif
>> +
>> +
>
> =A0 Too many newlines.
>

will correct it.

>>
>> =A0/**
>> =A0 * usb_gadget_controller_number - support bcdDevice id convention
>> @@ -208,10 +221,13 @@ static inline int usb_gadget_controller_number(str=
uct usb_gadget *gadget)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0x26;
>> =A0 =A0 =A0 =A0else if (gadget_is_designware(gadget))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0x27;
>> + =A0 =A0 =A0 else if (gadget_is_ci13xxx_msm(gadget))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0x28;
>> + =A0 =A0 =A0 else if (gadget_is_dwc_otg_pcd(gadget))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0x29;
>
> =A0 Hm, why are you adding 2 gadgets?

Yes, I also do not see reason for ci13xxx_msm.
This was added by original auther Tirumala.
@Tirumala , Please reply.

>
>> =A0 =A0 =A0 =A0return -ENOENT;
>> =A0}
>>
>> -
>
> =A0 Unrelated white space change.

will correct.

>
>> =A0/**
>> =A0 * gadget_supports_altsettings - return true if altsettings work
>> =A0 * @gadget: the gadget in question
>
> WBR, Sergei
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
