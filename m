Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id F415B679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 01:15:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Help Needed: input overrun(s)
Date: Wed, 10 May 2006 10:15:21 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DD9F@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Stevan Ignjatovic" <stevan@iritel.com>,
	<s.maiti@tcs.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Stevan Ignjatovic
> Hello,
>=20
> > console we are receiving a print "ttyS: 1 input overrun(s)"=20
> along with=20
> > other prints of the driver and resulting in scrambled output.=20
> > Can anyone suggest why this is happening? Is the driver=20
> affecting the uart=20
> > driver?
>=20
> As far as UART driver is concerned, it could be affected if=20
> you did not
> carefully allocate some resources. Are you using MCC1 or MCC2? Channel
> specific parameters of MCC1 (channels 0-127) are at the=20
> beginning of the
> DPRAM (channel CH_NUM at address 64*CH_NUM). UART driver (as well as
> ethernet driver) allocates its buffer descriptors with
> m8260_cpm_dpalloc. I think that allocating with this function=20
> starts at
> the beginning of the DPRAM, so you might have overwritten=20
> UART's buffer
> descriptors. So, use MCC2 if you can. If you use some BRGs in your MCC
> driver you should check that as well.    =20

We have a MCC driver that we see the same happening on. It only occurs
under heavy load (top sows us usig 20-40 % cpu in interrupt).
I am pretty confident that we are not overwriting uart DPRAM. (MCC1 only
uses the middle 64 channels, skipping over the first 32 where the
conflict witht he UARTS are)

I have not seen it corrupt anything, so we have more or less ignored it.
Our theory is that it happens when the CPM gets overloaded.
It would be nice to actually fix it though....
