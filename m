Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 3479DB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 01:22:30 +1000 (EST)
Received: by gxk26 with SMTP id 26so473097gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 08 Jul 2010 08:22:25 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <181804936ABC2349BE503168465576460F3D3E66@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
	<1278565845.28659.75.camel@pasglop>
	<AANLkTilNssNdEW3wBKfoUMbSQMFLywfFgGMb0F9XwKeG@mail.gmail.com>
	<181804936ABC2349BE503168465576460F3D3E66@exchserver.basler.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 8 Jul 2010 09:22:03 -0600
Message-ID: <AANLkTikP_ZrWddakihhslDHphEaDsW-IQY4C-lDoXEgm@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
To: Steve Deiters <SteveDeiters@basler.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 8, 2010 at 8:38 AM, Steve Deiters <SteveDeiters@basler.com> wro=
te:
>> -----Original Message-----
>> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On
>> Behalf Of Grant Likely
>> Sent: Thursday, July 08, 2010 12:38 AM
>> To: Benjamin Herrenschmidt
>> Cc: Steve Deiters; linuxppc-dev@lists.ozlabs.org
>> Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use
>> alternate memcpy for MPC512x and MPC52xx
>>
>> On Wed, Jul 7, 2010 at 11:10 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > On Tue, 2010-06-29 at 11:04 -0500, Steve Deiters wrote:
>> >> These processors will corrupt data if accessing the local bus with
>> >> unaligned addresses. This version fixes the typical case
>> of copying
>> >> from Flash on the local bus by keeping the source address always
>> >> aligned.
>> >
>> > Shouldn't this be solved by using memcpy_to/fromio ?
>>
>> Maybe. =A0plain memcpy() access to anything localbus-attached
>> on the mpc5xxx is the wrong thing to do. =A0memcpy_to/fromio
>> might do the right thing; but the caller must understand the
>> limitations of the localplus bus. =A0The byte-wise alignment
>> that memcpy_to/fromio() does may not work (depending on
>> configuration).
>>
>> Steve, what code is doing a memcpy from flash?
>>
>> g.
>
> This was done in the JFFS2 code, in fs/jffs2/scan.c. =A0At least in one
> function, in jffs2_scan_dirent_node it was using memcpy on a localbus
> mapped structure. =A0I was getting JFFS2 filesystem corruption because of
> this. =A0In fact I first tried changing this to memcpy_fromio and it fixe=
d
> that particular problem. =A0I was concerned though that other places I wa=
s
> not aware of might be using memcpy from the localbus in a similar manner
> so I decided to just tweak the memcpy routine.

[cc'ing David Woodhouse]

Sounds to me like the right thing to do is to fix the jffs2 code.

> Just out of curiousity, what configuration might cause a byte-wise
> alignment not to work?

Can't remember the register configuration, but I worked on one project
where this was the case.  In hindsight, it was probably a
mis-configuration of the localbus CS for the particular device.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
