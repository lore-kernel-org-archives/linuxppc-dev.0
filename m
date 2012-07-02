Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62C8E2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 07:34:29 +1000 (EST)
Subject: Re: [PATCH] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4FF21343.20408@freescale.com>
Date: Mon, 2 Jul 2012 23:34:21 +0200
Message-Id: <23F3EB4C-799C-41EF-BAB8-360DF220FC62@suse.de>
References: <1341262574-2841-1-git-send-email-stuart.yoder@freescale.com>
 <40388C8A-6D3B-409E-9C6D-45005E1F6016@suse.de>
 <1341264368.2588.49.camel@pasglop>
 <DAF1D512-B0CF-497D-8626-1C75103C6EA0@suse.de> <4FF21343.20408@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2012, at 23:31, Scott Wood wrote:

> On 07/02/2012 04:27 PM, Alexander Graf wrote:
>>=20
>> On 02.07.2012, at 23:26, Benjamin Herrenschmidt wrote:
>>=20
>>> On Mon, 2012-07-02 at 22:59 +0200, Alexander Graf wrote:
>>>> This should go into an #ifdef __ASSEMBLY__ block, right? :)
>>>=20
>>> We almost never use #ifdef __ASSEMBLY__, we use it the other way
>>> around, to prevent C stuff from being included in assembly. The
>>> other way around is legit since things might be used in inline asm
>>> for example.
>>=20
>> I'm not sure I want to see this bit of code used as is in inline asm
>> :). I don't even think it's possible, since it's a full statement.
>> Either way, it's safer with the guard.
>=20
> Safer from what?  It won't be expanded unless referenced.  How is this
> better than putting ifdefs on #includes, prototypes, struct =
definitions,
> etc.?  The ifdef is just clutter.

Well, it'd make it easier to read the errors resulting of it. Calling =
CURRENT_THREAD_INFO from within C code would throw random compiler =
errors at you that are quite unintelligible, while a missing definition =
would be a reasonably obvious thing to fix, no?

Either way, not married to this. I just find it cleaner to not expose =
something as a define that wouldn't work in the first place.


Alex
