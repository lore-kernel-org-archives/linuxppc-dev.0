Return-Path: <Horia.Geanta@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0130.outbound.protection.outlook.com [157.56.111.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D93D61A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 20:37:09 +1100 (AEDT)
Message-ID: <54FD6657.9000703@freescale.com>
Date: Mon, 9 Mar 2015 11:22:31 +0200
From: =?UTF-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@freescale.com>
MIME-Version: 1.0
To: Kim Phillips <kim.phillips@freescale.com>, Martin Hicks <mort@bork.org>
Subject: Re: [PATCH 2/2] crypto: talitos: Add AES-XTS Support
References: <1424451610-5786-1-git-send-email-mort@bork.org>
 <1424451610-5786-3-git-send-email-mort@bork.org>
 <20150305181615.493b173d43249548fae29203@freescale.com>
 <CAJUS3XmfcJCiBMnsiXKpc=QXE-YxTQy67wZyAXgKjtY_DN0CDQ@mail.gmail.com>
 <20150306191617.bbc38506ae2242dc20fdfee4@freescale.com>
In-Reply-To: <20150306191617.bbc38506ae2242dc20fdfee4@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/7/2015 3:16 AM, Kim Phillips wrote:
> On Fri, 6 Mar 2015 11:49:43 -0500
> Martin Hicks <mort@bork.org> wrote:
> 
>> On Thu, Mar 5, 2015 at 7:16 PM, Kim Phillips <kim.phillips@freescale.com> wrote:
>>> On Fri, 20 Feb 2015 12:00:10 -0500
>>> Martin Hicks <mort@bork.org> wrote:
>>>
>>>> The newer talitos hardware has support for AES in XTS mode.
>>>
>>> Assuming it's the same thing, AES-XCBC gets added with SEC v3.0
>>> h/w.  Assuming hw_supports() doesn't already support this algorithm
>>
>> AES-XCBC isn't the same thing as AES-XTS.
> 
> Thanks.
> 
>>> combination (technically via the mode bit), this needs to be
>>> reflected in the patch so the driver doesn't think SEC 2.x devices
>>> can do XTS, too.
>>
>> Right.  I hadn't looked into how exactly hw_supports() works.  It only
>> indicates which execution units are present (in this case the AES
>> unit).  I actually think XTS gets introduced in SEC v3.3.2.  I also
>> have an MPC8379 (sec3.3) and it does not have XTS.
>>
>> Can you look internally to find out in which hardware it was
>> introduced?  Is there a SEC 3.3.1 that also has XTS?
> 
> later MPC8315Es had a SEC v3.3.1, but AFAICT, it doesn't support
> XTS, so, yes, it's likely v3.3.2 and above (if any).

There's a public application note on freescale.com:
"AN3645 - SEC 2x/3x Descriptor Programmer's Guide" (Rev.3/2010)

"Table 4 - EUs Supported in Each SEC Version" summarizes which
algorithms / modes are supported for every talitos version.
Unfortunately this goes up to SEC 3.3.1.
Since XTS doesn't show up, 3.3.2 would be the first supporting it.

Horia
