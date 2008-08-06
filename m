Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 8B9FEDE11D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 09:02:45 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so27988anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 16:02:39 -0700 (PDT)
Message-ID: <fa686aa40808061602v53c2104cm1b666a4a6b180433@mail.gmail.com>
Date: Wed, 6 Aug 2008 17:02:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
In-Reply-To: <75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 4:11 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Aug 6, 2008, at 4:54 PM, Grant Likely wrote:
>
>> On Wed, Aug 6, 2008 at 8:07 AM, Kumar Gala <galak@kernel.crashing.org>
>> wrote:
>>>
>>> On Aug 6, 2008, at 1:02 AM, Grant Likely wrote:
>>>
>>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>>
>>>> ioremap_bat() is useful for things like mapping SoC internally memory
>>>> mapped
>>>> register and early text because it allows mappings to devices to be
>>>> setup
>>>> early in the boot process where they are needed, and the mappings
>>>> persist
>>>> after the MMU is configured.
>>>>
>>>> Without ioremap_bat(), setting up the MMU would cause the early text
>>>> mappings to get lost and mostly likely result in a kernel panic on the
>>>> next
>>>> attempt at output.
>>>>
>>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>>> ---
>>>
>>> why can't we just do this in ioremap itself?
>>
>> I suppose we could; but the usecase is somewhat different and I wanted
>> to keep it simple.  Using a separate API also helps reenforce that the
>> caller really needs to know what they are doing because BATs are a
>> limited resource.
>
> there is a bunch of error checking and difference in semantics that you need
> to fix.

details please?  I agree that it can be tightened up in some areas,
but I'd like to know if you've seen something I haven't.

>  I think introduce a new API for this is silly,

I don't think so.  I actually prefer it being an different API.  It
forces the caller to understand what the function does.  It forces the
programmer to think and to understand the effect of mapping large io
blocks.

> especially since we
> expect there to only be one actual invocation of the API for serial console
> access.

Actually, this is not only for early serial.  Early serial just
happens to be the first user.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
