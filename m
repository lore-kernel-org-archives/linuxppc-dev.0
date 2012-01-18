Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFCABB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 11:28:28 +1100 (EST)
Received: by dadw1 with SMTP id w1so2790045dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 16:28:26 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1326771731.26116.29.camel@pasglop>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
 <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
 <4F0F7B60.5040701@gmail.com> <4F14E05C.30207@codeaurora.org>
 <1326771731.26116.29.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 17 Jan 2012 17:28:05 -0700
Message-ID: <CACxGe6ufk+BUoXZBKm5Q-O1Aj1j=18fJ5KjOC-fKQMbpw4z=mw@mail.gmail.com>
Subject: Re: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of the
 ppc one
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robherring2@gmail.com>, Michael Bohan <mbohan@codeaurora.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2012 at 8:42 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-01-16 at 18:43 -0800, Michael Bohan wrote:
>>
>> I was planning on sending these patches out, but it seems like with
>> Grant's patches, they may no longer be up to date. I was curious if any
>> thought was given to supporting configurations like this the one I
>> mentioned with the advent of these patches. I am happy to help test if
>> you can steer me in the right direction.
>
> I haven't had a chance to look in detail at what Grant is doing in his
> latest series, but the ppc domain scheme that he's basing it on has the
> concept of sparse interrupt domains.
>
> For these, we use a radix tree for the reverse map (we do not rely on a
> linear range) and we "allocate" linux IRQ numbers on-demand as we create
> mapping for individual HW interrupts.

My latest patches are primarily a direct port of the ppc code to be
generic for all architectures, and it does pretty much what you want.
As Ben suggests, you should look at the radix revmap code.  Use the
irq_domain_add_tree() function for creating the irq_domain, and there
is no need to even pre-allocate the number of hwirqs that you want to
support.  It uses a radix tree to manage arbitrary mappings from hwirq
number to linux numbers.

The other option is the linear map which maintains a static array with
one entry per hwirq number.  Use irq_domain_add_linear() to create one
and pass in the maximum number of hwirqs supported by the controller.
It will allocate an array of irq_desc* so that irq_descs can be
allocated dynamically.

It is also important to note that for both these revmaps, the actual
virq number is irrelevant.  The irq_domain is entirely responsible for
allocation and management.  There will be no need for a 'chunk of
virqs' assigned to an irq controller.

BTW: Ben, if you can carve out some time, I'd appreciate a look over
my series and make sure you're okay with it.  Once it's had some
testing by arm and ppc folks, I want to get it into linux-next.

g.
