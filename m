Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 547D71007D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2012 19:46:32 +1100 (EST)
Received: by dadv40 with SMTP id v40so3732699dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2012 00:46:29 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20120102082514.GG18381@ponder.secretlab.ca>
References: <20111228194949.ff20a609745e816c266f7d91@canb.auug.org.au>
 <1325068334.6632.43.camel@pasglop>
 <20120102082514.GG18381@ponder.secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Jan 2012 01:39:06 -0700
Message-ID: <CACxGe6txjt62u8fm8UBEfBDHmftgXO0XJJKQmAmh2Cy86ZfRaA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the final tree (powerpc
 related)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Benoit Cousson <b-cousson@ti.com>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 2, 2012 at 1:25 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Wed, Dec 28, 2011 at 09:32:14PM +1100, Benjamin Herrenschmidt wrote:
>> On Wed, 2011-12-28 at 19:49 +1100, Stephen Rothwell wrote:
>> > Hi ,
>> >
>> > After merging the final tree, today's linux-next build (powerpc
>> > allyesconfig) failed like this:
>> >
>> > kernel/built-in.o: In function `irq_dispose_mapping':
>> > (.opd+0x159f0): multiple definition of `irq_dispose_mapping'
>> > arch/powerpc/kernel/built-in.o:(.opd+0x960): first defined here
>> > kernel/built-in.o: In function `irq_create_of_mapping':
>> > (.opd+0x15a20): multiple definition of `irq_create_of_mapping'
>> > arch/powerpc/kernel/built-in.o:(.opd+0x9a8): first defined here
>> > kernel/built-in.o: In function `.irq_create_of_mapping':
>> > (.text+0x147030): multiple definition of `.irq_create_of_mapping'
>> > arch/powerpc/kernel/built-in.o:(.text+0x9de0): first defined here
>> > kernel/built-in.o: In function `.irq_dispose_mapping':
>> > (.text+0x146f4c): multiple definition of `.irq_dispose_mapping'
>> > arch/powerpc/kernel/built-in.o:(.text+0x9684): first defined here
>> >
>> > I am not sure what caused this. And have just left it broken.
>>
>> Grant, is your irq remapper misbehaving ?
>
> Hmmmm, that's odd. =A0I've not touched it. =A0I'll investigate.

It looks like CONFIG_IRQ_DOMAIN is getting selected by TWL4030_CORE.
Drivers must not select that config symbol.  It looks like commit
da28adbd (mfd: twl-core: Add initial DT support for twl4030/twl6030)
is the culprit.

The following patch should solve the problem:

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 13c468e..e43a570 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -200,8 +200,7 @@ config MENELAUS

 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
-	depends on I2C=3Dy && GENERIC_HARDIRQS
-	select IRQ_DOMAIN
+	depends on I2C=3Dy && GENERIC_HARDIRQS && IRQ_DOMAIN
 	help
 	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
 	  This core driver provides register access and IRQ handling
