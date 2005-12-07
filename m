Return-Path: <Ronnie.Hedlund@optronic.se>
Received: from oskmsx.optronic.se (158.net110.skekraft.net [213.199.110.158])
	by ozlabs.org (Postfix) with SMTP id 4F3516888E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 08:44:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5FB75.CC4FA936"
Date: Wed, 7 Dec 2005 22:33:00 +0100
Message-ID: <518B77BB6246D54D9E88FC49AFB0389D4F26BD@seskoptronicmsx.optronic.local>
From: "ductusrhe" <Ronnie.Hedlund@optronic.se>
To: <linuxppc-embedded@ozlabs.org>
Subject: ppc4xx DMA fixes for simultaneous sg transfers
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

------_=_NextPart_001_01C5FB75.CC4FA936
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linux 2.4.20 (probably 2.6 as well?)
=20
Conclusion:
Scatter/gather DMA is not thread safe.
=20
Background:
1. We run all four dma channels simultaneously in SG mode on the =
PPC440EP, starting and stopping them in different threads.
2. Also we need to change channel configs between different transfers, =
i.e. run ppc4xx_init_dma_channel() to set read or write mode.
=20
Problem and cause:
1. All is well when running one channel at a time, but when =
starting/stopping a new channel during the time another is active can - =
if you are unlucky - cause problems.
   Because all channels SG start/stop bits are in the same register =
(ASGC), it must not be read then changed and written to the way it was =
done.
   That can cause a channel that is just done, to start again, or a =
newly started channel to stop.
   The register includes a feature that can be used as a semaphore - the =
read enable (mask) bits, but it was not used correctly in the code, it =
was enabled for all channels in the start-up.
2. It is said in the comment of ppc4xx_init_dma_channel() that it should =
only be used once in the start-up. If you comply, you will not have any =
problem with it.
   However, when running this for a channel when other channels are =
active, can cause channels to stop or maybe never give an interrupt or =
false interrupts. The method clears the entire status register, not only =
the bits for the given channel.
=20
Solution:
1. - In ppc4xx_alloc_dma_handle(), do not touch the ASGC register!
   - In ppc4xx_enable_dma_sgl() and ppc4xx_disable_dma_sgl(), when =
setting the ASGC register, only change the given channel.
     That's done without reading the register at all, just set/clear the =
enable bit of the channel to change, then set the MASK_ENABLE for the =
same channel.
   Probably this is the way the register was intended to be handled?
2. - In ppc4xx_init_dma_channel(), only clear the correct bits of the =
DMASR register, not the whole register.
     (The polarity was also not set as it's supposed to in this =
function, but there exists a patch for that)
=20
I can send a patch with our changes, that works very well and stable, =
but there are many changes and not all of them in line with the current =
official version of the files (we handle the sg descriptor list =
differently). Maybe someone feeling for it will take a look at the =
changes and make them into the real code, since the above fixes does not =
interfere with the usage, only improves thread safety.
=20
I have no idea if this has been fixed in some patch already... but I =
have not seen it on this list anyway.
I'm not a regular poster, just want to help others avoid some of the =
struggle when running many channels.
=20
/Ronnie Hedlund

Our changed code:
In "ppc4xx_dma.c"
-----------------------
/*
 *  The comment states that this function should only be run at =
start-up, and never more.
 *  That is unacceptable, with the fix it can be run anywhere as long as =
the given channel is not running.
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
signal levels */
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
unsigned int dmanr)
{
        sgl_list_info_t *psgl =3D NULL;
        ppc_dma_ch_t *p_dma_ch =3D &dma_channels[dmanr];
        //uint32_t sg_command;
        if (dmanr >=3D MAX_PPC4xx_DMA_CHANNELS) {
                printk("ppc4xx_alloc_dma_handle: invalid channel =
0x%x\n", dmanr);
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
        /* we must not touch the SGC, it can cause problems to other =
channels! */
        =20
        psgl->sgl_control =3D SG_LINK;
        if (p_dma_ch->int_enable) {
                if (p_dma_ch->tce_enable)
                {      =20
                         /* reuse as Terminal Count Interrupt Enable on =
all descr. */
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
        psgl->ptail->control_count &=3D ~SG_LINK; /* make this the last =
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
                printk("ppc4xx_enable_dma_sgl: bad channel: %d\n", =
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
                printk("ppc4xx_disable_dma_sgl: bad channel: %d\n", =
psgl->dmanr);
        }
        mtdcr(DCRN_ASGC, sg_command);   /* stop transfer */
}
=20

------_=_NextPart_001_01C5FB75.CC4FA936
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1"></HEAD><BODY><DIV><FONT face=3D"Courier New" =
color=3D#000000 size=3D2>Linux 2.4.20 (probably 2.6 as =
well?)</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2>Conclusion:<BR>Scatter/gather =0A=
DMA is not thread safe.</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2>Background:<BR>1. We run all =0A=
four dma channels simultaneously in SG mode on the PPC440EP, =
</FONT><FONT =0A=
face=3D"Courier New" color=3D#000000 size=3D2>starting and stopping them =
in different =0A=
threads.<BR>2. Also we need to change channel configs between different =0A=
transfers, i.e. run ppc4xx_init_dma_channel() to set read or write =0A=
mode.</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>Problem and =
cause:<BR>1. All =0A=
is well when running one channel at a time, but when starting/stopping a =
new =0A=
channel during the time another is active can - if you are unlucky - =
cause =0A=
problems.<BR>&nbsp;&nbsp; Because all channels SG start/stop bits are in =
the =0A=
same register (ASGC), it must not be read then changed and written to =
the way it =0A=
was done.<BR>&nbsp;&nbsp; That can cause a channel that is just done, to =
start =0A=
again, or a newly started channel to stop.<BR>&nbsp;&nbsp; The register =
includes =0A=
a feature that can be used as a semaphore - the read enable (mask) bits, =
but it =0A=
was not used correctly in the code, it was enabled for all channels in =
the =0A=
start-up.<BR>2. It is said in the comment of ppc4xx_init_dma_channel() =
that it =0A=
should only be used once in the start-up. If you comply, you will not =
have any =0A=
problem with it.<BR>&nbsp;&nbsp; However, when running this for a =
channel when =0A=
other channels are active, can cause channels to stop or maybe never =
give an =0A=
interrupt or false interrupts. The method clears the entire status =
register, not =0A=
only the bits for the given channel.</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>Solution:<BR>1. =
- In =0A=
ppc4xx_alloc_dma_handle(), do not touch the ASGC =
register!<BR>&nbsp;&nbsp; - In =0A=
ppc4xx_enable_dma_sgl() and ppc4xx_disable_dma_sgl(), when setting the =
ASGC =0A=
register, only change the given channel.<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
That's done =0A=
without reading the register at all, just set/clear the enable bit of =
the =0A=
channel to change, then set the MASK_ENABLE for the same =0A=
channel.<BR>&nbsp;&nbsp; Probably this is the way the register was =
intended to =0A=
be handled?</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>2. - In =0A=
ppc4xx_init_dma_channel(), only clear the correct bits of the DMASR =
register, =0A=
not the whole register.<BR>&nbsp;&nbsp;&nbsp;&nbsp; (The polarity was =
also not =0A=
set as it's supposed to in this function, but there exists a patch for =0A=
that)</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New"><FONT color=3D#000000 size=3D2>I can =
send a patch with =0A=
our changes, that works very well and stable, but there are many changes =
and not =0A=
all of them in line with the current official version of the files (we =
handle =0A=
the sg descriptor list differently). </FONT><FONT color=3D#000000 =
size=3D2>Maybe =0A=
someone feeling for it will take a look at the changes and make them =
into the =0A=
real code, since the above fixes does not interfere with the usage, only =0A=
improves thread safety.</FONT></FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>I have no idea =
if this has =0A=
been fixed in some patch already... but I have not seen it on this list =0A=
anyway.<BR>I'm not a regular poster, just want to help others avoid some =
of the =0A=
struggle when running many channels.</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>/Ronnie =0A=
Hedlund<BR></FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>Our changed =
code:<BR>In =0A=
"ppc4xx_dma.c"<BR>-----------------------<BR>/*<BR>&nbsp;*&nbsp; The =
comment =0A=
states that this function should only be run at start-up, and never =0A=
more.<BR>&nbsp;*&nbsp; That is unacceptable, with the fix it can be run =
anywhere =0A=
as long as the given channel is not running.<BR>&nbsp;*/<BR>int =0A=
ppc4xx_init_dma_channel(unsigned int dmanr, ppc_dma_ch_t * =0A=
p_init)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int =0A=
status_bits[] =3D { DMA_CS0 | DMA_TS0 | =0A=
DMA_CH0_ERR,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
DMA_CS1 | DMA_TS1 | =0A=
DMA_CH1_ERR,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
DMA_CS2 | DMA_TS2 | =0A=
DMA_CH2_ERR,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
DMA_CS3 | DMA_TS3 | DMA_CH3_ERR};</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int =0A=
polarity;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t control =
=3D =0A=
0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ppc_dma_ch_t *p_dma_ch =
=3D =0A=
&amp;dma_channels[dmanr];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_MODE_READ =3D =
(unsigned long) =0A=
DMA_TD; /* Peripheral to Memory =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
DMA_MODE_WRITE =3D 0;&nbsp;&nbsp;&nbsp;&nbsp; /* Memory to Peripheral =0A=
*/</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p_init) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_init_dma_channel: NULL =0A=
p_init\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return =
DMA_STATUS_NULL_POINTER;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dmanr &gt;=3D =0A=
MAX_PPC4xx_DMA_CHANNELS) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_init_dma_channel: bad channel %d\n", =0A=
dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return =
DMA_STATUS_BAD_CHANNEL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2>#if DCRN_POL =
&gt; =0A=
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; polarity =3D =0A=
mfdcr(DCRN_POL);<BR>#else<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
polarity =0A=
=3D 0;<BR>#endif</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup the control =
register =0A=
based on the values passed =0A=
to<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * us in =
p_init.&nbsp; =0A=
Then, over-write the control register with =0A=
this<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * new =0A=
value.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control |=3D =0A=
SET_DMA_CONTROL;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (dmanr) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
0:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
/* clear all polarity signals and then "or" in new signal levels =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity &amp;=3D =0A=
~GET_DMA_POLARITY(0);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt; =0A=
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_POL, =0A=
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_DMACR0, =0A=
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
1:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity &amp;=3D =0A=
~GET_DMA_POLARITY(1);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt; =0A=
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_POL, =0A=
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_DMACR1, =0A=
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
2:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity &amp;=3D =0A=
~GET_DMA_POLARITY(2);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt; =0A=
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_POL, =0A=
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_DMACR2, =0A=
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
3:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity &amp;=3D =0A=
~GET_DMA_POLARITY(3);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
polarity |=3D p_init-&gt;polarity;<BR>#if DCRN_POL &gt; =0A=
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_POL, =0A=
polarity);<BR>#endif<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
mtdcr(DCRN_DMACR3, =0A=
control);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
default:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return =
DMA_STATUS_BAD_CHANNEL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save these values =
in our =0A=
dma channel structure */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
memcpy(p_dma_ch, p_init, sizeof =0A=
(ppc_dma_ch_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
/*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * The peripheral =
width =0A=
values written in the control register =0A=
are:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =0A=
PW_8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =0A=
PW_16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =0A=
PW_32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
2<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =0A=
PW_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
3<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =
Since the =0A=
DMA count register takes the number of =0A=
"transfers",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*&nbsp;&nbsp; =0A=
we need to divide the count sent to us in =0A=
certain<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*&nbsp;&nbsp; =0A=
functions by the appropriate number.&nbsp; It so happens that =0A=
our<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp;&nbsp; =
right =0A=
shift value is equal to the peripheral width =0A=
value.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_dma_ch-&gt;shift =3D =0A=
p_init-&gt;pwidth;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
/*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Save the =
control word =0A=
for easy access.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_dma_ch-&gt;control =
=3D =0A=
control;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
/*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * clear status =
register =0A=
for the channel<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * =
only TS, =0A=
CS and RI needs to be =0A=
cleared.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtdcr(DCRN_DMASR, =0A=
status_bits[dmanr]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =0A=
DMA_STATUS_GOOD;<BR>}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 size=3D2><BR>In =0A=
"ppc4xx_sgdma.c"<BR>-----------------------</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>int<BR>ppc4xx_alloc_dma_handle(sgl_handle_t * phandle, unsigned =
int mode, =0A=
unsigned int dmanr)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
sgl_list_info_t *psgl =3D =
NULL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
ppc_dma_ch_t *p_dma_ch =3D =0A=
&amp;dma_channels[dmanr];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
//uint32_t sg_command;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dmanr &gt;=3D =0A=
MAX_PPC4xx_DMA_CHANNELS) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_alloc_dma_handle: invalid channel 0x%x\n", =0A=
dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return =
DMA_STATUS_BAD_CHANNEL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!phandle) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_alloc_dma_handle: null handle =0A=
pointer\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return =
DMA_STATUS_NULL_POINTER;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get memory for =
the listinfo =0A=
struct */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl =3D =0A=
kmalloc(sizeof(sgl_list_info_t), =0A=
GFP_KERNEL);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psgl =
=3D=3D NULL) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
*phandle =3D (sgl_handle_t) =0A=
NULL;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return =
DMA_STATUS_OUT_OF_MEMORY;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(psgl, 0, =0A=
sizeof(sgl_list_info_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dma_addr is unused now =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;dmanr =3D =0A=
dmanr;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
/*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Modify and save =
the =0A=
control word. These words will =0A=
be<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * written to each =
sgl =0A=
descriptor.&nbsp; The DMA engine =0A=
then<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * loads this =
control =0A=
word into the control =0A=
register<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * every =
time it =0A=
reads a new =
descriptor.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;control =3D =0A=
p_dma_ch-&gt;control;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Clear all =0A=
mode bits */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
psgl-&gt;control =0A=
&amp;=3D ~(DMA_TM_MASK | =
DMA_TD);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =0A=
Save control word and mode =
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;control |=3D (mode | =0A=
DMA_CE_ENABLE);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
PPC =0A=
Errata? DMA else ignore count on first in list =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;control |=3D =0A=
SET_DMA_TCE(1);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In MM mode, we must =
set =0A=
ETD/TCE */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mode =3D=3D =0A=
DMA_MODE_MM)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;control |=3D DMA_ETD_OUTPUT | =0A=
DMA_TCE_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =0A=
(p_dma_ch-&gt;int_enable) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
/* Enable channel interrupt =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;control |=3D =0A=
DMA_CIE_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;control &amp;=3D =0A=
~DMA_CIE_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we must not touch =
the SGC, =0A=
it can cause problems to other channels! */</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psgl-&gt;sgl_control =3D =0A=
SG_LINK;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(p_dma_ch-&gt;int_enable) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
if =0A=
(p_dma_ch-&gt;tce_enable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; =0A=
/* reuse as Terminal Count Interrupt Enable on all descr. =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;sgl_control |=3D =0A=
SG_TCI_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;sgl_control |=3D SG_ERI_ENABLE | =0A=
SG_ETI_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *phandle =3D =
(sgl_handle_t) =0A=
psgl;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =0A=
DMA_STATUS_GOOD;<BR>}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>void<BR>ppc4xx_enable_dma_sgl(sgl_handle_t =0A=
handle)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sgl_list_info_t *psgl =0A=
=3D (sgl_list_info_t *) =
handle;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
ppc_dma_ch_t *p_dma_ch;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t =0A=
sg_command;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_enable_dma_sgl: null =0A=
handle\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if =
(psgl-&gt;dmanr =0A=
&gt; (MAX_PPC4xx_DMA_CHANNELS - 1)) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_enable_dma_sgl: bad channel in handle =0A=
%d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if =0A=
(!psgl-&gt;phead) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_enable_dma_sgl: sg list =0A=
empty\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_dma_ch =3D =0A=
&amp;dma_channels[psgl-&gt;dmanr];<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =0A=
psgl-&gt;ptail-&gt;control_count &amp;=3D ~SG_LINK; /* make this the =
last dscrptr =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =0A=
(p_dma_ch-&gt;int_enable)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
/* Require Terminal Count interrupt on last =0A=
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;ptail-&gt;control_count |=3D =0A=
SG_TCI_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No more changes to =
tail object =0A=
allowed */<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
//dma_cache_wback((unsigned long)psgl-&gt;ptail, =0A=
sizeof(ppc_sgl_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
dma_cache_wback_inv((unsigned long)psgl-&gt;ptail, =0A=
sizeof(ppc_sgl_t));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
ppc4xx_set_sg_addr(psgl-&gt;dmanr, =0A=
virt_to_phys(psgl-&gt;phead));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_command =3D =0A=
0;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (psgl-&gt;dmanr) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
0:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D SSG0_ENABLE | =0A=
SSG0_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
1:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D SSG1_ENABLE | =0A=
SSG1_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
2:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D SSG2_ENABLE | =0A=
SSG2_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
3:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D SSG3_ENABLE | =0A=
SSG3_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
default:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_enable_dma_sgl: bad channel: %d\n", =0A=
psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
}<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtdcr(DCRN_ASGC, =0A=
sg_command);&nbsp;&nbsp; /* start transfer */<BR>}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>void<BR>ppc4xx_disable_dma_sgl(sgl_handle_t =0A=
handle)<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sgl_list_info_t *psgl =0A=
=3D (sgl_list_info_t *) =
handle;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
uint32_t sg_command;</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!handle) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_disable_dma_sgl: null =0A=
handle\n");<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if =
(psgl-&gt;dmanr =0A=
&gt; (MAX_PPC4xx_DMA_CHANNELS - 1)) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_disable_dma_sgl: bad channel in handle =0A=
%d\n",<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
return;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_command =3D 0; =
//disable =0A=
dma<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(psgl-&gt;dmanr) =0A=
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
0:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D =0A=
SSG0_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
1:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D =0A=
SSG1_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
2:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D =0A=
SSG2_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case =0A=
3:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =0A=
sg_command =3D =0A=
SSG3_MASK_ENABLE;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
break;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
default:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
printk("ppc4xx_disable_dma_sgl: bad channel: %d\n", =0A=
psgl-&gt;dmanr);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mtdcr(DCRN_ASGC, =0A=
sg_command);&nbsp;&nbsp; /* stop transfer */<BR>}</FONT></DIV>=0A=
<DIV><FONT face=3D"Courier New" color=3D#000000 =0A=
size=3D2>&nbsp;</DIV></FONT></BODY></HTML>
------_=_NextPart_001_01C5FB75.CC4FA936--
