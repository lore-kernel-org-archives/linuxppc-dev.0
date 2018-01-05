Return-Path: <bjorn.helgaas@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCtBp753SzF0QL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jan 2018 05:15:40 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id e20so6595400iof.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jan 2018 10:15:39 -0800 (PST)
MIME-Version: 1.0
Reply-To: bjorn@helgaas.com
In-Reply-To: <20180105164552.36371-3-bryantly@linux.vnet.ibm.com>
References: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
 <20180105164552.36371-3-bryantly@linux.vnet.ibm.com>
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Fri, 5 Jan 2018 12:15:37 -0600
Message-ID: <CABhMZUWiaKSDu0wAp=75LCizH+-s9gjhU3NCc513jYk8qVrFUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] linux/pci: Add uevents in AER and EEH error/resume
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, mpe@ellerman.id.au,
 seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com, eli@mellanox.com, saeedm@mellanox.com
Content-Type: multipart/alternative; boundary="001a1141b436760f7f05620b6f32"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1141b436760f7f05620b6f32
Content-Type: text/plain; charset="UTF-8"

I doubt "linux/pci: " matches the powerpc convention and I know it doesn't
match the drivers/pci convention.

I'd suggest matching one or the other.  In drivers/pci I would be using
"PCI/AER: ".

On Jan 5, 2018 10:46 AM, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com> wrote:

> Devices can go offline when erors reported. This
> patch adds a change to the kernel object and lets udev
> know of error. When device resumes, a change is also set
> reporting device as online. Therefore, EEH and AER events
> are better propagated to user space for PCI devices in
> all arches.
>
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c   |  6 ++++++
>  drivers/pci/pcie/aer/aerdrv_core.c |  3 +++
>  include/linux/pci.h                | 36 ++++++++++++++++++++++++++++++
> ++++++
>  3 files changed, 45 insertions(+)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_
> driver.c
> index 3c0fa99c5533..beea2182d754 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -228,6 +228,7 @@ static void *eeh_report_error(void *data, void
> *userdata)
>
>         edev->in_error = true;
>         eeh_pcid_put(dev);
> +       pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
>         return NULL;
>  }
>
> @@ -381,6 +382,10 @@ static void *eeh_report_resume(void *data, void
> *userdata)
>         driver->err_handler->resume(dev);
>
>         eeh_pcid_put(dev);
> +       pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
> +#ifdef CONFIG_PCI_IOV
> +       eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
> +#endif
>         return NULL;
>  }
>
> @@ -416,6 +421,7 @@ static void *eeh_report_failure(void *data, void
> *userdata)
>         driver->err_handler->error_detected(dev,
> pci_channel_io_perm_failure);
>
>         eeh_pcid_put(dev);
> +       pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>         return NULL;
>  }
>
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c
> b/drivers/pci/pcie/aer/aerdrv_core.c
> index 744805232155..8d7448063fd1 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -278,6 +278,7 @@ static int report_error_detected(struct pci_dev *dev,
> void *data)
>         } else {
>                 err_handler = dev->driver->err_handler;
>                 vote = err_handler->error_detected(dev,
> result_data->state);
> +               pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
>         }
>
>         result_data->result = merge_result(result_data->result, vote);
> @@ -341,6 +342,7 @@ static int report_resume(struct pci_dev *dev, void
> *data)
>
>         err_handler = dev->driver->err_handler;
>         err_handler->resume(dev);
> +       pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
>  out:
>         device_unlock(&dev->dev);
>         return 0;
> @@ -541,6 +543,7 @@ static void do_recovery(struct pci_dev *dev, int
> severity)
>         return;
>
>  failed:
> +       pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>         /* TODO: Should kernel panic here? */
>         dev_info(&dev->dev, "AER: Device recovery failed\n");
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e3e94467687a..405630441b74 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2277,6 +2277,42 @@ static inline bool pci_is_thunderbolt_attached(struct
> pci_dev *pdev)
>         return false;
>  }
>
> +/**
> + * pci_uevent_ers - emit a uevent during recovery path of pci device
> + * @pdev: pci device to check
> + * @err_type: type of error event
> + *
> + */
> +static inline void pci_uevent_ers(struct pci_dev *pdev,
> +                                 enum  pci_ers_result err_type)
> +{
> +       int idx = 0;
> +       char *envp[3];
> +
> +       switch (err_type) {
> +       case PCI_ERS_RESULT_NONE:
> +       case PCI_ERS_RESULT_CAN_RECOVER:
> +               envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
> +               envp[idx++] = "DEVICE_ONLINE=0";
> +               break;
> +       case PCI_ERS_RESULT_RECOVERED:
> +               envp[idx++] = "ERROR_EVENT=SUCCESSFUL_RECOVERY";
> +               envp[idx++] = "DEVICE_ONLINE=1";
> +               break;
> +       case PCI_ERS_RESULT_DISCONNECT:
> +               envp[idx++] = "ERROR_EVENT=FAILED_RECOVERY";
> +               envp[idx++] = "DEVICE_ONLINE=0";
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (idx > 0) {
> +               envp[idx++] = NULL;
> +               kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
> +       }
> +}
> +
>  /* provide the legacy pci_dma_* API */
>  #include <linux/pci-dma-compat.h>
>
> --
> 2.14.3 (Apple Git-98)
>
>

--001a1141b436760f7f05620b6f32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I doubt &quot;linux/pci: &quot; matches the powerpc conve=
ntion and I know it doesn&#39;t match the drivers/pci convention.<div dir=
=3D"auto"><br></div><div dir=3D"auto">I&#39;d suggest matching one or the o=
ther.=C2=A0 In drivers/pci I would be using &quot;PCI/AER: &quot;.</div></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Jan 5, 2018=
 10:46 AM, &quot;Bryant G. Ly&quot; &lt;<a href=3D"mailto:bryantly@linux.vn=
et.ibm.com">bryantly@linux.vnet.ibm.com</a>&gt; wrote:<br type=3D"attributi=
on"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Devices can go offline when erors report=
ed. This<br>
patch adds a change to the kernel object and lets udev<br>
know of error. When device resumes, a change is also set<br>
reporting device as online. Therefore, EEH and AER events<br>
are better propagated to user space for PCI devices in<br>
all arches.<br>
<br>
Signed-off-by: Bryant G. Ly &lt;<a href=3D"mailto:bryantly@linux.vnet.ibm.c=
om">bryantly@linux.vnet.ibm.com</a>&gt;<br>
Signed-off-by: Juan J. Alvarez &lt;<a href=3D"mailto:jjalvare@linux.vnet.ib=
m.com">jjalvare@linux.vnet.ibm.com</a>&gt;<br>
Acked-by: Bjorn Helgaas &lt;<a href=3D"mailto:bhelgaas@google.com">bhelgaas=
@google.com</a>&gt;<br>
---<br>
=C2=A0arch/powerpc/kernel/eeh_<wbr>driver.c=C2=A0 =C2=A0|=C2=A0 6 ++++++<br=
>
=C2=A0drivers/pci/pcie/aer/aerdrv_<wbr>core.c |=C2=A0 3 +++<br>
=C2=A0include/linux/pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 36 ++++++++++++++++++++++++++++++<wbr>++++++<br>
=C2=A03 files changed, 45 insertions(+)<br>
<br>
diff --git a/arch/powerpc/kernel/eeh_<wbr>driver.c b/arch/powerpc/kernel/ee=
h_<wbr>driver.c<br>
index 3c0fa99c5533..beea2182d754 100644<br>
--- a/arch/powerpc/kernel/eeh_<wbr>driver.c<br>
+++ b/arch/powerpc/kernel/eeh_<wbr>driver.c<br>
@@ -228,6 +228,7 @@ static void *eeh_report_error(void *data, void *userdat=
a)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 edev-&gt;in_error =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eeh_pcid_put(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0}<br>
<br>
@@ -381,6 +382,10 @@ static void *eeh_report_resume(void *data, void *userd=
ata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver-&gt;err_handler-&gt;resume(<wbr>dev);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eeh_pcid_put(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);<=
br>
+#ifdef CONFIG_PCI_IOV<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0eeh_ops-&gt;notify_resume(eeh_<wbr>dev_to_pdn(e=
dev));<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0}<br>
<br>
@@ -416,6 +421,7 @@ static void *eeh_report_failure(void *data, void *userd=
ata)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 driver-&gt;err_handler-&gt;error_<wbr>detected(=
dev, pci_channel_io_perm_failure);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 eeh_pcid_put(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0}<br>
<br>
diff --git a/drivers/pci/pcie/aer/aerdrv_<wbr>core.c b/drivers/pci/pcie/aer=
/aerdrv_<wbr>core.c<br>
index 744805232155..8d7448063fd1 100644<br>
--- a/drivers/pci/pcie/aer/aerdrv_<wbr>core.c<br>
+++ b/drivers/pci/pcie/aer/aerdrv_<wbr>core.c<br>
@@ -278,6 +278,7 @@ static int report_error_detected(struct pci_dev *dev, v=
oid *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_handler =3D dev=
-&gt;driver-&gt;err_handler;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vote =3D err_handle=
r-&gt;error_detected(<wbr>dev, result_data-&gt;state);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_uevent_ers(dev,=
 PCI_ERS_RESULT_NONE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 result_data-&gt;result =3D merge_result(result_=
data-&gt;<wbr>result, vote);<br>
@@ -341,6 +342,7 @@ static int report_resume(struct pci_dev *dev, void *dat=
a)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err_handler =3D dev-&gt;driver-&gt;err_handler;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 err_handler-&gt;resume(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);<=
br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_unlock(&amp;dev-&gt;dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
@@ -541,6 +543,7 @@ static void do_recovery(struct pci_dev *dev, int severi=
ty)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0failed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: Should kernel panic here? */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&amp;dev-&gt;dev, &quot;AER: Device re=
covery failed\n&quot;);<br>
=C2=A0}<br>
diff --git a/include/linux/pci.h b/include/linux/pci.h<br>
index e3e94467687a..405630441b74 100644<br>
--- a/include/linux/pci.h<br>
+++ b/include/linux/pci.h<br>
@@ -2277,6 +2277,42 @@ static inline bool pci_is_thunderbolt_attached(<wbr>=
struct pci_dev *pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0}<br>
<br>
+/**<br>
+ * pci_uevent_ers - emit a uevent during recovery path of pci device<br>
+ * @pdev: pci device to check<br>
+ * @err_type: type of error event<br>
+ *<br>
+ */<br>
+static inline void pci_uevent_ers(struct pci_dev *pdev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum=C2=A0 pci_ers_result err_=
type)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int idx =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *envp[3];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (err_type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case PCI_ERS_RESULT_NONE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case PCI_ERS_RESULT_CAN_RECOVER:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envp[idx++] =3D &qu=
ot;ERROR_EVENT=3DBEGIN_RECOVERY&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envp[idx++] =3D &qu=
ot;DEVICE_ONLINE=3D0&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case PCI_ERS_RESULT_RECOVERED:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envp[idx++] =3D &qu=
ot;ERROR_EVENT=3DSUCCESSFUL_<wbr>RECOVERY&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envp[idx++] =3D &qu=
ot;DEVICE_ONLINE=3D1&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case PCI_ERS_RESULT_DISCONNECT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envp[idx++] =3D &qu=
ot;ERROR_EVENT=3DFAILED_RECOVERY&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envp[idx++] =3D &qu=
ot;DEVICE_ONLINE=3D0&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (idx &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0envp[idx++] =3D NUL=
L;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kobject_uevent_env(=
&amp;pdev-&gt;dev.<wbr>kobj, KOBJ_CHANGE, envp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
=C2=A0/* provide the legacy pci_dma_* API */<br>
=C2=A0#include &lt;linux/pci-dma-compat.h&gt;<br>
<br>
--<br>
2.14.3 (Apple Git-98)<br>
<br>
</blockquote></div></div>

--001a1141b436760f7f05620b6f32--
