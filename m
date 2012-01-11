Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0439B6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2012 08:27:22 +1100 (EST)
Received: by pbz3 with SMTP id 3so838782pbz.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 13:27:21 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4F0DFC0F.2090005@gmail.com>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 Jan 2012 14:27:00 -0700
Message-ID: <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
Subject: Re: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of the
 ppc one
To: Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2012 at 2:15 PM, Rob Herring <robherring2@gmail.com> wrote:
> Grant,
>
> On 01/11/2012 02:22 PM, Grant Likely wrote:
>> This patch removes the simplistic implementation of irq_domains and enab=
les
>> the powerpc infrastructure for all irq_domain users. =A0The powerpc
>> infrastructure includes support for complex mappings between Linux and
>> hardware irq numbers, and can manage allocation of irq_descs.
>>
>> This patch also converts the few users of irq_domain_add()/irq_domain_de=
l()
>> to call irq_domain_add_legacy() instead.
>
> So what is the non-legacy way? Legacy implies we don't want to do it
> that way. I guess until we remove all non-DT platforms with GIC we are
> stuck with legacy. That seems like it could be a ways out until we get
> there.

Non-legacy is letting the irq_domain manage the irq_desc allocations.
Some of the controllers will be easy to convert, some will be more
difficult.  The primary thing that really blocks getting away from the
legacy method is anything that expects hardcoded #defined irq numbers.
 The goal is to convert all users over to the linear revmap method.

g.
