Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 913331A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 10:36:52 +1000 (AEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 6A9AF1412E6
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2015 10:36:52 +1000 (AEST)
Message-ID: <1433205412.24546.30.camel@neuling.org>
Subject: Re: [PATCH] cxl: Set up and enable PSL Timebase
From: Michael Neuling <mikey@neuling.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Cc: imunsie@au1.ibm.com, linuxppc-dev@ozlabs.org,
 vaibhav@linux.vnet.ibm.com,  Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Tue, 02 Jun 2015 10:36:52 +1000
In-Reply-To: <556C64A6.2050905@linux.vnet.ibm.com>
References: <1432818778-27819-1-git-send-email-felix@linux.vnet.ibm.com>
 <1433140899.24546.14.camel@neuling.org>
 <556C64A6.2050905@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-01 at 15:56 +0200, Philippe Bergheaud wrote:
> Michael Neuling wrote:
>  > Please use negative error codes here.  -EIO?
>  > And check it here.
>=20
> Mikey,
>=20
> I am reluctant to fail the entire CAPI init after a PSL timebase sync fai=
lure.
> If we ignore the error, the CAPI device stays available (without timebase=
 sync).
> If we honour the error, the CAPI device fails entirely.
>=20
> I know three reasons why PSL timebase sync can fail:
> 1. h/w failure

This would be a good reason to fail it.  Bad hardware, we should fail.

> 2. OPAL did not initialize the CAPP timebase (wrong OPAL version)

This would not as we are going to have to deal with older opal for a
while.

Is there a way for us to tell if OPAL has this capability?  I guess we
could add something to the device tree of the PHB node if we know the
timebase has been synced.

> 3. the PCIe bus was not powered off/on between shutdown and reboot

We should fix that.  What's the problem?

> I think that it is premature to choose to fail the entire CAPI init in al=
l cases.
> In particular, point 3. introduces a regression, as PCIe off/on was never=
 a requirement for booting CAPI on P8.

We should fix it.  Is a PERST enough?

> I have tried one workaround do far: forcing the 0 to 1 transition of the =
tb bit of the PSL register TB_CTLSTAT.
> In vain.
>=20
> What do you think?

The OPAL one (2) is the most concerning but let's work out if we can
determine if the syncing has happened in the CAPP unit or not.  If we
know it's synced but it fails your test, then I think we should fail the
whole probe. =20

I the other reasons (1 and 3) shouldn't be ignored. =20

Mikey
