Return-Path: <pratyush.anand@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 066D0B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 20:25:11 +1100 (EST)
Received: by ggnk1 with SMTP id k1so2765892ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2011 02:25:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318630139-14296-1-git-send-email-tmarri@apm.com>
References: <1318630139-14296-1-git-send-email-tmarri@apm.com>
Date: Thu, 20 Oct 2011 14:55:08 +0530
Message-ID: <CAHM4w1=+93MyC8_txOEbKN9NP1ri=98wdVzOXQCh1LWrr6EOhA@mail.gmail.com>
Subject: Re: [PATCH v15 05/10] USB/ppc4xx: Add Synopsys DWC OTG HCD interrupt
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

On Sat, Oct 15, 2011 at 3:38 AM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
>
> Implements DWC OTG USB HCD interrupt service routine.
>
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
> =A0drivers/usb/dwc/hcd_intr.c | 1477 ++++++++++++++++++++++++++++++++++++=
++++++++
> =A01 files changed, 1477 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/usb/dwc/hcd_intr.c
>
> diff --git a/drivers/usb/dwc/hcd_intr.c b/drivers/usb/dwc/hcd_intr.c
> new file mode 100644
> index 0000000..b16934d
> --- /dev/null
> +++ b/drivers/usb/dwc/hcd_intr.c
> @@ -0,0 +1,1477 @@
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
> +#include "hcd.h"
> +
> +/* This file contains the implementation of the HCD Interrupt handlers. =
=A0 =A0 =A0 =A0*/
> +static const int erratum_usb09_patched;
> +static const int deferral_on =3D 1;
> +static const int nak_deferral_delay =3D 8;
> +static const int nyet_deferral_delay =3D 1;
> +
> +/**
> + * Handles the start-of-frame interrupt in host mode. Non-periodic
> + * transactions may be queued to the DWC_otg controller for the current
> + * (micro)frame. Periodic transactions may be queued to the controller f=
or the
> + * next (micro)frame.
> + */
> +static int dwc_otg_hcd_handle_sof_intr(struct dwc_hcd *hcd)
> +{
> + =A0 =A0 =A0 u32 hfnum =3D 0;
> + =A0 =A0 =A0 struct list_head *qh_entry;
> + =A0 =A0 =A0 struct dwc_qh *qh;
> + =A0 =A0 =A0 enum dwc_transaction_type tr_type;
> + =A0 =A0 =A0 u32 gintsts =3D 0;
> +
> + =A0 =A0 =A0 hfnum =3D
> + =A0 =A0 =A0 =A0 =A0 dwc_reg_read(hcd->core_if->host_if->host_global_reg=
s,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_HFNUM);
> +
> + =A0 =A0 =A0 hcd->frame_number =3D DWC_HFNUM_FRNUM_RD(hfnum);
> +
> + =A0 =A0 =A0 /* Determine whether any periodic QHs should be executed. *=
/
> + =A0 =A0 =A0 qh_entry =3D hcd->periodic_sched_inactive.next;
> + =A0 =A0 =A0 while (qh_entry !=3D &hcd->periodic_sched_inactive) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh =3D list_entry(qh_entry, struct dwc_qh, =
qh_list_entry);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh_entry =3D qh_entry->next;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If needed, move QH to the ready list t=
o be executed next
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (micro)frame.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc_frame_num_le(qh->sched_frame, hcd->=
frame_number))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move(&qh->qh_list_entr=
y,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hcd->p=
eriodic_sched_ready);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 tr_type =3D dwc_otg_hcd_select_transactions(hcd);
> + =A0 =A0 =A0 if (tr_type !=3D DWC_OTG_TRANSACTION_NONE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_queue_transactions(hcd, tr_type=
);
> +
> + =A0 =A0 =A0 /* Clear interrupt */
> + =A0 =A0 =A0 gintsts |=3D DWC_INTMSK_STRT_OF_FRM;
> + =A0 =A0 =A0 dwc_reg_write(gintsts_reg(hcd), 0, gintsts);
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles the Rx Status Queue Level Interrupt, which indicates that the=
re is at
> + * least one packet in the Rx FIFO. =A0The packets are moved from the FI=
FO to
> + * memory if the DWC_otg controller is operating in Slave mode.
> + */
> +static int dwc_otg_hcd_handle_rx_status_q_level_intr(struct dwc_hcd *hcd=
)
> +{
> + =A0 =A0 =A0 u32 grxsts;
> + =A0 =A0 =A0 struct dwc_hc *hc;
> +
> + =A0 =A0 =A0 grxsts =3D dwc_reg_read(hcd->core_if->core_global_regs, DWC=
_GRXSTSP);
> + =A0 =A0 =A0 hc =3D hcd->hc_ptr_array[grxsts & DWC_HM_RXSTS_CHAN_NUM_RD(=
grxsts)];
> +
> + =A0 =A0 =A0 /* Packet Status */
> + =A0 =A0 =A0 switch (DWC_HM_RXSTS_PKT_STS_RD(grxsts)) {
> + =A0 =A0 =A0 case DWC_GRXSTS_PKTSTS_IN:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read the data into the host buffer. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HM_RXSTS_BYTE_CNT_RD(grxsts) > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_read_packet(hcd->co=
re_if, hc->xfer_buff,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 DWC_HM_RXSTS_BYTE_CNT_RD(grxsts));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Update the HC fields for=
 the next packet received. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->xfer_count +=3D DWC_HM_=
RXSTS_BYTE_CNT_RD(grxsts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->xfer_buff +=3D DWC_HM_R=
XSTS_BYTE_CNT_RD(grxsts);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 case DWC_GRXSTS_PKTSTS_IN_XFER_COMP:
> + =A0 =A0 =A0 case DWC_GRXSTS_PKTSTS_DATA_TOGGLE_ERR:
> + =A0 =A0 =A0 case DWC_GRXSTS_PKTSTS_CH_HALTED:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Handled in interrupt, just ignore data *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("RX_STS_Q Interrupt: Unknown status =
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_HM_RXSTS_PKT_STS_RD(grxs=
ts));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * This interrupt occurs when the non-periodic Tx FIFO is half-empty. Mo=
re
> + * data packets may be written to the FIFO for OUT transfers. More reque=
sts
> + * may be written to the non-periodic request queue for IN transfers. Th=
is
> + * interrupt is enabled only in Slave mode.
> + */
> +static int dwc_otg_hcd_handle_np_tx_fifo_empty_intr(struct dwc_hcd *hcd)
> +{
> + =A0 =A0 =A0 dwc_otg_hcd_queue_transactions(hcd, DWC_OTG_TRANSACTION_NON=
_PERIODIC);
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * This interrupt occurs when the periodic Tx FIFO is half-empty. More d=
ata
> + * packets may be written to the FIFO for OUT transfers. More requests m=
ay be
> + * written to the periodic request queue for IN transfers. This interrup=
t is
> + * enabled only in Slave mode.
> + */
> +static int dwc_otg_hcd_handle_perio_tx_fifo_empty_intr(struct dwc_hcd *h=
cd)
> +{
> + =A0 =A0 =A0 dwc_otg_hcd_queue_transactions(hcd, DWC_OTG_TRANSACTION_PER=
IODIC);
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * When the port changes to enabled it may be necessary to adjust the ph=
y clock
> + * speed.
> + */
> +static int adjusted_phy_clock_speed(struct dwc_hcd *hcd, u32 hprt0)
> +{
> + =A0 =A0 =A0 int adjusted =3D 0;
> + =A0 =A0 =A0 u32 usbcfg;
> + =A0 =A0 =A0 ulong global_regs =3D hcd->core_if->core_global_regs;
> + =A0 =A0 =A0 struct core_params *params =3D hcd->core_if->core_params;
> + =A0 =A0 =A0 ulong h_regs =3D hcd->core_if->host_if->host_global_regs;
> +
> + =A0 =A0 =A0 usbcfg =3D dwc_reg_read(global_regs, DWC_GUSBCFG);
> +
> + =A0 =A0 =A0 if (DWC_HPRT0_PRT_SPD_RD(hprt0) =3D=3D DWC_HPRT0_PRTSPD_LOW=
_SPEED ||
> + =A0 =A0 =A0 =A0 =A0 DWC_HPRT0_PRT_SPD_RD(hprt0) =3D=3D DWC_HPRT0_PRTSPD=
_FULL_SPEED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Low power */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 hcfg;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(usbcfg & DWC_USBCFG_PHYLPWRCLKSEL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set PHY low power clock =
select for FS/LS devices */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbcfg |=3D DWC_USBCFG_PHYL=
PWRCLKSEL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_write(global_regs, =
DWC_GUSBCFG, usbcfg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjusted =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcfg =3D dwc_reg_read(h_regs, DWC_HCFG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HPRT0_PRT_SPD_RD(hprt0) =3D=3D DWC_=
HPRT0_PRTSPD_LOW_SPEED &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 params->host_ls_low_power_phy_clk =
=3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DWC_HOST_LS_LOW_POWER_PHY_CLK_PARAM=
_6MHZ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 6 MHZ, check for 6 MHZ c=
lock select */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HCFG_FSLSP_CLK_RD(h=
cfg) !=3D DWC_HCFG_6_MHZ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcfg =3D DW=
C_HCFG_FSLSP_CLK_RW(hcfg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_HCFG_6_MHZ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_wri=
te(h_regs, DWC_HCFG, hcfg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjusted =
=3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (DWC_HCFG_FSLSP_CLK_RD(hcfg) !=3D=
 DWC_HCFG_48_MHZ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 48 MHZ and clock select =
is not 48 MHZ */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcfg =3D DWC_HCFG_FSLSP_CLK=
_RW(hcfg, DWC_HCFG_48_MHZ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_write(h_regs, DWC_H=
CFG, hcfg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjusted =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else if (usbcfg & DWC_USBCFG_PHYLPWRCLKSEL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usbcfg &=3D ~((u32) DWC_USBCFG_PHYLPWRCLKSE=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_write(global_regs, DWC_GUSBCFG, usb=
cfg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 adjusted =3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (adjusted)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_work(&hcd->usb_port_reset);
> +
> + =A0 =A0 =A0 return adjusted;
> +}
> +
> +/**
> + * Helper function to handle the port enable changed interrupt when the =
port
> + * becomes enabled. =A0Checks if we need to adjust the PHY clock speed f=
or low
> + * power and =A0adjusts it if needed.
> + */
> +static void port_enabled(struct dwc_hcd *hcd, u32 hprt0)
> +{
> + =A0 =A0 =A0 if (hcd->core_if->core_params->host_support_fs_ls_low_power=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!adjusted_phy_clock_speed(hcd, hprt0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->flags.b.port_reset_cha=
nge =3D 1;
> +}
> +
> +/**
> + * There are multiple conditions that can cause a port interrupt. This f=
unction
> + * determines which interrupt conditions have occurred and handles them
> + * appropriately.
> + */
> +static int dwc_otg_hcd_handle_port_intr(struct dwc_hcd *hcd)
> +{
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 u32 hprt0;
> + =A0 =A0 =A0 u32 hprt0_modify;
> +
> + =A0 =A0 =A0 hprt0 =3D dwc_reg_read(hcd->core_if->host_if->hprt0, 0);
> + =A0 =A0 =A0 hprt0_modify =3D dwc_reg_read(hcd->core_if->host_if->hprt0,=
 0);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Clear appropriate bits in HPRT0 to clear the interrupt=
 bit in
> + =A0 =A0 =A0 =A0* GINTSTS
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 hprt0_modify =3D DWC_HPRT0_PRT_ENA_RW(hprt0_modify, 0);
> + =A0 =A0 =A0 hprt0_modify =3D DWC_HPRT0_PRT_CONN_DET_RW(hprt0_modify, 0)=
;
> + =A0 =A0 =A0 hprt0_modify =3D DWC_HPRT0_PRT_ENA_DIS_CHG_RW(hprt0_modify,=
 0);
> + =A0 =A0 =A0 hprt0_modify =3D DWC_HPRT0_PRT_OVRCURR_CHG_RW(hprt0_modify,=
 0);
> +
> + =A0 =A0 =A0 /* Port connect detected interrupt */
> + =A0 =A0 =A0 if (DWC_HPRT0_PRT_CONN_DET_RD(hprt0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the status flags and clear interrupt=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->flags.b.port_connect_status_change =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->flags.b.port_connect_status =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hprt0_modify =3D DWC_HPRT0_PRT_CONN_DET_RW(=
hprt0_modify, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* B-Device has connected, Delete the conne=
ction timer. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer_sync(&hcd->conn_timer);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The Hub driver asserts a reset when it=
 sees port connect
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* status change flag
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Port enable changed interrupt */
> + =A0 =A0 =A0 if (DWC_HPRT0_PRT_ENA_DIS_CHG_RD(hprt0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Set the internal flag if the port was di=
sabled */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HPRT0_PRT_ENA_RD(hprt0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port_enabled(hcd, hprt0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->flags.b.port_enable_ch=
ange =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clear the interrupt */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hprt0_modify =3D DWC_HPRT0_PRT_ENA_DIS_CHG_=
RW(hprt0_modify, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Overcurrent change interrupt */
> + =A0 =A0 =A0 if (DWC_HPRT0_PRT_OVRCURR_CHG_RD(hprt0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcd->flags.b.port_over_current_change =3D 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hprt0_modify =3D DWC_HPRT0_PRT_OVRCURR_CHG_=
RW(hprt0_modify, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Clear the port interrupts */
> + =A0 =A0 =A0 dwc_reg_write(hcd->core_if->host_if->hprt0, 0, hprt0_modify=
);
> + =A0 =A0 =A0 return retval;
> +}
> +
> +/**
> + * Gets the actual length of a transfer after the transfer halts. halt_s=
tatus
> + * holds the reason for the halt.
> + *
> + * For IN transfers where halt_status is DWC_OTG_HC_XFER_COMPLETE, _shor=
t_read
> + * is set to 1 upon return if less than the requested number of bytes we=
re
> + * transferred. Otherwise, _short_read is set to 0 upon return. _short_r=
ead may
> + * also be NULL on entry, in which case it remains unchanged.
> + */
> +static u32 get_actual_xfer_length(struct dwc_hc *hc, ulong regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum dw=
c_halt_status halt_status,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *_s=
hort_read)
> +{
> + =A0 =A0 =A0 u32 hctsiz =3D 0;
> + =A0 =A0 =A0 u32 length;
> +
> + =A0 =A0 =A0 if (_short_read)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *_short_read =3D 0;
> +
> + =A0 =A0 =A0 hctsiz =3D dwc_reg_read(regs, DWC_HCTSIZ);
> + =A0 =A0 =A0 if (halt_status =3D=3D DWC_OTG_HC_XFER_COMPLETE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->ep_is_in) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D hc->xfer_len - D=
WC_HCTSIZ_XFER_SIZE_RD(hctsiz);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (_short_read)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *_short_rea=
d =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DW=
C_HCTSIZ_XFER_SIZE_RD(hctsiz) !=3D 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (hc->qh->do_split) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D qtd->ssplit_out_=
xfer_count;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D hc->xfer_len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Must use the hctsiz.pktcnt field to de=
termine how much data
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* has been transferred. This field refle=
cts the number of
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* packets that have been transferred via=
 the USB. This is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* always an integral number of packets i=
f the transfer was
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* halted before its normal completion. (=
Can't use the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* hctsiz.xfersize field because that ref=
lects the number of
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* bytes transferred via the AHB, not the=
 USB).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D (hc->start_pkt_count - DWC_HCTSI=
Z_PKT_CNT_RD(hctsiz)) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->max_packet;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return length;
> +}
> +
> +/**
> + * Updates the state of the URB after a Transfer Complete interrupt on t=
he
> + * host channel. Updates the actual_length field of the URB based on the
> + * number of bytes transferred via the host channel. Sets the URB status
> + * if the data transfer is finished.
> + */
> +static int update_urb_state_xfer_comp(struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ulong regs, struct urb *urb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct dwc_qtd *qtd, int *status)
> +{
> + =A0 =A0 =A0 int xfer_done =3D 0;
> + =A0 =A0 =A0 int short_read =3D 0;
> +
> + =A0 =A0 =A0 urb->actual_length +=3D get_actual_xfer_length(hc, regs, qt=
d,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_OTG_HC_XFER_COMPLETE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&short_read);
> +
> + =A0 =A0 =A0 if (short_read || urb->actual_length =3D=3D urb->transfer_b=
uffer_length) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xfer_done =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (short_read && (urb->transfer_flags & UR=
B_SHORT_NOT_OK))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *status =3D -EREMOTEIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *status =3D 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return xfer_done;
> +}
> +
> +/*
> + * Save the starting data toggle for the next transfer. The data toggle =
is
> + * saved in the QH for non-control transfers and it's saved in the QTD f=
or
> + * control transfers.
> + */
> +static void save_data_toggle(struct dwc_hc *hc, ulong regs, struct dwc_q=
td *qtd)
> +{
> + =A0 =A0 =A0 u32 hctsiz =3D 0;
> + =A0 =A0 =A0 hctsiz =3D dwc_reg_read(regs, DWC_HCTSIZ);
> +
> + =A0 =A0 =A0 if (hc->ep_type !=3D DWC_OTG_EP_TYPE_CONTROL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dwc_qh *qh =3D hc->qh;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HCTSIZ_PKT_PID_RD(hctsiz) =3D=3D DW=
C_HCTSIZ_DATA0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->data_toggle =3D DWC_OTG=
_HC_PID_DATA0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh->data_toggle =3D DWC_OTG=
_HC_PID_DATA1;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HCTSIZ_PKT_PID_RD(hctsiz) =3D=3D DW=
C_HCTSIZ_DATA0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->data_toggle =3D DWC_OT=
G_HC_PID_DATA0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->data_toggle =3D DWC_OT=
G_HC_PID_DATA1;
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Frees the first QTD in the QH's list if free_qtd is 1. For non-period=
ic
> + * QHs, removes the QH from the active non-periodic schedule. If any QTD=
s are
> + * still linked to the QH, the QH is added to the end of the inactive
> + * non-periodic schedule. For periodic QHs, removes the QH from the peri=
odic
> + * schedule if no more QTDs are linked to the QH.
> + */
> +static void deactivate_qh(struct dwc_hcd *hcd, struct dwc_qh *qh, int fr=
ee_qtd)
> +{
> + =A0 =A0 =A0 int continue_split =3D 0;
> + =A0 =A0 =A0 struct dwc_qtd *qtd;
> +
> + =A0 =A0 =A0 qtd =3D list_entry(qh->qtd_list.next, struct dwc_qtd, qtd_l=
ist_entry);
> + =A0 =A0 =A0 if (qtd->complete_split)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue_split =3D 1;
> + =A0 =A0 =A0 else if (qtd->isoc_split_pos =3D=3D DWC_HCSPLIT_XACTPOS_MID=
 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0qtd->isoc_split_pos =3D=3D DWC_HCSPLIT_X=
ACTPOS_END)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue_split =3D 1;
> +
> + =A0 =A0 =A0 if (free_qtd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_qtd_remove(qtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue_split =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 qh->channel =3D NULL;
> + =A0 =A0 =A0 qh->qtd_in_process =3D NULL;
> + =A0 =A0 =A0 dwc_otg_hcd_qh_deactivate(hcd, qh, continue_split);
> +}
> +
> +/**
> + * Updates the state of an Isochronous URB when the transfer is stopped =
for
> + * any reason. The fields of the current entry in the frame descriptor a=
rray
> + * are set based on the transfer state and the input status. Completes t=
he
> + * Isochronous URB if all the URB frames have been completed.
> + */
> +static enum dwc_halt_status update_isoc_urb_state(struct dwc_hcd *hcd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct dwc_hc *hc, u32 regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 enum dwc_halt_status status)
> +{
> + =A0 =A0 =A0 struct urb *urb =3D qtd->urb;
> + =A0 =A0 =A0 enum dwc_halt_status ret_val =3D status;
> + =A0 =A0 =A0 struct usb_iso_packet_descriptor *frame_desc;
> + =A0 =A0 =A0 frame_desc =3D &urb->iso_frame_desc[qtd->isoc_frame_index];
> +
> + =A0 =A0 =A0 switch (status) {
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_COMPLETE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->status =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->actual_length =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_actual_xfer_length(hc, regs, qt=
d, status, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_FRAME_OVERRUN:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->error_count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->ep_is_in)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->status =3D -ENO=
SR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->status =3D -ECO=
MM;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->actual_length =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_BABBLE_ERR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Don't need to update actual_length in th=
is case. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->error_count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->status =3D -EOVERFLOW;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_XACT_ERR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->error_count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->status =3D -EPROTO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc->actual_length =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_actual_xfer_length(hc, regs, qt=
d, status, NULL);
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Unhandled halt_status (%d)\n", =
__func__, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (++qtd->isoc_frame_index =3D=3D urb->number_of_packets) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* urb->status is not used for isoc trans=
fers.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The individual frame_desc statuses are=
 used instead.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hcd, urb, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_val =3D DWC_OTG_HC_XFER_URB_COMPLETE;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_val =3D DWC_OTG_HC_XFER_COMPLETE;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret_val;
> +}
> +
> +/**
> + * Releases a host channel for use by other transfers. Attempts to selec=
t and
> + * queue more transactions since at least one host channel is available.
> + */
> +static void release_channel(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dwc_qtd *qtd=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum dwc_halt_statu=
s halt_status, int *must_free)
> +{
> + =A0 =A0 =A0 enum dwc_transaction_type tr_type;
> + =A0 =A0 =A0 int free_qtd;
> + =A0 =A0 =A0 int deact =3D 1;
> + =A0 =A0 =A0 struct dwc_qh *qh;
> + =A0 =A0 =A0 int retry_delay =3D 1;
> +
> + =A0 =A0 =A0 switch (halt_status) {
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_NYET:
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_NAK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (halt_status =3D=3D DWC_OTG_HC_XFER_NYET=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retry_delay =3D nyet_deferr=
al_delay;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retry_delay =3D nak_deferra=
l_delay;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_qtd =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (deferral_on && hc->do_split) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qh =3D hc->qh;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (qh)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 deact =3D d=
wc_otg_hcd_qh_deferr(hcd, qh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retry_delay);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_URB_COMPLETE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_qtd =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_AHB_ERR:
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_STALL:
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_BABBLE_ERR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_qtd =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_XACT_ERR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (qtd->error_count >=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_qtd =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hc=
d, qtd->urb, -EPROTO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_qtd =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_URB_DEQUEUE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The QTD has already been removed and t=
he QH has been
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* deactivated. Don't want to do anything=
 except release the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* host channel and try to queue more tra=
nsfers.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cleanup;
> + =A0 =A0 =A0 case DWC_OTG_HC_XFER_NO_HALT_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No halt_status, channel %d\n", =
__func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hc->hc_num);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_qtd =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_qtd =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (free_qtd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* must_free pre-initialized to zero */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *must_free =3D 1;
> + =A0 =A0 =A0 if (deact)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deactivate_qh(hcd, hc->qh, free_qtd);
> +
> +cleanup:
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Release the host channel for use by other transfers. T=
he cleanup
> + =A0 =A0 =A0 =A0* function clears the channel interrupt enables and cond=
itions, so
> + =A0 =A0 =A0 =A0* there's no need to clear the Channel Halted interrupt =
separately.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dwc_otg_hc_cleanup(hcd->core_if, hc);
> + =A0 =A0 =A0 list_add_tail(&hc->hc_list_entry, &hcd->free_hc_list);
> + =A0 =A0 =A0 hcd->available_host_channels++;
> + =A0 =A0 =A0 /* Try to queue more transfers now that there's a free chan=
nel. */
> + =A0 =A0 =A0 if (!erratum_usb09_patched) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tr_type =3D dwc_otg_hcd_select_transactions=
(hcd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tr_type !=3D DWC_OTG_TRANSACTION_NONE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_queue_transacti=
ons(hcd, tr_type);
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Halts a host channel. If the channel cannot be halted immediately bec=
ause
> + * the request queue is full, this function ensures that the FIFO empty
> + * interrupt for the appropriate queue is enabled so that the halt reque=
st can
> + * be queued when there is space in the request queue.
> + *
> + * This function may also be called in DMA mode. In that case, the chann=
el is
> + * simply released since the core always halts the channel automatically=
 in
> + * DMA mode.
> + */
> +static void halt_channel(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dwc_qtd *qtd, enu=
m dwc_halt_status halt_status,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *must_free)
> +{
> + =A0 =A0 =A0 if (hcd->core_if->dma_enable) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_channel(hcd, hc, qtd, halt_status, =
must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Slave mode processing... */
> + =A0 =A0 =A0 dwc_otg_hc_halt(hcd->core_if, hc, halt_status);
> + =A0 =A0 =A0 if (hc->halt_on_queue) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 gintmsk =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->ep_type =3D=3D DWC_OTG_EP_TYPE_CONT=
ROL ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->ep_type =3D=3D DWC_OTG_EP_TYPE_=
BULK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Make sure the Non-peri=
odic Tx FIFO empty interrupt
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is enabled so that the=
 non-periodic schedule will
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* be processed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gintmsk |=3D DWC_INTMSK_NP_=
TXFIFO_EMPT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_modify(gintmsk_reg(=
hcd), 0, 0, gintmsk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Move the QH from the p=
eriodic queued schedule to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the periodic assigned =
schedule. This allows the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* halt to be queued when=
 the periodic schedule is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move(&hc->qh->qh_list_=
entry,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &hcd->p=
eriodic_sched_assigned);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Make sure the Periodic=
 Tx FIFO Empty interrupt is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* enabled so that the pe=
riodic schedule will be
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gintmsk |=3D DWC_INTMSK_P_T=
XFIFO_EMPTY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_modify(gintmsk_reg(=
hcd), 0, 0, gintmsk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Performs common cleanup for non-periodic transfers after a Transfer
> + * Complete interrupt. This function should be called after any endpoint=
 type
> + * specific handling is finished to release the host channel.
> + */
> +static void complete_non_periodic_xfer(struct dwc_hcd *hcd, struct dwc_h=
c *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0ulong regs, struct dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0enum dwc_halt_status halt_status,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0int *must_free)
> +{
> + =A0 =A0 =A0 u32 hcint;
> +
> + =A0 =A0 =A0 qtd->error_count =3D 0;
> + =A0 =A0 =A0 hcint =3D dwc_reg_read(regs, DWC_HCINT);
> + =A0 =A0 =A0 if (DWC_HCINT_NYET_RESP_REC_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 hcint_clear =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcint_clear =3D DWC_HCINT_NYET_RESP_REC_RW(=
hcint_clear, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Got a NYET on the last transaction of =
the transfer. This
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* means that the endpoint should be in t=
he PING state at the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* beginning of the next transfer.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->qh->ping_state =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_reg_write(regs, DWC_HCINT, hcint_clear)=
;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Always halt and release the host channel to make it av=
ailable for
> + =A0 =A0 =A0 =A0* more transfers. There may still be more phases for a c=
ontrol
> + =A0 =A0 =A0 =A0* transfer or more data packets for a bulk transfer at t=
his point,
> + =A0 =A0 =A0 =A0* but the host channel is still halted. A channel will b=
e reassigned
> + =A0 =A0 =A0 =A0* to the transfer when the non-periodic schedule is proc=
essed after
> + =A0 =A0 =A0 =A0* the channel is released. This allows transactions to b=
e queued
> + =A0 =A0 =A0 =A0* properly via dwc_otg_hcd_queue_transactions, which als=
o enables the
> + =A0 =A0 =A0 =A0* Tx FIFO Empty interrupt if necessary.
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* IN transfers in Slave mode require an explicit disable=
 to
> + =A0 =A0 =A0 =A0* halt the channel. (In DMA mode, this call simply relea=
ses
> + =A0 =A0 =A0 =A0* the channel.)
> + =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 =A0* The channel is automatically disabled by the core for =
OUT
> + =A0 =A0 =A0 =A0* transfers in Slave mode.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (hc->ep_is_in)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, halt_status, mus=
t_free);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_channel(hcd, hc, qtd, halt_status, =
must_free);
> +}
> +
> +/**
> + * Performs common cleanup for periodic transfers after a Transfer Compl=
ete
> + * interrupt. This function should be called after any endpoint type spe=
cific
> + * handling is finished to release the host channel.
> + */
> +static void complete_periodic_xfer(struct dwc_hcd *hcd, struct dwc_hc *h=
c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ulon=
g regs, struct dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum=
 dwc_halt_status halt_status,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
*must_free)
> +{
> + =A0 =A0 =A0 u32 hctsiz =3D 0;
> +
> + =A0 =A0 =A0 hctsiz =3D dwc_reg_read(regs, DWC_HCTSIZ);
> + =A0 =A0 =A0 qtd->error_count =3D 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* For OUT transfers and 0 packet count, the Core halts t=
he channel,
> + =A0 =A0 =A0 =A0* otherwise, Flush any outstanding requests from the Tx =
queue.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!hc->ep_is_in || (DWC_HCTSIZ_PKT_CNT_RD(hctsiz) =3D=3D =
0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_channel(hcd, hc, qtd, halt_status, =
must_free);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, halt_status, mus=
t_free);
> +}
> +
> +/**
> + * Handles a host channel Transfer Complete interrupt. This handler may =
be
> + * called in either DMA mode or Slave mode.
> + */
> +static int handle_hc_xfercomp_intr(struct dwc_hcd *hcd, struct dwc_hc *h=
c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ulon=
g regs, struct dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
*must_free)
> +{
> + =A0 =A0 =A0 int urb_xfer_done;
> + =A0 =A0 =A0 enum dwc_halt_status halt_status =3D DWC_OTG_HC_XFER_COMPLE=
TE;
> + =A0 =A0 =A0 struct urb *urb =3D qtd->urb;
> + =A0 =A0 =A0 int pipe_type =3D usb_pipetype(urb->pipe);
> + =A0 =A0 =A0 int status =3D -EINPROGRESS;
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 /* Handle xfer complete on CSPLIT. */
> + =A0 =A0 =A0 if (hc->qh->do_split)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->complete_split =3D 0;
> +
> + =A0 =A0 =A0 /* Update the QTD and URB states. */
> + =A0 =A0 =A0 switch (pipe_type) {
> + =A0 =A0 =A0 case PIPE_CONTROL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (qtd->control_phase) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case DWC_OTG_CONTROL_SETUP:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (urb->transfer_buffer_le=
ngth > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->contro=
l_phase =3D DWC_OTG_CONTROL_DATA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->contro=
l_phase =3D DWC_OTG_CONTROL_STATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_status =3D DWC_OTG_HC_=
XFER_COMPLETE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case DWC_OTG_CONTROL_DATA:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb_xfer_done =3D update_ur=
b_state_xfer_comp(hc, regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urb, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (urb_xfer_done)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->contro=
l_phase =3D DWC_OTG_CONTROL_STATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_data_t=
oggle(hc, regs, qtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_status =3D DWC_OTG_HC_=
XFER_COMPLETE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case DWC_OTG_CONTROL_STATUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status =3D=3D -EINPROGR=
ESS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hc=
d, urb, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_status =3D DWC_OTG_HC_=
XFER_URB_COMPLETE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete_non_periodic_xfer(hcd, hc, regs, q=
td,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0halt_status, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_BULK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb_xfer_done =3D update_urb_state_xfer_com=
p(hc, regs, urb, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (urb_xfer_done) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hc=
d, urb, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_status =3D DWC_OTG_HC_=
XFER_URB_COMPLETE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_status =3D DWC_OTG_HC_=
XFER_COMPLETE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_data_toggle(hc, regs, qtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete_non_periodic_xfer(hcd, hc, regs, q=
td,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0halt_status, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_INTERRUPT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_urb_state_xfer_comp(hc, regs, urb, q=
td, &status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Interrupt URB is done on the first tra=
nsfer complete
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* interrupt.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hcd, urb, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_data_toggle(hc, regs, qtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete_periodic_xfer(hcd, hc, regs, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0DWC_OTG_HC_XFER_URB_COMPLETE, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_ISOCHRONOUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (qtd->isoc_split_pos =3D=3D DWC_HCSPLIT_=
XACTPOS_ALL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_status =3D update_isoc=
_urb_state(hcd, hc, regs, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DWC_OTG_HC_XFER_COMPLETE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete_periodic_xfer(hcd, hc, regs, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0halt_status, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* disable xfercompl */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_TXFER_CMPL_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host channel STALL interrupt. This handler may be called in
> + * either DMA mode or Slave mode.
> + */
> +static int handle_hc_stall_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 regs, s=
truct dwc_qtd *qtd, int *must_free)
> +{
> + =A0 =A0 =A0 struct urb *urb =3D qtd->urb;
> + =A0 =A0 =A0 int pipe_type =3D usb_pipetype(urb->pipe);
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 if (pipe_type =3D=3D PIPE_CONTROL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EP=
IPE);
> +
> + =A0 =A0 =A0 if (pipe_type =3D=3D PIPE_BULK || pipe_type =3D=3D PIPE_INT=
ERRUPT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EP=
IPE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* USB protocol requires resetting the da=
ta toggle for bulk
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and interrupt endpoints when a CLEAR_F=
EATURE(ENDPOINT_HALT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* setup command is issued to the endpoin=
t. Anticipate the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* CLEAR_FEATURE command since a STALL ha=
s occurred and reset
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the data toggle now.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->qh->data_toggle =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_STALL, must_free=
);
> + =A0 =A0 =A0 /* disable stall */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_STALL_RESP_REC_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Updates the state of the URB when a transfer has been stopped due to =
an
> + * abnormal condition before the transfer completes. Modifies the
> + * actual_length field of the URB to reflect the number of bytes that ha=
ve
> + * actually been transferred via the host channel.
> + */
> +static void update_urb_state_xfer_intr(struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0u32 regs, struct urb *urb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0enum dwc_halt_status sts)
> +{
> + =A0 =A0 =A0 u32 xfr_len =3D get_actual_xfer_length(hc, regs, qtd, sts, =
NULL);
> + =A0 =A0 =A0 urb->actual_length +=3D xfr_len;
> +}
> +
> +/**
> + * Handles a host channel NAK interrupt. This handler may be called in e=
ither
> + * DMA mode or Slave mode.
> + */
> +static int handle_hc_nak_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 regs, struc=
t dwc_qtd *qtd, int *must_free)
> +{
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Handle NAK for IN/OUT SSPLIT/CSPLIT transfers, bulk, c=
ontrol, and
> + =A0 =A0 =A0 =A0* interrupt. =A0Re-start the SSPLIT transfer.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (hc->do_split) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->complete_split)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->complete_split =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_=
NAK, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto handle_nak_done;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 switch (usb_pipetype(qtd->urb->pipe)) {
> + =A0 =A0 =A0 case PIPE_CONTROL:
> + =A0 =A0 =A0 case PIPE_BULK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hcd->core_if->dma_enable && hc->ep_is_i=
n) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* NAK interrupts are ena=
bled on bulk/control IN
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transfers in DMA mode =
for the sole purpose of
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* resetting the error co=
unt after a transaction error
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* occurs. The core will =
continue transferring data.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto handle_nak_done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* NAK interrupts normally occur during O=
UT transfers in DMA
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* or Slave mode. For IN transfers, more =
requests will be
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* queued as request queue space is avail=
able.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hc->qh->ping_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_urb_state_xfer_intr(=
hc, regs, qtd->urb, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_OTG_HC_XFER_NAK);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_data_toggle(hc, regs, =
qtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (qtd->urb->dev->speed =
=3D=3D USB_SPEED_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->qh->pin=
g_state =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Halt the channel so the transfer can b=
e re-started from
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the appropriate point or the PING prot=
ocol will
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* start/continue.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_=
NAK, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_INTERRUPT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_=
NAK, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_ISOCHRONOUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Should never get called for isochronous =
transfers. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> +handle_nak_done:
> + =A0 =A0 =A0 /* disable nak */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_NAK_RESP_REC_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Helper function for handle_hc_ack_intr(). =A0Sets the split values fo=
r an ACK
> + * on SSPLIT for ISOC OUT.
> + */
> +static void set_isoc_out_vals(struct dwc_hc *hc, struct dwc_qtd *qtd)
> +{
> + =A0 =A0 =A0 struct usb_iso_packet_descriptor *frame_desc;
> +
> + =A0 =A0 =A0 switch (hc->xact_pos) {
> + =A0 =A0 =A0 case DWC_HCSPLIT_XACTPOS_ALL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_HCSPLIT_XACTPOS_END:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->isoc_split_pos =3D DWC_HCSPLIT_XACTPOS=
_ALL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->isoc_split_offset =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case DWC_HCSPLIT_XACTPOS_BEGIN:
> + =A0 =A0 =A0 case DWC_HCSPLIT_XACTPOS_MID:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For BEGIN or MID, calculate the length=
 for the next
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* microframe to determine the correct SS=
PLIT token, either MID
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* or END.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frame_desc =3D &qtd->urb->iso_frame_desc[qt=
d->isoc_frame_index];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->isoc_split_offset +=3D 188;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((frame_desc->length - qtd->isoc_split_o=
ffset) <=3D 188)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->isoc_split_pos =3D DWC=
_HCSPLIT_XACTPOS_END;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->isoc_split_pos =3D DWC=
_HCSPLIT_XACTPOS_MID;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Handles a host channel ACK interrupt. This interrupt is enabled when
> + * performing the PING protocol in Slave mode, when errors occur during
> + * either Slave mode or DMA mode, and during Start Split transactions.
> + */
> +static int handle_hc_ack_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 regs, struc=
t dwc_qtd *qtd, int *must_free)
> +{
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 if (hc->do_split) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Handle ACK on SSPLIT. ACK should not occ=
ur in CSPLIT. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hc->ep_is_in && hc->data_pid_start !=
=3D DWC_OTG_HC_PID_SETUP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->ssplit_out_xfer_count =
=3D hc->xfer_len;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Don't need complete for isochronous out =
transfers. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(hc->ep_type =3D=3D DWC_OTG_EP_TYPE_IS=
OC && !hc->ep_is_in))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->complete_split =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->ep_type =3D=3D DWC_OTG_EP_TYPE_ISOC=
 && !hc->ep_is_in)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_isoc_out_vals(hc, qtd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, =
DWC_OTG_HC_XFER_ACK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
must_free);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->qh->ping_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->qh->ping_state =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Halt the channel so th=
e transfer can be re-started
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* from the appropriate p=
oint. This only happens in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Slave mode. In DMA mod=
e, the ping_state is cleared
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* when the transfer is s=
tarted because the core
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* automatically executes=
 the PING, then the transfer.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, =
DWC_OTG_HC_XFER_ACK,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If the ACK occurred when _not_ in the PING state, let =
the channel
> + =A0 =A0 =A0 =A0* continue transferring data after clearing the error co=
unt.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 /* disable ack */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_ACK_RESP_REC_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host channel NYET interrupt. This interrupt should only occ=
ur on
> + * Bulk and Control OUT endpoints and for complete split transactions. I=
f a
> + * NYET occurs at the same time as a Transfer Complete interrupt, it is
> + * handled in the xfercomp interrupt handler, not here. This handler may=
 be
> + * called in either DMA mode or Slave mode.
> + */
> +static int handle_hc_nyet_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 regs, st=
ruct dwc_qtd *qtd, int *must_free)
> +{
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> + =A0 =A0 =A0 u32 hcint_clear =3D 0;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* NYET on CSPLIT
> + =A0 =A0 =A0 =A0* re-do the CSPLIT immediately on non-periodic
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (hc->do_split && hc->complete_split) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->ep_type =3D=3D DWC_OTG_EP_TYPE_INTR=
 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->ep_type =3D=3D DWC_OTG_EP_TYPE_=
ISOC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int frnum =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_get_fra=
me_number(dwc_otg_hcd_to_hcd
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(hcd));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dwc_full_frame_num(frnu=
m) !=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_full_frame_num(=
hc->qh->sched_frame)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->comple=
te_split =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channe=
l(hcd, hc, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0DWC_OTG_HC_XFER_XACT_ERR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto handle=
_nyet_done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_=
NYET, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto handle_nyet_done;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 hc->qh->ping_state =3D 1;
> + =A0 =A0 =A0 qtd->error_count =3D 0;
> + =A0 =A0 =A0 update_urb_state_xfer_intr(hc, regs, qtd->urb, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DWC_=
OTG_HC_XFER_NYET);
> + =A0 =A0 =A0 save_data_toggle(hc, regs, qtd);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Halt the channel and re-start the transfer so the PING
> + =A0 =A0 =A0 =A0* protocol will start.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_NYET, must_free)=
;
> +
> +handle_nyet_done:
> + =A0 =A0 =A0 /* disable nyet */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_NYET_RESP_REC_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> + =A0 =A0 =A0 /* clear nyet */
> + =A0 =A0 =A0 hcint_clear =3D DWC_HCINT_NYET_RESP_REC_RW(hcint_clear, 1);
> + =A0 =A0 =A0 dwc_reg_write(regs, DWC_HCINT, hcint_clear);
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host channel babble interrupt. This handler may be called i=
n
> + * either DMA mode or Slave mode.
> + */
> +static int handle_hc_babble_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 regs=
, struct dwc_qtd *qtd, int *must_free)
> +{
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 if (hc->ep_type !=3D DWC_OTG_EP_TYPE_ISOC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hcd, qtd->urb, -EO=
VERFLOW);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, DWC_OTG_HC_XFER_=
BABBLE_ERR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0must_free);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum dwc_halt_status halt_status;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_status =3D update_isoc_urb_state(hcd, =
hc, regs, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DWC_OTG_HC_XFER_BABBLE_ERR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, halt_status, mus=
t_free);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* disable bblerr */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_BBL_ERR_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host channel AHB error interrupt. This handler is only call=
ed in
> + * DMA mode.
> + */
> +static int handle_hc_ahberr_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 regs=
, struct dwc_qtd *qtd)
> +{
> + =A0 =A0 =A0 u32 hcchar;
> + =A0 =A0 =A0 u32 hcsplt;
> + =A0 =A0 =A0 u32 hctsiz =3D 0;
> + =A0 =A0 =A0 u32 hcdma;
> + =A0 =A0 =A0 struct urb *urb =3D qtd->urb;
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 hcchar =3D dwc_reg_read(regs, DWC_HCCHAR);
> + =A0 =A0 =A0 hcsplt =3D dwc_reg_read(regs, DWC_HCSPLT);
> + =A0 =A0 =A0 hctsiz =3D dwc_reg_read(regs, DWC_HCTSIZ);
> + =A0 =A0 =A0 hcdma =3D dwc_reg_read(regs, DWC_HCDMA);
> +
> + =A0 =A0 =A0 pr_err("AHB ERROR, Channel %d\n", hc->hc_num);
> + =A0 =A0 =A0 pr_err(" =A0hcchar 0x%08x, hcsplt 0x%08x\n", hcchar, hcsplt=
);
> + =A0 =A0 =A0 pr_err(" =A0hctsiz 0x%08x, hcdma 0x%08x\n", hctsiz, hcdma);
> +
> + =A0 =A0 =A0 pr_err(" =A0Device address: %d\n", usb_pipedevice(urb->pipe=
));
> + =A0 =A0 =A0 pr_err(" =A0Endpoint: %d, %s\n", usb_pipeendpoint(urb->pipe=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0(usb_pipein(urb->pipe) ? "IN" : "OUT"));
> +
> + =A0 =A0 =A0 pr_err(" =A0Endpoint type: %s\n", pipetype_str(urb->pipe));
> + =A0 =A0 =A0 pr_err(" =A0Speed: %s\n", dev_speed_str(urb->dev->speed));
> + =A0 =A0 =A0 pr_err(" =A0Max packet size: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_maxpacket(urb->dev, urb->pipe, usb_pipeo=
ut(urb->pipe)));
> + =A0 =A0 =A0 pr_err(" =A0Data buffer length: %d\n", urb->transfer_buffer=
_length);
> + =A0 =A0 =A0 pr_err(" =A0Transfer buffer: %p, Transfer DMA: %p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0urb->transfer_buffer, (void *)(u32) urb->tra=
nsfer_dma);
> + =A0 =A0 =A0 pr_err(" =A0Setup buffer: %p, Setup DMA: %p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0urb->setup_packet, (void *)(u32) urb->setup_=
dma);
> + =A0 =A0 =A0 pr_err(" =A0Interval: %d\n", urb->interval);
> +
> + =A0 =A0 =A0 dwc_otg_hcd_complete_urb(hcd, urb, -EIO);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Force a channel halt. Don't call halt_channel because =
that won't
> + =A0 =A0 =A0 =A0* write to the HCCHARn register in DMA mode to force the=
 halt.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dwc_otg_hc_halt(hcd->core_if, hc, DWC_OTG_HC_XFER_AHB_ERR);
> + =A0 =A0 =A0 /* disable ahberr */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_AHB_ERR_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host channel transaction error interrupt. This handler may =
be
> + * called in either DMA mode or Slave mode.
> + */
> +static int handle_hc_xacterr_intr(struct dwc_hcd *hcd, struct dwc_hc *hc=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 reg=
s, struct dwc_qtd *qtd, int *must_free)
> +{
> + =A0 =A0 =A0 enum dwc_halt_status status =3D DWC_OTG_HC_XFER_XACT_ERR;
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 switch (usb_pipetype(qtd->urb->pipe)) {
> + =A0 =A0 =A0 case PIPE_CONTROL:
> + =A0 =A0 =A0 case PIPE_BULK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hc->qh->ping_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_urb_state_xfer_intr(=
hc, regs, qtd->urb, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_data_toggle(hc, regs, =
qtd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!hc->ep_is_in && qtd->u=
rb->dev->speed =3D=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_SPEED_HIGH)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->qh->pin=
g_state =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Halt the channel so the transfer can b=
e re-started from
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the appropriate point or the PING prot=
ocol will start.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, status, must_fre=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_INTERRUPT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->do_split && hc->complete_split)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->complete_split =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, status, must_fre=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_ISOCHRONOUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D update_isoc_urb_state(hcd, hc, r=
egs, qtd, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, status, must_fre=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Disable xacterr */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_TRANS_ERR_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host channel frame overrun interrupt. This handler may be c=
alled
> + * in either DMA mode or Slave mode.
> + */
> +static int handle_hc_frmovrun_intr(struct dwc_hcd *hcd, struct dwc_hc *h=
c,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 =
regs, struct dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =
*must_free)
> +{
> + =A0 =A0 =A0 enum dwc_halt_status status =3D DWC_OTG_HC_XFER_FRAME_OVERR=
UN;
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 switch (usb_pipetype(qtd->urb->pipe)) {
> + =A0 =A0 =A0 case PIPE_CONTROL:
> + =A0 =A0 =A0 case PIPE_BULK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_INTERRUPT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, status, must_fre=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PIPE_ISOCHRONOUS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D update_isoc_urb_state(hcd, hc, r=
egs, qtd, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, status, must_fre=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Disable frmovrun */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_FRAME_OVERN_ERR_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host channel data toggle error interrupt. This handler may =
be
> + * called in either DMA mode or Slave mode.
> + */
> +static int handle_hc_datatglerr_intr(struct dwc_hcd *hcd, struct dwc_hc =
*hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u32 regs, struct dwc_qtd *qtd)
> +{
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 if (hc->ep_is_in)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qtd->error_count =3D 0;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Data Toggle Error on OUT transfer, =
channel "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%d\n", hc->hc_num);
> +
> + =A0 =A0 =A0 /* disable datatglerr */
> + =A0 =A0 =A0 hcintmsk =3D DWC_HCINTMSK_DATA_TOG_ERR_RW(hcintmsk, 1);
> + =A0 =A0 =A0 dwc_reg_modify(regs, DWC_HCINTMSK, hcintmsk, 0);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/**
> + * Handles a host Channel Halted interrupt in DMA mode. This handler
> + * determines the reason the channel halted and proceeds accordingly.
> + */
> +static void handle_hc_chhltd_intr_dma(struct dwc_hcd *hcd, struct dwc_hc=
 *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ulong regs, struct dwc_qtd *qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int *must_free)
> +{
> + =A0 =A0 =A0 u32 hcint;
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> +
> + =A0 =A0 =A0 if (hc->halt_status =3D=3D DWC_OTG_HC_XFER_URB_DEQUEUE ||
> + =A0 =A0 =A0 =A0 =A0 hc->halt_status =3D=3D DWC_OTG_HC_XFER_AHB_ERR) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Just release the channel. A dequeue ca=
n happen on a
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* transfer timeout. In the case of an AH=
B Error, the channel
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* was forced to halt because there's no =
way to gracefully
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* recover.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_channel(hcd, hc, qtd, hc->halt_stat=
us, must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Read the HCINTn register to determine the cause for the =
halt. */
> + =A0 =A0 =A0 hcint =3D dwc_reg_read(regs, DWC_HCINT);
> + =A0 =A0 =A0 hcintmsk =3D dwc_reg_read(regs, DWC_HCINTMSK);
> + =A0 =A0 =A0 if (DWC_HCINT_TXFER_CMPL_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is here because of a possible har=
dware bug. =A0Spec
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* says that on SPLIT-ISOC OUT transfers =
in DMA mode that a HALT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* interrupt w/ACK bit set should occur, =
but I only see the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* XFERCOMP bit, even with it masked out.=
 =A0This is a workaround
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for that behavior. =A0Should fix this =
when hardware is fixed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->ep_type =3D=3D DWC_OTG_EP_TYPE_ISOC=
 && !hc->ep_is_in)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_ack_intr(hcd, hc,=
 regs, qtd, must_free);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_xfercomp_intr(hcd, hc, regs, qtd,=
 must_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_STALL_RESP_REC_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_stall_intr(hcd, hc, regs, qtd, mu=
st_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_TRANS_ERR_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Must handle xacterr before nak or ack.=
 Could get a xacterr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* at the same time as either of these on=
 a BULK/CONTROL OUT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* that started with a PING. The xacterr =
takes precedence.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_xacterr_intr(hcd, hc, regs, qtd, =
must_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_NYET_RESP_REC_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Must handle nyet before nak or ack. Co=
uld get a nyet at the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* same time as either of those on a BULK=
/CONTROL OUT that
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* started with a PING. The nyet takes pr=
ecedence.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_nyet_intr(hcd, hc, regs, qtd, mus=
t_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_BBL_ERR_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_babble_intr(hcd, hc, regs, qtd, m=
ust_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_FRAME_OVERN_ERR_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_frmovrun_intr(hcd, hc, regs, qtd,=
 must_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_DATA_TOG_ERR_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_datatglerr_intr(hcd, hc, regs, qt=
d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->qh->data_toggle =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd, hc->halt_status,=
 must_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_NAK_RESP_REC_RD(hcint) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!DWC_HCINTMSK_NAK_RESP_REC_RD(hcintm=
sk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If nak is not masked, it's because a n=
on-split IN transfer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is in an error state. In that case, th=
e nak is handled by
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the nak interrupt handler, not here. H=
andle nak here for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* BULK/CONTROL OUT transfers, which halt=
 on a NAK to allow
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* rewinding the buffer pointer.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_nak_intr(hcd, hc, regs, qtd, must=
_free);
> + =A0 =A0 =A0 } else if (DWC_HCINT_ACK_RESP_REC_RD(hcint) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!DWC_HCINTMSK_ACK_RESP_REC_RD(hcintm=
sk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If ack is not masked, it's because a n=
on-split IN transfer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is in an error state. In that case, th=
e ack is handled by
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the ack interrupt handler, not here. H=
andle ack here for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* split transfers. Start splits halt on =
ACK.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_ack_intr(hcd, hc, regs, qtd, must=
_free);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hc->ep_type =3D=3D DWC_OTG_EP_TYPE_INTR=
 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc->ep_type =3D=3D DWC_OTG_EP_TYPE_=
ISOC) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* A periodic transfer ha=
lted with no other channel
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* interrupts set. Assume=
 it was halted by the core
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* because it could not b=
e completed in its scheduled
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* (micro)frame.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 halt_channel(hcd, hc, qtd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
DWC_OTG_HC_XFER_PERIODIC_INCOMPLETE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Channel %d, DMA=
 Mode -- ChHltd "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"set, but re=
ason for halting is unknown, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hcint 0x%08=
x, intsts 0x%08x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, hc=
->hc_num, hcint,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dwc_reg_read=
(gintsts_reg(hcd), 0));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * Handles a host channel Channel Halted interrupt.
> + *
> + * In slave mode, this handler is called only when the driver specifical=
ly
> + * requests a halt. This occurs during handling other host channel inter=
rupts
> + * (e.g. nak, xacterr, stall, nyet, etc.).
> + *
> + * In DMA mode, this is the interrupt that occurs when the core has fini=
shed
> + * processing a transfer on a channel. Other host channel interrupts (ex=
cept
> + * ahberr) are disabled in DMA mode.
> + */
> +static int handle_hc_chhltd_intr(struct dwc_hcd *hcd, struct dwc_hc *hc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ulong regs, struct dwc_qtd *qtd, int *must_=
free)
> +{
> + =A0 =A0 =A0 if (hcd->core_if->dma_enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_hc_chhltd_intr_dma(hcd, hc, regs, qt=
d, must_free);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_channel(hcd, hc, qtd, hc->halt_stat=
us, must_free);
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +/* Handles interrupt for a specific Host Channel */
> +static int dwc_otg_hcd_handle_hc_n_intr(struct dwc_hcd *hcd, u32 num)
> +{
> + =A0 =A0 =A0 int must_free =3D 0;
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 u32 hcint;
> + =A0 =A0 =A0 u32 hcintmsk =3D 0;
> + =A0 =A0 =A0 struct dwc_hc *hc;
> + =A0 =A0 =A0 ulong hc_regs;
> + =A0 =A0 =A0 struct dwc_qtd *qtd;
> +
> + =A0 =A0 =A0 hc =3D hcd->hc_ptr_array[num];
> + =A0 =A0 =A0 hc_regs =3D hcd->core_if->host_if->hc_regs[num];
> + =A0 =A0 =A0 qtd =3D list_entry(hc->qh->qtd_list.next, struct dwc_qtd, q=
td_list_entry);
> +
> + =A0 =A0 =A0 hcint =3D dwc_reg_read(hc_regs, DWC_HCINT);
> + =A0 =A0 =A0 hcintmsk =3D dwc_reg_read(hc_regs, DWC_HCINTMSK);
> +
> + =A0 =A0 =A0 hcint =3D hcint & hcintmsk;
> + =A0 =A0 =A0 if (!hcd->core_if->dma_enable && DWC_HCINT_CHAN_HALTED_RD(h=
cint)
> + =A0 =A0 =A0 =A0 =A0 && hcint !=3D 0x2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcint =3D DWC_HCINT_CHAN_HALTED_RW(hcint, 0=
);
> +
> + =A0 =A0 =A0 if (DWC_HCINT_TXFER_CMPL_RD(hcint)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_xfercomp_intr(hcd, hc=
, hc_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 qtd, &must_free);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If NYET occurred at same time as Xfer =
Complete, the NYET is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* handled by the Xfer Complete interrupt=
 handler. Don't want
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to call the NYET interrupt handler in =
this case.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hcint =3D DWC_HCINT_NYET_RESP_REC_RW(hcint,=
 0);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (DWC_HCINT_CHAN_HALTED_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_chhltd_intr(hcd, hc, =
hc_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_AHB_ERR_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_ahberr_intr(hcd, hc, =
hc_regs, qtd);
> + =A0 =A0 =A0 if (DWC_HCINT_STALL_RESP_REC_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_stall_intr(hcd, hc, h=
c_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_NAK_RESP_REC_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_nak_intr(hcd, hc, hc_=
regs, qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_ACK_RESP_REC_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_ack_intr(hcd, hc, hc_=
regs, qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_NYET_RESP_REC_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_nyet_intr(hcd, hc, hc=
_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_TRANS_ERR_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_xacterr_intr(hcd, hc,=
 hc_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_BBL_ERR_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_babble_intr(hcd, hc, =
hc_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_FRAME_OVERN_ERR_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_frmovrun_intr(hcd, hc=
, hc_regs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 qtd, &must_free);
> + =A0 =A0 =A0 if (DWC_HCINT_DATA_TOG_ERR_RD(hcint))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D handle_hc_datatglerr_intr(hcd, =
hc, hc_regs, qtd);
> +
> + =A0 =A0 =A0 if (must_free)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Free the qtd here now that we are done u=
sing it. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dwc_otg_hcd_qtd_free(qtd);
> + =A0 =A0 =A0 return retval;
> +}
> +
> +/**
> + * This function returns the Host All Channel Interrupt register
> + */
> +static inline u32 dwc_otg_read_host_all_channels_intr(struct core_if
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *core_if)
> +{
> + =A0 =A0 =A0 return dwc_reg_read(core_if->host_if->host_global_regs, DWC=
_HAINT);
> +}
> +
> +/**
> + * This interrupt indicates that one or more host channels has a pending
> + * interrupt. There are multiple conditions that can cause each host cha=
nnel
> + * interrupt. This function determines which conditions have occurred fo=
r each
> + * host channel interrupt and handles them appropriately.
> + */
> +static int dwc_otg_hcd_handle_hc_intr(struct dwc_hcd *hcd)
> +{
> + =A0 =A0 =A0 u32 i;
> + =A0 =A0 =A0 int retval =3D 0;
> + =A0 =A0 =A0 u32 haint;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Clear appropriate bits in HCINTn to clear the interrup=
t bit in
> + =A0 =A0 =A0 =A0* =A0GINTSTS
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 haint =3D dwc_otg_read_host_all_channels_intr(hcd->core_if)=
;
> + =A0 =A0 =A0 for (i =3D 0; i < hcd->core_if->core_params->host_channels;=
 i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (DWC_HAINT_RD(haint) & (1 << i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval |=3D dwc_otg_hcd_han=
dle_hc_n_intr(hcd, i);
> +
> + =A0 =A0 =A0 return retval;
> +}
> +
> +/* This function handles interrupts for the HCD.*/
> +int dwc_otg_hcd_handle_intr(struct dwc_hcd *hcd)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 struct core_if *core_if =3D hcd->core_if;
> + =A0 =A0 =A0 u32 gintsts;
> +
> + =A0 =A0 =A0 /* Check if HOST Mode */
> + =A0 =A0 =A0 if (dwc_otg_is_host_mode(core_if)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&hcd->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gintsts =3D dwc_otg_read_core_intr(core_if)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!gintsts) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&hcd->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gintsts & DWC_INTMSK_STRT_OF_FRM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D dwc_otg_hcd_handle=
_sof_intr(hcd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gintsts & DWC_INTMSK_RXFIFO_NOT_EMPT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D dwc_otg_hcd_handle=
_rx_status_q_level_intr(hcd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gintsts & DWC_INTMSK_NP_TXFIFO_EMPT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D dwc_otg_hcd_handle=
_np_tx_fifo_empty_intr(hcd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gintsts & DWC_INTMSK_HST_PORT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D dwc_otg_hcd_handle=
_port_intr(hcd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gintsts & DWC_INTMSK_HST_CHAN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D dwc_otg_hcd_handle=
_hc_intr(hcd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gintsts & DWC_INTMSK_P_TXFIFO_EMPTY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D dwc_otg_hcd_handle=
_perio_tx_fifo_empty_intr(hcd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&hcd->lock);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
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
