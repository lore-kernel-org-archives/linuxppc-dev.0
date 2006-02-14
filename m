Return-Path: <jcrigby@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.204])
	by ozlabs.org (Postfix) with ESMTP id CB15167B34
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 04:35:58 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id r21so972793wxc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 09:35:57 -0800 (PST)
Message-ID: <4b73d43f0602140935l3eb9fa74k9790b183fb604902@mail.gmail.com>
Date: Tue, 14 Feb 2006 10:35:18 -0700
From: John Rigby <jcrigby@gmail.com>
To: Asier Llano Palacios <a.llano@ziv.es>
Subject: Re: Stability of MPC5200 FEC
In-Reply-To: <1139818081.14894.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1139592010.14894.22.camel@localhost.localdomain>
	<43EE029A.5040504@246tNt.com>
	<1139818081.14894.45.camel@localhost.localdomain>
Cc: John Rigby <jrigby@freescale.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Asier,

I tried copying 700MB files to my lite board with ftp on sylvain's
latest kernel
and was not able to reproduce the problem.  One thing I did see
though were lots of RX framing errors.  I will investigate this further.

I consulted with someone in Freescale who knows a lot more about
bestcomm dma and the 5200 than me and his best guess was
that there is a problem in error handling.  Can you have your
partner report what the error counts reported by ifconfig are?
This might give us some clue about what is leading to the problem.

Thanks
John
jrigby@freescale.com
jcrigby@gmail.com

On 2/13/06, Asier Llano Palacios <a.llano@ziv.es> wrote:
> El s=E1b, 11-02-2006 a las 16:28 +0100, Sylvain Munaut escribi=F3:
> > Asier Llano Palacios wrote:
> > Did you ever observe that behavior on a lite5200 ?
> > What is 'long uptime' and do you have sustained transfer during that
> > period ? (To try reproduice the problem).
>
> Weeks uptime. We don't work with the lite5200 for so long time, but our
> board is based on a lite5200, and the FEC configuration is exactly
> equal.
>
> > Also, what are the 'symptoms' ? (anything in dmesg ?)
>
> FEC doesn't work at all, everything else works. If using a console I
> execute 'ifconfig eth0 down && ifconfig eth0 up <IP>' the fec starts
> working again.
> I haven't reproduced it directly, but a partner and a customer. I'll try
> to reproduce this behaviour myself and bring back more information.
>
> > I haven't touched the FEC code much except to remove the
> > aligment code (newer bestcomm microcode doesn't require alignement of
> > the skb).
> >
> > You can send me the driver/net/fec_mpc52xx and arch/ppc/syslib/bestcomm
> > you're using, I'll tell you if there was major changes.
>
> I've sent to you the patches that I extracted from your kernel source
> tree some time ago.
> I have all the patches until the 1.2161 one. But I've only sent to you
> the ones related to the FEC and the bestcomm.
>
>
> --
> Asier Llano Palacios
> ZIV I+D Smart Energy Networks
> Dpto. Ingenier=EDa de Desarrollo.
>
> ZIV, Aplicaciones y Tecnolog=EDa.
> Parque Tecnol=F3gico, 210
> 48170 ZAMUDIO (Bizkaia)
>
> E-mail: a.llano@ziv.es
> Tlfno: 944037400
>
> ----------------------------------------- PLEASE NOTE -------------------=
------------------------
> This message, along with any attachments, may be confidential or legally =
privileged.
> It is intended only for the named person(s), who is/are the only authoriz=
ed recipients.
> If this message has reached you in error, kindly destroy it without revie=
w and notify the sender immediately.
> Thank you for your help.
> =B5SysCom uses virus scanning software but excludes any liability for vir=
uses contained in any attachment.
>
> ------------------------------------ ROGAMOS LEA ESTE TEXTO -------------=
------------------
> Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.
> Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas co=
mo =FAnico destinatario autorizado.
> Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin r=
evisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. Gracias=
 por su colaboraci=F3n.
> =B5SysCom utiliza software antivirus, pero no se hace responsable de los =
virus contenidos en los ficheros anexos.
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>
