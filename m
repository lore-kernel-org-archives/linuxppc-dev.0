Return-Path: <pantelis.antoniou@konsulko.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDC2A1A0651
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 06:00:07 +1100 (AEDT)
Received: by mail-wi0-f180.google.com with SMTP id bs8so18345402wib.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 11:00:04 -0800 (PST)
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
Date: Mon, 19 Jan 2015 20:59:59 +0200
Message-Id: <FDF8BE77-015A-41AD-A5FA-8FFB40AFDAE2@konsulko.com>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Julia Lawall <julia.lawall@lip6.fr>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

> On Jan 19, 2015, at 20:55 , Wolfram Sang <wsa@the-dreams.de> wrote:
>=20
> Back in the days, sysfs seemed to have refcounting issues and =
subsystems
> needed a completion to be safe. This is not the case anymore, so I2C =
can
> get rid of this code. There is noone else besides I2C doing something
> like this currently (checked with the attached coccinelle script which
> checks if a release function exists and if it contains a completion).
>=20
> I have been digging through the history of linux.git and
> linux-history.git and found that e.g. w1 used to have such a mechanism
> and also simply removed it later.
>=20
> Some more info from Greg Kroah-Hartman:
> "Having that call "wait" for the other release call to happen is =
really
> old, as Jean points out, from 2003.  We have "fixed" sysfs since then =
to
> detach the files from the devices easier, we used to have some nasy
> reference count issues in that area."
>=20
> And some testing from Jean Delvare which matches my results:
> "However I just tested unloading an i2c bus driver while its adapter's
> new_device attribute was opened and rmmod returned immediately. So it
> doesn't look like accessing sysfs attributes actually takes a =
reference
> to the underlying i2c_adapter."
>=20
> Let's get rid of this code before really nobody knows/understands
> anymore what this was for and if it has a subtle use.
>=20

Hehe, rather obliquely tested by me too :)

Please save the reference counter hackers sanity and merge this :)

> Reported-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> =E2=80=94
>=20
Regards

=E2=80=94 Pantelis=
