Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 467282C0112
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 04:33:19 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: Clearing DBSR and DBCR0 in host handler.
Date: Wed, 3 Apr 2013 17:33:12 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D06FBE995@039-SN2MPN1-013.039d.mgd.msft.net>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D06FBE661@039-SN2MPN1-013.039d.mgd.msft.net>
 <C62C333B-D3CA-4AE2-B9DF-39E3CF73A3C5@kernel.crashing.org>
In-Reply-To: <C62C333B-D3CA-4AE2-B9DF-39E3CF73A3C5@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, April 03, 2013 9:41 PM
> To: Bhushan Bharat-R65777
> Cc: linuxppc-dev@lists.ozlabs.org; Benjamin Herrenschmidt; Alexander Graf=
; Wood
> Scott-B07421
> Subject: Re: Clearing DBSR and DBCR0 in host handler.
>=20
>=20
> On Apr 3, 2013, at 10:24 AM, Bhushan Bharat-R65777 wrote:
>=20
> > Hi All,
> >
> > The kernel exception handling code for 32 bit (transfer_to_handler in
> entry_32.S) clear DBSR and load DBCR0 with 0 (global_dbcr0 variable, whic=
h is
> zero) if user space used debug (DBCR0.IDM set).
> >
> > But I do not same (clearing DBCR0 and DBSR) in 64bit exception handler.=
 Is
> this an issue or I am missing something?
> >
> > Thanks
> > -Bharat
>=20
> Are you having a problem with debug w/the 64-bit kernel?

No not any issue, I was looking into code where it saves/restores of debug =
register. I observed the above said inconsistency in 32 bit and 64 bit.

>  The 32-bit kernel
> supports several kernel level debug features that the 64-bit doesn't supp=
ort.

I am talking about the a user process debugging:
	-  A user process is under debugging using gdb. So the h/w debug register =
will have thread context.
	-  An interrupt/exception happens in user process.
	-  Now on 32 bit we clear the DBSR (pending events) and DBCR0 (so no new e=
vents get captured). But on 64bit we do not follow same, Why it is so?
	   Are we doing something extra on 32 bit or something is missing on 64 bi=
t?=20
	   Can it happen that on 64 bit some more debug events get captured and de=
bug interrupts get fired if MSR.DE is set, which is undesired.=20

Or I am missing something here ?

Thanks
-Bharat

> So if you are having an issue that might be more helpful to convey that j=
ust
> asking about exception code path.
>=20
> - k
