Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 788CFB7D9F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jun 2010 10:40:08 +1000 (EST)
Received: by gyf2 with SMTP id 2so445908gyf.15
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 17:40:07 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276819045.8826.45.camel@pasglop>
References: <20100604212134.10552.70717.stgit@angua>
	<20100604212155.10552.19260.stgit@angua>
	<1276152002.1962.55.camel@pasglop>
	<AANLkTinmDFBvAjcjrgf3RHuiXgNxVV20yLzBaqhE5lrk@mail.gmail.com>
	<1276219072.1962.82.camel@pasglop>
	<AANLkTin5K0IL5iKj9i9qBucSpQz2-p5wIvUtC4iU0jUP@mail.gmail.com>
	<1276819045.8826.45.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 17 Jun 2010 18:39:47 -0600
Message-ID: <AANLkTikgNZakdVmIF4QcRQJWXUaczIWbJPmx2-W--QSc@mail.gmail.com>
Subject: Re: [PATCH 5/5] of/irq: merge of_irq_map_one()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 17, 2010 at 5:57 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2010-06-17 at 17:11 -0600, Grant Likely wrote:
>> On Thu, Jun 10, 2010 at 7:17 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Thu, 2010-06-10 at 17:36 -0600, Grant Likely wrote:
>> >>
>> >> Okay. =A0I had been trying to avoid #ifdefs in the common code, but
>> >> you're probably right. =A0I'll rework.
>> >
>> > Not even ifdef's ... just move the quirk map there. You can always
>> > #define the quirk variable to 0 on archs that have no quirks, to
>> > make it compile away if you believe it represents bloat, but they
>> > are simple well localized things so I doubt it matters.
>>
>> They're pretty small, but powermac32 is the only code that actually
>> uses the quirk facility. =A0Everything else parses sanely it would
>> appear. =A0I'd rather have them localized to the powermac code and
>> eliminate the quirks from the common code.
>
> Maybe, but the way you end up gutting out some internal functions of the
> parser so they can be overriden by the arch is just plain gross :-)

Heh, I won't dispute that.  Give me a day or so.  If I can't come up
with anything better, then I'll just move it all over.

g.
