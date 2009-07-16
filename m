Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 40157B7096
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 08:37:55 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id 9DEF9DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 08:37:53 +1000 (EST)
Received: by yxe37 with SMTP id 37so754414yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 15:37:51 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090716212129.70710832E416@gemini.denx.de>
References: <1247578966-9847-1-git-send-email-wd@denx.de>
	<1247671133-12148-1-git-send-email-wd@denx.de>
	<fa686aa40907151017n76524708tdb028689adad4b5f@mail.gmail.com>
	<20090716212129.70710832E416@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Jul 2009 16:37:31 -0600
Message-ID: <fa686aa40907161537t46f24258h5f320d196b715843@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] fs_enet/mii-fec.c: fix MII speed calculation
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 16, 2009 at 3:21 PM, Wolfgang Denk<wd@denx.de> wrote:
> Dear Grant Likely,
>
> In message <fa686aa40907151017n76524708tdb028689adad4b5f@mail.gmail.com> =
you wrote:
>> On Wed, Jul 15, 2009 at 9:18 AM, Wolfgang Denk<wd@denx.de> wrote:
>> > The MII speed calculation was based on the CPU clock (ppc_proc_freq),
>> > but for MPC512x we must use the bus clock instead.
>> >
>> > This patch makes it use the correct clock and makes sure we don't
>> > clobber reserved bits in the MII_SPEED register.
> ...
>> Drop the common code bit. =A0The 5200 and 5121 are different devices and
>> it is a tiny bit of code. =A0I don't think there is any benefit to
>> having it as a common function. =A0Just roll the get_mii_speed function
>> in the mii-fec driver itself.
>
> I don't like to see the code repeated - it makes maintenance harder
> and increases the memory footprint. But if you like it that way I'll
> do that.

Neither do I, but in this case has some mitigating factors.  diff stat
is interesting:

Old:
 arch/powerpc/include/asm/mpc5xxx.h   |   10 +++++++++
 arch/powerpc/sysdev/mpc5xxx_clocks.c |   37 ++++++++++++++++++++++++++++++=
++++
 drivers/net/fs_enet/mii-fec.c        |   13 +++++++++--
 drivers/net/fec_mpc52xx.c     |    2 +-
 drivers/net/fec_mpc52xx_phy.c |    6 ++++--
 5 files changed, 62 insertions(+), 6 deletions(-)

New:
 drivers/net/fs_enet/mii-fec.c |   35 +++++++++++++++++++++++++++++++----
 drivers/net/fec_mpc52xx.c     |    2 +-
 drivers/net/fec_mpc52xx_phy.c |   21 ++++++++++++++++++---
 3 files changed, 50 insertions(+), 8 deletions(-)

If the two devices were somewhat related then my opinion might be
different.  However the combination of the tiny amount of calculation
code, the drivers being kept completely separate (or at least as
separate as they were before), the smaller code impact, and the lower
driver complexity (because the calculation code is inline instead of
in a different file) makes me like the second approach is better.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
