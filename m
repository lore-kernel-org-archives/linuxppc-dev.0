From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Demke, Torsten" <Torsten.Demke@fci.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC852T with SCC3 and SMC1
Date: Fri, 12 Dec 2003 16:52:12 +0100
Message-ID: <NGENJJFPMHGLPILEKKAMEEPPCDAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0002_01C3C0D0.4A5152C0"
In-Reply-To: <9CFB9DA5261CD611A29B00508B789048071AAC06@ex-deu-munich02.force.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C3C0D0.4A5152C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Torsten,

I did all my tests in PPCBoot bootloader since I don't expect any additional problems in Linux.
Attached you can find a patch for cup/mpc8xx/serial.c in PPCBoot.

Regards, Stephan

> -----Original Message-----
> From: Demke, Torsten [mailto:Torsten.Demke@fci.com]
> Sent: Donnerstag, 11. Dezember 2003 10:57
> To: Stephan Linke
> Subject: RE: MPC852T with SCC3 and SMC1
>
>
> Hello Stephan,
>
> thanks for your help.
> Do you made changes in the Linux uart.c driver
> to work with the relocated data structures?
>
> Regards,
> Torsten
>
> > -----Original Message-----
> > From: Stephan Linke [mailto:Stephan.Linke@epygi.de]
> > Sent: Donnerstag, 11. Dezember 2003 08:02
> > To: Demke, Torsten
> > Subject: RE: MPC852T with SCC3 and SMC1
> >
> >
> > Hi Thorsten,
> >
> > you should look for a 860 microcode. It's a microcode that
> > allowes relocating SMC, I2C and SMC. I already did some tests
> > with it on
> > a 852T and it finaly worked fine. But I had a lot of trouble
> > getting PPCBoot running on it but that was due to some a giant array
> > allocated on the stack (console buffer).
> >
> >
> > Regards, Stephan
> >
> > > -----Original Message-----
> > > From: owner-linuxppc-embedded@lists.linuxppc.org
> > > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> > Behalf Of Demke,
> > > Torsten
> > > Sent: Mittwoch, 10. Dezember 2003 18:24
> > > To: linuxppc-embedded@lists.linuxppc.org
> > > Subject: MPC852T with SCC3 and SMC1
> > >
> > >
> > >
> > > Hello all,
> > >
> > > At one of our boards were using the MPC852T.
> > > It will use the SMC1 as UART _and_ SCC3 with ethernet.
> > > (SCC4 will also run  ethernet.)
> > > I know that SCC3 will overlap the Parameter RAM of SMC1 and
> > > I guess that there is a microcode patch to relocate the SMC1.
> > >
> > > There is already a microcode patch mentioned in the 8xx_io/
> > directory
> > > but it doesnt work at my board. Somebody uses this
> > microcode to relocate
> > > SMC1? (to which address?)
> > >
> > > I also tried to find a microcode patch for MPC852T
> > > at the motorola web-site but without success.
> > > Can anybody give me a hint where to find this microcode?
> > >
> > > Thanks for your help.
> > >
> > > Best regards,
> > >
> > > Torsten Demke
> > >
> > >
> >
> >
>
------=_NextPart_000_0002_01C3C0D0.4A5152C0
Content-Type: application/octet-stream;
	name="serial.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="serial.c.patch"

diff serial/ori/serial.c serial/new/serial.c=0A=
92a93,100=0A=
> #if defined(CFG_SMC_SPI_UCODE_PATCH)=0A=
> #ifdef CFG_ALLOC_DPRAM=0A=
> 	*(unsigned short*)&cp->cp_dparam[PROFF_SMC+0x3C] =3D =
dpram_alloc_align (52, 8) ;=0A=
> #else=0A=
> 	*(unsigned short*)&cp->cp_dparam[PROFF_SMC+0x3C] =3D =
CFG_SMC_RELOCATE_ADDR;=0A=
> #endif=0A=
> 	up =3D (smc_uart_t *) &cp->cp_dpmem[*(unsigned =
short*)&cp->cp_dparam[PROFF_SMC+0x3C]];=0A=
> #else=0A=
94c102=0A=
< =0A=
---=0A=
> #endif=0A=
182a191,198=0A=
> #if defined(CFG_SMC_SPI_UCODE_PATCH)=0A=
> 	up->smc_rstate =3D 0;=0A=
> 	up->smc_tstate =3D 0;=0A=
> 	up->smc_rbptr =3D up->smc_rbase;=0A=
> 	up->smc_tbptr =3D up->smc_tbase;=0A=
> #endif=0A=
> =0A=
> =0A=
213a230=0A=
> #if !defined(CFG_SMC_SPI_UCODE_PATCH)=0A=
221c238=0A=
< =0A=
---=0A=
> #endif=0A=
257c274,278=0A=
< 	up =3D (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC];=0A=
---=0A=
> #if defined(CFG_SMC_SPI_UCODE_PATCH)=0A=
> 	up =3D (smc_uart_t *) &cpmp->cp_dpmem[*(unsigned =
short*)&cpmp->cp_dparam[PROFF_SMC+0x3C]];=0A=
> #else=0A=
> 	up =3D (smc_uart_t *) &cpmp->cp_dparam[PROFF_SMC];=0A=
> #endif=0A=
291c312,316=0A=
< 	up =3D (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC];=0A=
---=0A=
> #if defined(CFG_SMC_SPI_UCODE_PATCH)=0A=
> 	up =3D (smc_uart_t *) &cpmp->cp_dpmem[*(unsigned =
short*)&cpmp->cp_dparam[PROFF_SMC+0x3C]];=0A=
> #else=0A=
> 	up =3D (smc_uart_t *) &cpmp->cp_dparam[PROFF_SMC];=0A=
> #endif=0A=
314c339,343=0A=
< 	up =3D (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC];=0A=
---=0A=
> #if defined(CFG_SMC_SPI_UCODE_PATCH)=0A=
> 	up =3D (smc_uart_t *) &cpmp->cp_dpmem[*(unsigned =
short*)&cpmp->cp_dparam[PROFF_SMC+0x3C]];=0A=
> #else=0A=
> 	up =3D (smc_uart_t *) &cpmp->cp_dparam[PROFF_SMC];=0A=
> #endif=0A=

------=_NextPart_000_0002_01C3C0D0.4A5152C0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
