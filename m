Return-Path: <R.Patil@mei-india.com>
Received: from antispam.messung.com (outbond.messung.com [210.212.173.45])
 by ozlabs.org (Postfix) with ESMTP id 9305D2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 22:34:33 +1100 (EST)
In-Reply-To: <1357928171.5475.4@snotra>
Subject: Re: [Solved] Interrupt handler not executed
From: R.Patil@mei-india.com
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFF2DB166D.6CFADCBA-ON65257AF3.003F9206-65257AF3.003F9210@LocalDomain>
Date: Mon, 14 Jan 2013 17:04:21 +0530
Content-Type: text/plain;
	charset=ISO-8859-1
MIME-Version: 1.0
References: <OFFE4470AC.C2444613-ON65257AF0.0029CACD-65257AF0.0029CAD8@LocalDomain>,
 <1357928171.5475.4@snotra>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,

Thanks for your immediate response. The problem has been resolved. Actually=
, I was wrong in pointing out the problem.=20

The problem was lying in interrupt handler. The first statement in interrup=
t handler was disable=5Firq() which was leading into a deadlock. I replaced=
 'disable=5Firq' with 'disable=5Firq=5Fnosync()' and it worked. =20

Thanks and Regards,
Rahul Patil

-----Scott Wood <scottwood@freescale.com> wrote: -----

To: <R.Patil@mei-india.com>
From: Scott Wood <scottwood@freescale.com>
Date: 01/11/2013 11:46PM
Cc: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Interrupt handler not executed

On 01/11/2013 01:36:29 AM, R.Patil@mei-india.com wrote:
> Hello,
>=20
> We are working on board based on Freescale MPC8313ERDB. We have =20
> ported linux 3.0.46 kernel on it. In one of device driver written by =20
> us, we need to take some action upon asserting IRQ0 interrupt. For =20
> this we have written interrupt handler which takes care of this. We =20
> are able register interrupt handler successfully with the help of =20
> 'request=5Firq'. We confirmed this by checking respective entry in =20
> '/proc/interrupts'. We have also confirmed assertion of interrupt =20
> line (IRQ0) on oscilloscope. The problem is, interrupt handler does =20
> not execute upon asserting the interrupt line.

What IRQ number did you pass to request=5Firq()?  request=5Firq() takes =20
virtual interrupt numbers, not anything out of the chip manual.

If that's not the issue, is the interrupt configured properly for level =20
and sense?

-Scott

Email Disclaimer:
  ---------------------------

This e-mail and any files transmitted with it are for the sole use of the i=
ntended recipient(s) and may contain confidential and  privileged informati=
on. Computer viruses can be transmitted via email.The recipient should chec=
k this email and any  attachments for the presence of viruses. The company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
