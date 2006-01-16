Return-Path: <peter.fercher@scs.ch>
Received: from mail.scs.ch (mail.scs.ch [212.203.110.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7947468A47
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 03:50:08 +1100 (EST)
From: "Peter Fercher" <peter.fercher@scs.ch>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: ppc4xx DMA fixes for simultaneous sg transfers
Date: Mon, 16 Jan 2006 17:33:52 +0100
Message-ID: <003a01c61aba$a7325250$4e0112ac@scsad.scs.ch>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_003B_01C61AC3.08F6BA50"
In-reply-to: <518B77BB6246D54D9E88FC49AFB0389D4F26BD@seskoptronicmsx.optronic.local>
Cc: 'ductusrhe' <Ronnie.Hedlund@optronic.se>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_003B_01C61AC3.08F6BA50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

can somebody provide an example usage of the ppc4xx_ scatter/gather dma=20
library by mvista ?
=20

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of ductusrhe
Sent: Mittwoch, 7. Dezember 2005 22:33
To: linuxppc-embedded@ozlabs.org
Subject: ppc4xx DMA fixes for simultaneous sg transfers


Linux 2.4.20 (probably 2.6 as well?)
=20
Conclusion:
Scatter/gather DMA is not thread safe.
=20
Background:
1. We run all four dma channels simultaneously in SG mode on the =
PPC440EP,
starting and stopping them in different threads.
2. Also we need to change channel configs between different transfers, =
i.e.
run ppc4xx_init_dma_channel() to set read or write mode.
=20
Problem and cause:
1. All is well when running one channel at a time, but when
starting/stopping a new channel during the time another is active can - =
if
you are unlucky - cause problems.
   Because all channels SG start/stop bits are in the same register =
(ASGC),
it must not be read then changed and written to the way it was done.
   That can cause a channel that is just done, to start again, or a =
newly
started channel to stop.
   The register includes a feature that can be used as a semaphore - the
read enable (mask) bits, but it was not used correctly in the code, it =
was
enabled for all channels in the start-up.
2. It is said in the comment of ppc4xx_init_dma_channel() that it should
only be used once in the start-up. If you comply, you will not have any
problem with it.
   However, when running this for a channel when other channels are =
active,
can cause channels to stop or maybe never give an interrupt or false
interrupts. The method clears the entire status register, not only the =
bits
for the given channel.
=20
Solution:
1. - In ppc4xx_alloc_dma_handle(), do not touch the ASGC register!
   - In ppc4xx_enable_dma_sgl() and ppc4xx_disable_dma_sgl(), when =
setting
the ASGC register, only change the given channel.
     That's done without reading the register at all, just set/clear the
enable bit of the channel to change, then set the MASK_ENABLE for the =
same
channel.
   Probably this is the way the register was intended to be handled?
2. - In ppc4xx_init_dma_channel(), only clear the correct bits of the =
DMASR
register, not the whole register.
     (The polarity was also not set as it's supposed to in this =
function,
but there exists a patch for that)
=20
I can send a patch with our changes, that works very well and stable, =
but
there are many changes and not all of them in line with the current =
official
version of the files (we handle the sg descriptor list differently). =
Maybe
someone feeling for it will take a look at the changes and make them =
into
the real code, since the above fixes does not interfere with the usage, =
only
improves thread safety.
=20
I have no idea if this has been fixed in some patch already... but I =
have
not seen it on this list anyway.
I'm not a regular poster, just want to help others avoid some of the
struggle when running many channels.
=20
/Ronnie Hedlund

Our changed code:
In "ppc4xx_dma.c"
-----------------------
/*
 *  The comment states that this function should only be run at =
start-up,
and never more.
 *  That is unacceptable, with the fix it can be run anywhere as long as =
the
given channel is not running.
 */
int ppc4xx_init_dma_channel(unsigned int dmanr, ppc_dma_ch_t * p_init)
{
        unsigned int status_bits[] =3D { DMA_CS0 | DMA_TS0 | =
DMA_CH0_ERR,
                                       DMA_CS1 | DMA_TS1 | DMA_CH1_ERR,
                                       DMA_CS2 | DMA_TS2 | DMA_CH2_ERR,
                                       DMA_CS3 | DMA_TS3 | DMA_CH3_ERR};
        unsigned int polarity;
        uint32_t control =3D 0;
        ppc_dma_ch_t *p_dma_ch =3D &dma_channels[dmanr];
      =20
        DMA_MODE_READ =3D (unsigned long) DMA_TD; /* Peripheral to =
Memory */
        DMA_MODE_WRITE =3D 0;     /* Memory to Peripheral */
        if (!p_init) {
                printk("ppc4xx_init_dma_channel: NULL p_init\n");
                return DMA_STATUS_NULL_POINTER;
        }
        if (dmanr >=3D MAX_PPC4xx_DMA_CHANNELS) {
                printk("ppc4xx_init_dma_channel: bad channel %d\n", =
dmanr);
                return DMA_STATUS_BAD_CHANNEL;
        }
#if DCRN_POL > 0
        polarity =3D mfdcr(DCRN_POL);
#else
        polarity =3D 0;
#endif
        /* Setup the control register based on the values passed to
         * us in p_init.  Then, over-write the control register with =
this
         * new value.
         */
        control |=3D SET_DMA_CONTROL;
        switch (dmanr) {
        case 0:
                /* clear all polarity signals and then "or" in new =
signal
levels */
                polarity &=3D ~GET_DMA_POLARITY(0);
                polarity |=3D p_init->polarity;
#if DCRN_POL > 0
                mtdcr(DCRN_POL, polarity);
#endif
                mtdcr(DCRN_DMACR0, control);
                break;
        case 1:
                polarity &=3D ~GET_DMA_POLARITY(1);
                polarity |=3D p_init->polarity;
#if DCRN_POL > 0
                mtdcr(DCRN_POL, polarity);
#endif
                mtdcr(DCRN_DMACR1, control);
                break;
        case 2:
                polarity &=3D ~GET_DMA_POLARITY(2);
                polarity |=3D p_init->polarity;
#if DCRN_POL > 0
                mtdcr(DCRN_POL, polarity);
#endif
                mtdcr(DCRN_DMACR2, control);
                break;
        case 3:
                polarity &=3D ~GET_DMA_POLARITY(3);
                polarity |=3D p_init->polarity;
#if DCRN_POL > 0
                mtdcr(DCRN_POL, polarity);
#endif
                mtdcr(DCRN_DMACR3, control);
                break;
        default:
                return DMA_STATUS_BAD_CHANNEL;
        }
        /* save these values in our dma channel structure */
        memcpy(p_dma_ch, p_init, sizeof (ppc_dma_ch_t));
      =20
        /*
         * The peripheral width values written in the control register =
are:
         *   PW_8                 0
         *   PW_16                1
         *   PW_32                2
         *   PW_64                3
         *
         *   Since the DMA count register takes the number of =
"transfers",
         *   we need to divide the count sent to us in certain
         *   functions by the appropriate number.  It so happens that =
our
         *   right shift value is equal to the peripheral width value.
         */
        p_dma_ch->shift =3D p_init->pwidth;
        /*
         * Save the control word for easy access.
         */
        p_dma_ch->control =3D control;
        /*
         * clear status register for the channel
         * only TS, CS and RI needs to be cleared.
         */
        mtdcr(DCRN_DMASR, status_bits[dmanr]);
      =20
        return DMA_STATUS_GOOD;
}

In "ppc4xx_sgdma.c"
-----------------------
int
ppc4xx_alloc_dma_handle(sgl_handle_t * phandle, unsigned int mode, =
unsigned
int dmanr)
{
        sgl_list_info_t *psgl =3D NULL;
        ppc_dma_ch_t *p_dma_ch =3D &dma_channels[dmanr];
        //uint32_t sg_command;
        if (dmanr >=3D MAX_PPC4xx_DMA_CHANNELS) {
                printk("ppc4xx_alloc_dma_handle: invalid channel =
0x%x\n",
dmanr);
                return DMA_STATUS_BAD_CHANNEL;
        }
        if (!phandle) {
                printk("ppc4xx_alloc_dma_handle: null handle =
pointer\n");
                return DMA_STATUS_NULL_POINTER;
        }
        /* Get memory for the listinfo struct */
        psgl =3D kmalloc(sizeof(sgl_list_info_t), GFP_KERNEL);
        if (psgl =3D=3D NULL) {
                *phandle =3D (sgl_handle_t) NULL;
                return DMA_STATUS_OUT_OF_MEMORY;
        }
        memset(psgl, 0, sizeof(sgl_list_info_t));
      =20
        /* dma_addr is unused now */
        psgl->dmanr =3D dmanr;
        /*
         * Modify and save the control word. These words will be
         * written to each sgl descriptor.  The DMA engine then
         * loads this control word into the control register
         * every time it reads a new descriptor.
         */
        psgl->control =3D p_dma_ch->control;
        /* Clear all mode bits */
        psgl->control &=3D ~(DMA_TM_MASK | DMA_TD);
        /* Save control word and mode */
        psgl->control |=3D (mode | DMA_CE_ENABLE);
         /* PPC Errata? DMA else ignore count on first in list */
        psgl->control |=3D SET_DMA_TCE(1);
      =20
        /* In MM mode, we must set ETD/TCE */
        if (mode =3D=3D DMA_MODE_MM)
                psgl->control |=3D DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
        if (p_dma_ch->int_enable) {
                /* Enable channel interrupt */
                psgl->control |=3D DMA_CIE_ENABLE;
        } else {
                psgl->control &=3D ~DMA_CIE_ENABLE;
        }
        /* we must not touch the SGC, it can cause problems to other
channels! */
        =20
        psgl->sgl_control =3D SG_LINK;
        if (p_dma_ch->int_enable) {
                if (p_dma_ch->tce_enable)
                {      =20
                         /* reuse as Terminal Count Interrupt Enable on =
all
descr. */
                        psgl->sgl_control |=3D SG_TCI_ENABLE;
                }
                psgl->sgl_control |=3D SG_ERI_ENABLE | SG_ETI_ENABLE;
        }
        *phandle =3D (sgl_handle_t) psgl;
        return DMA_STATUS_GOOD;
}
void
ppc4xx_enable_dma_sgl(sgl_handle_t handle)
{
        sgl_list_info_t *psgl =3D (sgl_list_info_t *) handle;
        ppc_dma_ch_t *p_dma_ch;
        uint32_t sg_command;
        if (!handle) {
                printk("ppc4xx_enable_dma_sgl: null handle\n");
                return;
        } else if (psgl->dmanr > (MAX_PPC4xx_DMA_CHANNELS - 1)) {
                printk("ppc4xx_enable_dma_sgl: bad channel in handle =
%d\n",
                       psgl->dmanr);
                return;
        } else if (!psgl->phead) {
                printk("ppc4xx_enable_dma_sgl: sg list empty\n");
                return;
        }
        p_dma_ch =3D &dma_channels[psgl->dmanr];
        psgl->ptail->control_count &=3D ~SG_LINK; /* make this the last
dscrptr */
        if (p_dma_ch->int_enable)
        {
                /* Require Terminal Count interrupt on last */
                psgl->ptail->control_count |=3D SG_TCI_ENABLE;
        }
      =20
        /* No more changes to tail object allowed */
        //dma_cache_wback((unsigned long)psgl->ptail, =
sizeof(ppc_sgl_t));
        dma_cache_wback_inv((unsigned long)psgl->ptail, =
sizeof(ppc_sgl_t));
      =20
        ppc4xx_set_sg_addr(psgl->dmanr, virt_to_phys(psgl->phead));
      =20
        sg_command =3D 0;
        switch (psgl->dmanr) {
        case 0:
                sg_command =3D SSG0_ENABLE | SSG0_MASK_ENABLE;
                break;
        case 1:
                sg_command =3D SSG1_ENABLE | SSG1_MASK_ENABLE;
                break;
        case 2:
                sg_command =3D SSG2_ENABLE | SSG2_MASK_ENABLE;
                break;
        case 3:
                sg_command =3D SSG3_ENABLE | SSG3_MASK_ENABLE;
                break;
        default:
                printk("ppc4xx_enable_dma_sgl: bad channel: %d\n",
psgl->dmanr);
        }
      =20
        mtdcr(DCRN_ASGC, sg_command);   /* start transfer */
}
void
ppc4xx_disable_dma_sgl(sgl_handle_t handle)
{
        sgl_list_info_t *psgl =3D (sgl_list_info_t *) handle;
        uint32_t sg_command;
        if (!handle) {
                printk("ppc4xx_disable_dma_sgl: null handle\n");
                return;
        } else if (psgl->dmanr > (MAX_PPC4xx_DMA_CHANNELS - 1)) {
                printk("ppc4xx_disable_dma_sgl: bad channel in handle =
%d\n",
                       psgl->dmanr);
                return;
        }
        sg_command =3D 0; //disable dma
        switch (psgl->dmanr) {
        case 0:
                sg_command =3D SSG0_MASK_ENABLE;
                break;
        case 1:
                sg_command =3D SSG1_MASK_ENABLE;
                break;
        case 2:
                sg_command =3D SSG2_MASK_ENABLE;
                break;
        case 3:
                sg_command =3D SSG3_MASK_ENABLE;
                break;
        default:
                printk("ppc4xx_disable_dma_sgl: bad channel: %d\n",
psgl->dmanr);
        }
        mtdcr(DCRN_ASGC, sg_command);   /* stop transfer */
}
=20


------=_NextPart_000_003B_01C61AC3.08F6BA50
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML dir=3Dltr><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D339013216-16012006>can=20
somebody provide an example usage of the ppc4xx_ scatter/gather dma=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D339013216-16012006>library by mvista ?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D339013216-16012006></SPAN></FONT>&nbsp;</DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B>=20
  linuxppc-embedded-bounces@ozlabs.org=20
  [mailto:linuxppc-embedded-bounces@ozlabs.org] <B>On Behalf Of=20
  </B>ductusrhe<BR><B>Sent:</B> Mittwoch, 7. Dezember 2005 =
22:33<BR><B>To:</B>=20
  linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> ppc4xx DMA fixes for=20
  simultaneous sg transfers<BR><BR></FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>Linux 2.4.20 =
(probably 2.6=20
  as well?)</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>Conclusion:<BR>Scatter/gather DMA is not thread =
safe.</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2>Background:<BR>1. We run=20
  all four dma channels simultaneously in SG mode on the PPC440EP, =
</FONT><FONT=20
  face=3D"Courier New" color=3D#000000 size=3D2>starting and stopping =
them in=20
  different threads.<BR>2. Also we need to change channel configs =
between=20
  different transfers, i.e. run ppc4xx_init_dma_channel() to set read or =
write=20
  mode.</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>Problem and =
cause:<BR>1.=20
  All is well when running one channel at a time, but when =
starting/stopping a=20
  new channel during the time another is active can - if you are unlucky =
- cause=20
  problems.<BR>&nbsp;&nbsp; Because all channels SG start/stop bits are =
in the=20
  same register (ASGC), it must not be read then changed and written to =
the way=20
  it was done.<BR>&nbsp;&nbsp; That can cause a channel that is just =
done, to=20
  start again, or a newly started channel to stop.<BR>&nbsp;&nbsp; The =
register=20
  includes a feature that can be used as a semaphore - the read enable =
(mask)=20
  bits, but it was not used correctly in the code, it was enabled for =
all=20
  channels in the start-up.<BR>2. It is said in the comment of=20
  ppc4xx_init_dma_channel() that it should only be used once in the =
start-up. If=20
  you comply, you will not have any problem with it.<BR>&nbsp;&nbsp; =
However,=20
  when running this for a channel when other channels are active, can =
cause=20
  channels to stop or maybe never give an interrupt or false interrupts. =
The=20
  method clears the entire status register, not only the bits for the =
given=20
  channel.</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2>Solution:<BR>1. - In=20
  ppc4xx_alloc_dma_handle(), do not touch the ASGC =
register!<BR>&nbsp;&nbsp; -=20
  In ppc4xx_enable_dma_sgl() and ppc4xx_disable_dma_sgl(), when setting =
the ASGC=20
  register, only change the given channel.<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
That's=20
  done without reading the register at all, just set/clear the enable =
bit of the=20
  channel to change, then set the MASK_ENABLE for the same=20
  channel.<BR>&nbsp;&nbsp; Probably this is the way the register was =
intended to=20
  be handled?</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>2. - In=20
  ppc4xx_init_dma_channel(), only clear the correct bits of the DMASR =
register,=20
  not the whole register.<BR>&nbsp;&nbsp;&nbsp;&nbsp; (The polarity was =
also not=20
  set as it's supposed to in this function, but there exists a patch for =

  that)</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"Courier New"><FONT color=3D#000000 size=3D2>I can =
send a patch=20
  with our changes, that works very well and stable, but there are many =
changes=20
  and not all of them in line with the current official version of the =
files (we=20
  handle the sg descriptor list differently). </FONT><FONT =
color=3D#000000=20
  size=3D2>Maybe someone feeling for it will take a look at the changes =
and make=20
  them into the real code, since the above fixes does not interfere with =
the=20
  usage, only improves thread safety.</FONT></FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>I have no =
idea if this has=20
  been fixed in some patch already... but I have not seen it on this =
list=20
  anyway.<BR>I'm not a regular poster, just want to help others avoid =
some of=20
  the struggle when running many channels.</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>/Ronnie=20
  Hedlund<BR></FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>Our changed =
code:<BR>In=20
  "ppc4xx_dma.c"<BR>-----------------------<BR>/*<BR>&nbsp;*&nbsp; The =
comment=20
  states that this function should only be run at start-up, and never=20
  more.<BR>&nbsp;*&nbsp; That is unacceptable, with the fix it can be =
run=20
  anywhere as long as the given channel is not =
running.<BR>&nbsp;*/<BR>int=20
  ppc4xx_init_dma_channel(unsigned int dmanr, ppc_dma_ch_t *=20
  p_init)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned =
int=20
  status_bits[] =3D { DMA_CS0 | DMA_TS0 |=20
  =
DMA_CH0_ERR,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
  DMA_CS1 | DMA_TS1 |=20
  =
DMA_CH1_ERR,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
  DMA_CS2 | DMA_TS2 |=20
  =
DMA_CH2_ERR,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
  DMA_CS3 | DMA_TS3 | DMA_CH3_ERR};</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int=20
  polarity;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t =
control =3D=20
  0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_dma_ch_t =
*p_dma_ch =3D=20
  &amp;dma_channels[dmanr];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_MODE_READ =3D =
(unsigned long)=20
  DMA_TD; /* Peripheral to Memory=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_MODE_WRITE =3D=20
  0;&nbsp;&nbsp;&nbsp;&nbsp; /* Memory to Peripheral */</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p_init)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_init_dma_channel: NULL=20
  =
p_init\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return =
DMA_STATUS_NULL_POINTER;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dmanr &gt;=3D=20
  MAX_PPC4xx_DMA_CHANNELS)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_init_dma_channel: bad channel %d\n",=20
  =
dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return =
DMA_STATUS_BAD_CHANNEL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>#if DCRN_POL =
&gt;=20
  0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; polarity =3D=20
  =
mfdcr(DCRN_POL);<BR>#else<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity =3D 0;<BR>#endif</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup the =
control=20
  register based on the values passed=20
  to<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * us in =
p_init.&nbsp;=20
  Then, over-write the control register with=20
  this<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * new=20
  value.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control |=3D=20
  SET_DMA_CONTROL;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (dmanr)=20
  {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
0:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  /* clear all polarity signals and then "or" in new signal levels=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity &amp;=3D=20
  =
~GET_DMA_POLARITY(0);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt;=20
  =
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_POL,=20
  =
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_DMACR0,=20
  =
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
1:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity &amp;=3D=20
  =
~GET_DMA_POLARITY(1);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt;=20
  =
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_POL,=20
  =
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_DMACR1,=20
  =
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
2:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity &amp;=3D=20
  =
~GET_DMA_POLARITY(2);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt;=20
  =
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_POL,=20
  =
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_DMACR2,=20
  =
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
3:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity &amp;=3D=20
  =
~GET_DMA_POLARITY(3);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt;=20
  =
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_POL,=20
  =
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  mtdcr(DCRN_DMACR3,=20
  =
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
default:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return =
DMA_STATUS_BAD_CHANNEL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save these =
values in our=20
  dma channel structure */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

  memcpy(p_dma_ch, p_init, sizeof=20
  (ppc_dma_ch_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The =
peripheral width=20
  values written in the control register=20
  are:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =

  =
PW_8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;=20
  =
PW_16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;=20
  =
PW_32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp;=20
  =
PW_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  *<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =
Since the=20
  DMA count register takes the number of=20
  "transfers",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*&nbsp;&nbsp;=20
  we need to divide the count sent to us in=20
  certain<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*&nbsp;&nbsp;=20
  functions by the appropriate number.&nbsp; It so happens that=20
  our<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =
right=20
  shift value is equal to the peripheral width=20
  value.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_dma_ch-&gt;shift =
=3D=20
  p_init-&gt;pwidth;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Save the =
control word=20
  for easy access.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_dma_ch-&gt;control =
=3D=20
  control;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * clear status =
register=20
  for the channel<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
only TS,=20
  CS and RI needs to be=20
  cleared.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtdcr(DCRN_DMASR,=20
  status_bits[dmanr]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
  DMA_STATUS_GOOD;<BR>}</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2><BR>In=20
  "ppc4xx_sgdma.c"<BR>-----------------------</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>int<BR>ppc4xx_alloc_dma_handle(sgl_handle_t * phandle, =
unsigned int=20
  mode, unsigned int =
dmanr)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  sgl_list_info_t *psgl =3D =
NULL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  ppc_dma_ch_t *p_dma_ch =3D=20
  =
&amp;dma_channels[dmanr];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  //uint32_t sg_command;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dmanr &gt;=3D=20
  MAX_PPC4xx_DMA_CHANNELS)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_alloc_dma_handle: invalid channel 0x%x\n",=20
  =
dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return =
DMA_STATUS_BAD_CHANNEL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!phandle)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_alloc_dma_handle: null handle=20
  =
pointer\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return =
DMA_STATUS_NULL_POINTER;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get memory for =
the=20
  listinfo struct */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl =
=3D=20
  kmalloc(sizeof(sgl_list_info_t),=20
  GFP_KERNEL);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psgl =
=3D=3D NULL)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  *phandle =3D (sgl_handle_t)=20
  =
NULL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return =
DMA_STATUS_OUT_OF_MEMORY;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(psgl, 0,=20
  sizeof(sgl_list_info_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dma_addr is unused =
now=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;dmanr =3D=20
  dmanr;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  /*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Modify and =
save the=20
  control word. These words will=20
  be<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * written to =
each sgl=20
  descriptor.&nbsp; The DMA engine=20
  then<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * loads this =
control=20
  word into the control=20
  register<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * every =
time it=20
  reads a new =
descriptor.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;control =3D=20
  p_dma_ch-&gt;control;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Clear=20
  all mode bits */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  psgl-&gt;control &amp;=3D ~(DMA_TM_MASK |=20
  DMA_TD);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Save control =
word=20
  and mode */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psgl-&gt;control |=3D=20
  (mode | =
DMA_CE_ENABLE);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=20
  PPC Errata? DMA else ignore count on first in list=20
  */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;control |=3D =

  SET_DMA_TCE(1);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In MM mode, we must =
set=20
  ETD/TCE */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mode =
=3D=3D=20
  =
DMA_MODE_MM)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  psgl-&gt;control |=3D DMA_ETD_OUTPUT |=20
  DMA_TCE_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=20
  (p_dma_ch-&gt;int_enable)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  /* Enable channel interrupt=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  psgl-&gt;control |=3D=20
  DMA_CIE_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  psgl-&gt;control &amp;=3D=20
  ~DMA_CIE_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we must not =
touch the=20
  SGC, it can cause problems to other channels! */</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;sgl_control =
=3D=20
  SG_LINK;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(p_dma_ch-&gt;int_enable)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  if=20
  =
(p_dma_ch-&gt;tce_enable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
  /* reuse as Terminal Count Interrupt Enable on all descr.=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  psgl-&gt;sgl_control |=3D=20
  =
SG_TCI_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  psgl-&gt;sgl_control |=3D SG_ERI_ENABLE |=20
  SG_ETI_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *phandle =3D =
(sgl_handle_t)=20
  psgl;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=20
  DMA_STATUS_GOOD;<BR>}</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>void<BR>ppc4xx_enable_dma_sgl(sgl_handle_t=20
  handle)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sgl_list_info_t=20
  *psgl =3D (sgl_list_info_t *)=20
  handle;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_dma_ch_t=20
  *p_dma_ch;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t=20
  sg_command;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_enable_dma_sgl: null=20
  =
handle\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if=20
  (psgl-&gt;dmanr &gt; (MAX_PPC4xx_DMA_CHANNELS - 1))=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_enable_dma_sgl: bad channel in handle=20
  =
%d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if=20
  (!psgl-&gt;phead)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_enable_dma_sgl: sg list=20
  =
empty\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_dma_ch =3D=20
  =
&amp;dma_channels[psgl-&gt;dmanr];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
  psgl-&gt;ptail-&gt;control_count &amp;=3D ~SG_LINK; /* make this the =
last=20
  dscrptr */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=20
  =
(p_dma_ch-&gt;int_enable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  /* Require Terminal Count interrupt on last=20
  =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  psgl-&gt;ptail-&gt;control_count |=3D=20
  SG_TCI_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No more changes to =
tail=20
  object allowed */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  //dma_cache_wback((unsigned long)psgl-&gt;ptail,=20
  sizeof(ppc_sgl_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  dma_cache_wback_inv((unsigned long)psgl-&gt;ptail,=20
  sizeof(ppc_sgl_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  ppc4xx_set_sg_addr(psgl-&gt;dmanr,=20
  virt_to_phys(psgl-&gt;phead));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_command =3D=20
  0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(psgl-&gt;dmanr)=20
  {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
0:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D SSG0_ENABLE |=20
  =
SSG0_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
1:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D SSG1_ENABLE |=20
  =
SSG1_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
2:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D SSG2_ENABLE |=20
  =
SSG2_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
3:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D SSG3_ENABLE |=20
  =
SSG3_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
default:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_enable_dma_sgl: bad channel: %d\n",=20
  psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  }<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtdcr(DCRN_ASGC,=20
  sg_command);&nbsp;&nbsp; /* start transfer */<BR>}</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>void<BR>ppc4xx_disable_dma_sgl(sgl_handle_t=20
  handle)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sgl_list_info_t=20
  *psgl =3D (sgl_list_info_t *)=20
  handle;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t=20
  sg_command;</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle)=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_disable_dma_sgl: null=20
  =
handle\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if=20
  (psgl-&gt;dmanr &gt; (MAX_PPC4xx_DMA_CHANNELS - 1))=20
  =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_disable_dma_sgl: bad channel in handle=20
  =
%d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_command =3D 0; =
//disable=20
  dma<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(psgl-&gt;dmanr)=20
  {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
0:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D=20
  =
SSG0_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
1:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D=20
  =
SSG1_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
2:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D=20
  =
SSG2_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
3:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  sg_command =3D=20
  =
SSG3_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  =
default:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  printk("ppc4xx_disable_dma_sgl: bad channel: %d\n",=20
  psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
  size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtdcr(DCRN_ASGC,=20
  sg_command);&nbsp;&nbsp; /* stop transfer */<BR>}</FONT></DIV>
  <DIV><FONT face=3D"Courier New" color=3D#000000=20
size=3D2>&nbsp;</DIV></BLOCKQUOTE></FONT></BODY></HTML>

------=_NextPart_000_003B_01C61AC3.08F6BA50--
