Return-Path: <glikely@secretlab.ca>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4E61B70A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 07:27:38 +1100 (EST)
Received: by obbup6 with SMTP id up6so1895519obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 12:27:36 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20120223202534.GE22562@n2100.arm.linux.org.uk>
References: <20120223112915.GT22562@n2100.arm.linux.org.uk>
 <1330028339.20389.28.camel@pasglop>
 <20120223202534.GE22562@n2100.arm.linux.org.uk>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 23 Feb 2012 13:27:16 -0700
Message-ID: <CACxGe6s7H7i9TRNDCNXPxuz1WUfMbQxkBy5jCeMrE_3HY4hkQg@mail.gmail.com>
Subject: Re: in_be32() etc
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2012 at 1:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 24, 2012 at 07:18:59AM +1100, Benjamin Herrenschmidt wrote:
>> On Thu, 2012-02-23 at 11:29 +0000, Russell King - ARM Linux wrote:
>> > What's this stuff doing in generic drivers?
>>
>> Well, I suppose that's because the xilinx stuff used to be ppc
>> only ? :-)
>
> Note that's just the first one grep turned up. =A0I've no idea which spec=
ific
> drivers the ST SPEAr people are wanting these accessors for (they didn't
> include that information in their submission adding them to ARM.)
>
>> > See drivers/gpio/gpio-xilinx.c:
>> > static int xgpio_get(struct gpio_chip *gc, unsigned int gpio)
>> > {
>> > =A0 =A0 =A0 =A0 struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(g=
c);
>> >
>> > =A0 =A0 =A0 =A0 return (in_be32(mm_gc->regs + XGPIO_DATA_OFFSET) >> gp=
io) & 1;
>> > }
>> >
>> > include/linux/of_gpio.h:
>> > struct of_mm_gpio_chip {
>> > =A0 =A0 =A0 =A0 struct gpio_chip gc;
>> > =A0 =A0 =A0 =A0 void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
>> > =A0 =A0 =A0 =A0 void __iomem *regs;
>> > };
>> >
>> > Why am I being asked to add in_be32() etc to ARMs io.h ? =A0Why do we =
need
>> > yet another set of IO accessors? =A0Is there something wrong with
>> > ioread*()/ioread*be() etc?
>>
>> Nope, nothing wrong with them, the driver should be fixed. in_be* is
>> historical ppc stuff.
>>
>> > My guess is this stems from a lack of proper review
>>
>> That or history. Our readX/writeX used to be more PCI specific (have
>> infrastructure to work around PCI bridge bugs) which some drivers
>> avoided using the in_/out_ variants, in some case it's just pure
>> history, etc... Some of these things are ancient.
>
> So, if I tell the SPEAr people that any driver they come across using
> these old in_XX should be converted to use ioread*() you'll be happy
> for that to happen?

yes

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
