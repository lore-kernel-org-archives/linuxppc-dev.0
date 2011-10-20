Return-Path: <pratyush.anand@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 69D21B70B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 20:30:03 +1100 (EST)
Received: by yws29 with SMTP id 29so2771676yws.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 02:29:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630143-14327-1-git-send-email-tmarri@apm.com>
References: <1318630143-14327-1-git-send-email-tmarri@apm.com>
Date: Thu, 20 Oct 2011 14:59:59 +0530
Message-ID: <CAHM4w1kkux=PXgBAe+zdLkKYH-CsTK65vMLtOLht7QASUHDGDQ@mail.gmail.com>
Subject: Re: [PATCH v15 06/10] USB/ppc4xx: Add Synopsys DWC OTG HCD queue
 function
From: Pratyush Anand <pratyush.anand@gmail.com>
To: tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 15, 2011 at 3:39 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>
> Implements functions to manage Queue Heads and Queue
> Transfer Descriptors of DWC USB OTG Controller.
>
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
> =A0drivers/usb/dwc/hcd_queue.c | =A0696 +++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 696 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/usb/dwc/hcd_queue.c
>
> diff --git a/drivers/usb/dwc/hcd_queue.c b/drivers/usb/dwc/hcd_queue.c
> new file mode 100644
> index 0000000..67f0409
> --- /dev/null
> +++ b/drivers/usb/dwc/hcd_queue.c
> @@ -0,0 +1,696 @@
> +/*
> + * DesignWare HS OTG controller driver
> + * Copyright (C) 2006 Synopsys, Inc.
> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
> + *
> + * This program is free software: you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License version 2 for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see http://www.gnu.org/licenses
> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
> + * Suite 500, Boston, MA 02110-1335 USA.
> + *
> + * Based on Synopsys driver version 2.60a
> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
> + * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
> + * Modified by Chuck Meade <chuck@theptrgroup.com>
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "=
AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO T=
HE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DI=
RECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SER=
VICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUS=
ED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR =
TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + */
> +
> +/*
> + * This file contains the functions to manage Queue Heads and Queue
> + * Transfer Descriptors.
> + */
> +
> +#include "hcd.h"
> +
> +static inline int is_fs_ls(enum usb_device_speed speed)
> +{
> + =A0 =A0 =A0 return speed =3D=3D USB_SPEED_FULL || speed =3D=3D USB_SPEE=
D_LOW;
> +}
> +
> +/* Allocates memory for a QH structure. */
> +static inline struct dwc_qh *dwc_otg_hcd_qh_alloc(void)
> +{
> + =A0 =A0 =A0 return kmalloc(sizeof(struct dwc_qh), GFP_ATOMIC);
> +}
> +
> +/**
> + * Initializes a QH structure to initialize the QH.
> + */
> +#define SCHEDULE_SLOP 10
> +static void dwc_otg_hcd_qh_init(struct dwc_hcd *hcd, struct dwc_qh *qh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct urb =
*urb)
> +{
> + =A0 =A0 =A0 memset(qh, 0, sizeof(struct dwc_qh));
> +
> + =A0 =A0 =A0 /* Initialize QH */
> + =A0 =A0 =A0 switch (usb_pipetype(urb->pipe)) {
> + =A0 =A0 =A0 case PIPE_CONTROL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->ep_type =3D USB_ENDPOINT_XFER_CONTROL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_BULK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->ep_type =3D USB_ENDPOINT_XFER_BULK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_ISOCHRONOUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->ep_type =3D USB_ENDPOINT_XFER_ISOC;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_INTERRUPT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->ep_type =3D USB_ENDPOINT_XFER_INT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 qh->ep_is_in =3D usb_pipein(urb->pipe) ? 1 : 0;
> + =A0 =A0 =A0 qh->data_toggle =3D DWC_OTG_HC_PID_DATA0;
> + =A0 =A0 =A0 qh->maxp =3D usb_maxpacket(urb->dev, urb->pipe, !(usb_pipei=
n(urb->pipe)));
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&qh->qtd_list);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&qh->qh_list_entry);
> +
> + =A0 =A0 =A0 qh->channel =3D NULL;
> + =A0 =A0 =A0 qh->speed =3D urb->dev->speed;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* FS/LS Enpoint on HS Hub NOT virtual root hub
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 qh->do_split =3D 0;
> + =A0 =A0 =A0 if (is_fs_ls(urb->dev->speed) && urb->dev->tt && urb->dev->=
tt->hub &&
> + =A0 =A0 =A0 =A0 =A0 urb->dev->tt->hub->devnum !=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->do_split =3D 1;
> +
> + =A0 =A0 =A0 if (qh->ep_type =3D=3D USB_ENDPOINT_XFER_INT ||
> + =A0 =A0 =A0 =A0 =A0 qh->ep_type =3D=3D USB_ENDPOINT_XFER_ISOC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Compute scheduling parameters once and s=
ave them. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 hprt;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int bytecount =3D dwc_hb_mult(qh->maxp) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_max_packet(qh->maxp);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->usecs =3D NS_TO_US(usb_calc_bus_time(ur=
b->dev->speed,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_pipein(urb->pipe),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(qh->ep_type =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_ENDPOINT_XFER_ISOC),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bytecount));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Start in a slightly future (micro)frame.=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame =3D dwc_frame_num_inc(hcd->=
frame_number,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SCHEDULE_SLOP);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->interval =3D urb->interval;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hprt =3D dwc_reg_read(hcd->core_if->host_if=
->hprt0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HPRT0_PRT_SPD_RD(hprt) =3D=3D DWC_H=
PRT0_PRTSPD_HIGH_SPEED &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_fs_ls(urb->dev->speed)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->interval *=3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame |=3D 0x7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->start_split_frame =3D q=
h->sched_frame;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * This function allocates and initializes a QH.
> + */
> +static struct dwc_qh *dwc_otg_hcd_qh_create(struct dwc_hcd *hcd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct urb *urb)
> +{
> + =A0 =A0 =A0 struct dwc_qh *qh;
> +
> + =A0 =A0 =A0 /* Allocate memory */
> + =A0 =A0 =A0 qh =3D dwc_otg_hcd_qh_alloc();
> + =A0 =A0 =A0 if (qh =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 dwc_otg_hcd_qh_init(hcd, qh, urb);
> + =A0 =A0 =A0 return qh;
> +}
> +
> +/**
> + * Free each QTD in the QH's QTD-list then free the QH. =A0QH should alr=
eady be
> + * removed from a list. =A0QTD list should already be empty if called fr=
om URB
> + * Dequeue.
> + */
> +void dwc_otg_hcd_qh_free(struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 struct dwc_qtd *qtd;
> + =A0 =A0 =A0 struct list_head *pos, *temp;
> +
> + =A0 =A0 =A0 /* Free each QTD in the QTD list */
> + =A0 =A0 =A0 list_for_each_safe(pos, temp, &qh->qtd_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(pos);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd =3D dwc_list_to_qtd(pos);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_qtd_free(qtd);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(qh);
> +}
> +
> +/**
> + * Microframe scheduler
> + * track the total use in hcd->frame_usecs
> + * keep each qh use in qh->frame_usecs
> + * when surrendering the qh then donate the time back
> + */
> +static const u16 max_uframe_usecs[] =3D { 100, 100, 100, 100, 100, 100, =
30, 0 };
> +
> +/*
> + * called from dwc_otg_hcd.c:dwc_otg_hcd_init
> + */
> +int init_hcd_usecs(struct dwc_hcd *hcd)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 8; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->frame_usecs[i] =3D max_uframe_usecs[i]=
;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int find_single_uframe(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u16 utime;
> + =A0 =A0 =A0 int t_left;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int done;
> +
> + =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 utime =3D qh->usecs;
> + =A0 =A0 =A0 t_left =3D utime;
> + =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 done =3D 0;
> + =A0 =A0 =A0 while (done =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* At the start hcd->frame_usecs[i] =3D max=
_uframe_usecs[i]; */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (utime <=3D hcd->frame_usecs[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->frame_usecs[i] -=3D ut=
ime;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->frame_usecs[i] +=3D uti=
me;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_left -=3D utime;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 done =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 done =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/*
> + * use this for FS apps that can span multiple uframes
> + */
> +static int find_multi_uframe(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int j;
> + =A0 =A0 =A0 u16 utime;
> + =A0 =A0 =A0 int t_left;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int done;
> + =A0 =A0 =A0 u16 xtime;
> +
> + =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 utime =3D qh->usecs;
> + =A0 =A0 =A0 t_left =3D utime;
> + =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 done =3D 0;
> +loop:
> + =A0 =A0 =A0 while (done =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hcd->frame_usecs[i] <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 done =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto loop;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We need n consequtive slots so use j a=
s a start slot.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* j plus j+1 must be enough time (for no=
w)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xtime =3D hcd->frame_usecs[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D i + 1; j < 8; j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if we add this frame r=
emaining time to xtime we may
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* be OK, if not we need =
to test j for a complete frame.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((xtime + hcd->frame_use=
cs[j]) < utime) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hcd->fr=
ame_usecs[j] < max_uframe_usecs[j]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 j =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (xtime >=3D utime) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 j =3D 8; =
=A0/* stop loop with a good value ret */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* add the frame time to x =
time */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xtime +=3D hcd->frame_usecs=
[j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we must have a fully ava=
ilable next frame or break */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((xtime < utime) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (hcd->frame_usecs[j=
] =3D=3D max_uframe_usecs[j])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 j =3D 8; =
=A0/* stop loop with a bad value ret */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_left =3D utime;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D i; (t_left > 0) =
&& (j < 8); j++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t_left -=3D=
 hcd->frame_usecs[j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t_left =
<=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 qh->frame_usecs[j] +=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hcd->frame_usecs[j] + t_left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hcd->frame_usecs[j] =3D -t_left;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 done =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 qh->frame_usecs[j] +=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hcd->frame_usecs[j];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 hcd->frame_usecs[j] =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 done =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int find_uframe(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 int ret =3D -1;
> +
> + =A0 =A0 =A0 if (qh->speed =3D=3D USB_SPEED_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if this is a hs transaction we need a fu=
ll frame */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D find_single_uframe(hcd, qh);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FS transaction may need a sequence of fr=
ames */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D find_multi_uframe(hcd, qh);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * Checks that the max transfer size allowed in a host channel is large =
enough
> + * to handle the maximum data transfer in a single (micro)frame for a pe=
riodic
> + * transfer.
> + */
> +static int check_max_xfer_size(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 int status =3D 0;
> + =A0 =A0 =A0 u32 max_xfer_size;
> + =A0 =A0 =A0 u32 max_channel_xfer_size;
> +
> + =A0 =A0 =A0 max_xfer_size =3D dwc_max_packet(qh->maxp) * dwc_hb_mult(qh=
->maxp);
> + =A0 =A0 =A0 max_channel_xfer_size =3D hcd->core_if->core_params->max_tr=
ansfer_size;
> +
> + =A0 =A0 =A0 if (max_xfer_size > max_channel_xfer_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_notice("%s: Periodic xfer length %d > ma=
x xfer "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "length for channel %d\=
n", __func__, max_xfer_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_channel_xfer_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOSPC;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return status;
> +}
> +
> +/**
> + * Schedules an interrupt or isochronous transfer in the periodic schedu=
le.
> + */
> +static int schedule_periodic(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 int status;
> + =A0 =A0 =A0 struct usb_bus *bus =3D hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))=
;
> + =A0 =A0 =A0 int frame;
> +
> + =A0 =A0 =A0 status =3D find_uframe(hcd, qh);
> + =A0 =A0 =A0 frame =3D -1;
> + =A0 =A0 =A0 if (status =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame =3D 7;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame =3D status - 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Set the new frame up */
> + =A0 =A0 =A0 if (frame > -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame &=3D ~0x7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame |=3D (frame & 7);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (status !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D 0;
> + =A0 =A0 =A0 if (status) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_notice("%s: Insufficient periodic bandwi=
dth for "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "periodic transfer.\n",=
 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 status =3D check_max_xfer_size(hcd, qh);
> + =A0 =A0 =A0 if (status) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_notice("%s: Channel max transfer size to=
o small "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for periodic transfer.=
\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Always start in the inactive schedule. */
> + =A0 =A0 =A0 list_add_tail(&qh->qh_list_entry, &hcd->periodic_sched_inac=
tive);
> +
> + =A0 =A0 =A0 /* Update claimed usecs per (micro)frame. */
> + =A0 =A0 =A0 hcd->periodic_usecs +=3D qh->usecs;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Update average periodic bandwidth claimed and # period=
ic reqs for
> + =A0 =A0 =A0 =A0* usbfs.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 bus->bandwidth_allocated +=3D qh->usecs / qh->interval;
> +
> + =A0 =A0 =A0 if (qh->ep_type =3D=3D USB_ENDPOINT_XFER_INT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->bandwidth_int_reqs++;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->bandwidth_isoc_reqs++;
> +
> + =A0 =A0 =A0 return status;
> +}
> +
> +/**
> + * This function adds a QH to either the non periodic or periodic schedu=
le if
> + * it is not already in the schedule. If the QH is already in the schedu=
le, no
> + * action is taken.
> + */
> +static int dwc_otg_hcd_qh_add(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 int status =3D 0;
> +
> + =A0 =A0 =A0 /* QH may already be in a schedule. */
> + =A0 =A0 =A0 if (!list_empty(&qh->qh_list_entry))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Add the new QH to the appropriate schedule. For non-pe=
riodic, always
> + =A0 =A0 =A0 =A0* start in the inactive schedule.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (dwc_qh_is_non_per(qh))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&qh->qh_list_entry,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hcd->non_perio=
dic_sched_inactive);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D schedule_periodic(hcd, qh);
> +
> +done:
> + =A0 =A0 =A0 return status;
> +}
> +
> +/**
> + * This function adds a QH to the non periodic deferred schedule.
> + *
> + * @return 0 if successful, negative error code otherwise.
> + */
> +static int dwc_otg_hcd_qh_add_deferred(struct dwc_hcd *hcd, struct dwc_q=
h *qh)
> +{
> + =A0 =A0 =A0 if (!list_empty(&qh->qh_list_entry))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* QH already in a schedule. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> +
> + =A0 =A0 =A0 /* Add the new QH to the non periodic deferred schedule */
> + =A0 =A0 =A0 if (dwc_qh_is_non_per(qh))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&qh->qh_list_entry,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hcd->non_perio=
dic_sched_deferred);
> +done:
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * Removes an interrupt or isochronous transfer from the periodic schedu=
le.
> + */
> +static void deschedule_periodic(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 struct usb_bus *bus =3D hcd_to_bus(dwc_otg_hcd_to_hcd(hcd))=
;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 list_del_init(&qh->qh_list_entry);
> + =A0 =A0 =A0 /* Update claimed usecs per (micro)frame. */
> + =A0 =A0 =A0 hcd->periodic_usecs -=3D qh->usecs;
> + =A0 =A0 =A0 for (i =3D 0; i < 8; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->frame_usecs[i] +=3D qh->frame_usecs[i]=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->frame_usecs[i] =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Update average periodic bandwidth claimed and # period=
ic reqs for
> + =A0 =A0 =A0 =A0* usbfs.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 bus->bandwidth_allocated -=3D qh->usecs / qh->interval;
> +
> + =A0 =A0 =A0 if (qh->ep_type =3D=3D USB_ENDPOINT_XFER_INT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->bandwidth_int_reqs--;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->bandwidth_isoc_reqs--;
> +}
> +
> +/**
> + * Removes a QH from either the non-periodic or periodic schedule. =A0Me=
mory is
> + * not freed.
> + */
> +void dwc_otg_hcd_qh_remove(struct dwc_hcd *hcd, struct dwc_qh *qh)
> +{
> + =A0 =A0 =A0 /* Do nothing if QH is not in a schedule */
> + =A0 =A0 =A0 if (list_empty(&qh->qh_list_entry))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (dwc_qh_is_non_per(qh)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hcd->non_periodic_qh_ptr =3D=3D &qh->qh=
_list_entry)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->non_periodic_qh_ptr =
=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->non_periodic_q=
h_ptr->next;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&qh->qh_list_entry);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deschedule_periodic(hcd, qh);
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Defers a QH. For non-periodic QHs, removes the QH from the active
> + * non-periodic schedule. The QH is added to the deferred non-periodic
> + * schedule if any QTDs are still attached to the QH.
> + */
> +int dwc_otg_hcd_qh_deferr(struct dwc_hcd *hcd, struct dwc_qh *qh, int de=
lay)
> +{
> + =A0 =A0 =A0 int deact =3D 1;
> +
> + =A0 =A0 =A0 if (dwc_qh_is_non_per(qh)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame =3D dwc_frame_num_inc(hcd->=
frame_number, delay);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->channel =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->qtd_in_process =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deact =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_qh_remove(hcd, qh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_empty(&qh->qtd_list))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Add back to deferred non=
-periodic schedule. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_qh_add_deferred=
(hcd, qh);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return deact;
> +}
> +
> +/**
> + * =A0Schedule the next continuing periodic split transfer
> + */
> +static void sched_next_per_split_xfr(struct dwc_qh *qh, u16 fr_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
int sched_split)
> +{
> + =A0 =A0 =A0 if (sched_split) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame =3D fr_num;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc_frame_num_le(fr_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
dwc_frame_num_inc(qh->start_split_frame,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Allow one frame to ela=
pse after start split
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* microframe before sche=
duling complete split, but DONT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if we are doing the ne=
xt start split in the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* same frame for an ISOC=
 out.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (qh->ep_type !=3D USB_EN=
DPOINT_XFER_ISOC ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->ep_is_in)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_f=
rame =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc=
_frame_num_inc(qh->sched_frame, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame =3D dwc_frame_num_inc(qh->s=
tart_split_frame,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->interval);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc_frame_num_le(qh->sched_frame, fr_nu=
m))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame =3D fr_num;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame |=3D 0x7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->start_split_frame =3D qh->sched_frame;
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Deactivates a periodic QH. =A0The QH is removed from the periodic que=
ued
> + * schedule. If there are any QTDs still attached to the QH, the QH is a=
dded to
> + * either the periodic inactive schedule or the periodic ready schedule =
and its
> + * next scheduled frame is calculated. The QH is placed in the ready sch=
edule if
> + * the scheduled frame has been reached already. Otherwise it's placed i=
n the
> + * inactive schedule. If there are no QTDs attached to the QH, the QH is
> + * completely removed from the periodic schedule.
> + */
> +static void deactivate_periodic_qh(struct dwc_hcd *hcd, struct dwc_qh *q=
h,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
sched_next_split)
> +{
> + =A0 =A0 =A0 /* unsigned long flags; */
> + =A0 =A0 =A0 u16 fr_num =3D dwc_otg_hcd_get_frame_number(dwc_otg_hcd_to_=
hcd(hcd));
> +
> + =A0 =A0 =A0 if (qh->do_split) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sched_next_per_split_xfr(qh, fr_num, sched_=
next_split);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame =3D dwc_frame_num_inc(qh->s=
ched_frame,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->interval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc_frame_num_le(qh->sched_frame, fr_nu=
m))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->sched_frame =3D fr_num;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (list_empty(&qh->qtd_list)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_qh_remove(hcd, qh);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Remove from periodic_sched_queued and =
move to appropriate
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* queue.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (qh->sched_frame =3D=3D fr_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move(&qh->qh_list_entr=
y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hcd->p=
eriodic_sched_ready);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move(&qh->qh_list_entr=
y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hcd->p=
eriodic_sched_inactive);
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Deactivates a non-periodic QH. =A0Removes the QH from the active non-=
periodic
> + * schedule. The QH is added to the inactive non-periodic schedule if an=
y QTDs
> + * are still attached to the QH.
> + */
> +static void deactivate_non_periodic_qh(struct dwc_hcd *hcd, struct dwc_q=
h *qh)
> +{
> + =A0 =A0 =A0 dwc_otg_hcd_qh_remove(hcd, qh);
> + =A0 =A0 =A0 if (!list_empty(&qh->qtd_list))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_qh_add(hcd, qh);
> +}
> +
> +/**
> + * Deactivates a QH. =A0Determines if the QH is periodic or non-periodic=
 and takes
> + * the appropriate action.
> + */
> +void dwc_otg_hcd_qh_deactivate(struct dwc_hcd *hcd, struct dwc_qh *qh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int sched_ne=
xt_periodic_split)
> +{
> + =A0 =A0 =A0 if (dwc_qh_is_non_per(qh))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deactivate_non_periodic_qh(hcd, qh);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deactivate_periodic_qh(hcd, qh, sched_next_=
periodic_split);
> +}
> +
> +/**
> + * Initializes a QTD structure.
> + */
> +static void dwc_otg_hcd_qtd_init(struct dwc_qtd *qtd, struct urb *urb)
> +{
> + =A0 =A0 =A0 memset(qtd, 0, sizeof(struct dwc_qtd));
> + =A0 =A0 =A0 qtd->urb =3D urb;
> +
> + =A0 =A0 =A0 if (usb_pipecontrol(urb->pipe)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The only time the QTD data toggle is u=
sed is on the data
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* phase of control transfers. This phase=
 always starts with
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* DATA1.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->data_toggle =3D DWC_OTG_HC_PID_DATA1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->control_phase =3D DWC_OTG_CONTROL_SETU=
P;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* start split */
> + =A0 =A0 =A0 qtd->complete_split =3D 0;
> + =A0 =A0 =A0 qtd->isoc_split_pos =3D DWC_HCSPLIT_XACTPOS_ALL;
> + =A0 =A0 =A0 qtd->isoc_split_offset =3D 0;
> +
> + =A0 =A0 =A0 /* Store the qtd ptr in the urb to reference what QTD. */
> + =A0 =A0 =A0 urb->hcpriv =3D qtd;
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&qtd->qtd_list_entry);
> + =A0 =A0 =A0 return;
> +}
> +
> +/* Allocates memory for a QTD structure. */
> +static inline struct dwc_qtd *dwc_otg_hcd_qtd_alloc(gfp_t _mem_flags)
> +{
> + =A0 =A0 =A0 return kmalloc(sizeof(struct dwc_qtd), _mem_flags);
> +}
> +
> +/**
> + * This function allocates and initializes a QTD.
> + */
> +struct dwc_qtd *dwc_otg_hcd_qtd_create(struct urb *urb, gfp_t _mem_flags=
)
> +{
> + =A0 =A0 =A0 struct dwc_qtd *qtd =3D dwc_otg_hcd_qtd_alloc(_mem_flags);
> +
> + =A0 =A0 =A0 if (!qtd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 dwc_otg_hcd_qtd_init(qtd, urb);
> + =A0 =A0 =A0 return qtd;
> +}
> +
> +/**
> + * This function adds a QTD to the QTD-list of a QH. =A0It will find the=
 correct
> + * QH to place the QTD into. =A0If it does not find a QH, then it will c=
reate a
> + * new QH. If the QH to which the QTD is added is not currently schedule=
d, it
> + * is placed into the proper schedule based on its EP type.
> + *
> + */
> +int dwc_otg_hcd_qtd_add(struct dwc_qtd *qtd, struct dwc_hcd *hcd)
> +{
> + =A0 =A0 =A0 struct usb_host_endpoint *ep;
> + =A0 =A0 =A0 struct dwc_qh *qh;
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 struct urb *urb =3D qtd->urb;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Get the QH which holds the QTD-list to insert to. Crea=
te QH if it
> + =A0 =A0 =A0 =A0* doesn't exist.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ep =3D dwc_urb_to_endpoint(urb);
> +
> + =A0 =A0 =A0 qh =3D (struct dwc_qh *)ep->hcpriv;
> + =A0 =A0 =A0 if (!qh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh =3D dwc_otg_hcd_qh_create(hcd, urb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!qh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep->hcpriv =3D qh;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 qtd->qtd_qh_ptr =3D qh;
> + =A0 =A0 =A0 retval =3D dwc_otg_hcd_qh_add(hcd, qh);
> + =A0 =A0 =A0 if (!retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&qtd->qtd_list_entry, &qh->qt=
d_list);
> +
> +done:
> + =A0 =A0 =A0 return retval;
> +}
> --
> 1.6.1.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Reviewed-by: Pratyush Anand <pratyush.anand@st.com>
