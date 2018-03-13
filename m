Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400tFH4W50zDr9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 22:40:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michal
 =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
In-Reply-To: <f11fdded-9d5e-d06f-b75e-d0a802b2005d@linux.vnet.ibm.com>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
 <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
 <87lgforngp.fsf@concordia.ellerman.id.au>
 <20180220180621.11265945@kitsune.suse.cz>
 <2bb5a110-3ea4-af5c-81fb-cf5350587dff@linux.vnet.ibm.com>
 <876069flhq.fsf@concordia.ellerman.id.au>
 <20180306135522.040707de@kitsune.suse.cz>
 <f11fdded-9d5e-d06f-b75e-d0a802b2005d@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 22:39:59 +1100
Message-ID: <876060gq5s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com> writes:

> Hi Michael and Michal,
>
> Got back to this; sorry for the delay.
>
> On 03/06/2018 09:55 AM, Michal Such=C3=A1nek wrote:
>> Michael Ellerman<mpe@ellerman.id.au>  wrote:
>
>>> I*think*  the patch below is all we need, as well as some tweaking of
>>> patch 2, are you able to test and repost?
>
>> Enabling the fallback flush always looks a bit dodgy but
>> do_rfi_flush_fixups will overwrite the jump so long any other fixup is
>> enabled.
>
> I agree; the 'Using fallback displacement flush' message is misleading
> (is the system slower/fallback or not? =C3=94_o)

That message is actually just wrong.

It still prints that even if enable=3Dfalse.

So we should change all those messages, perhaps:

	pr_info("rfi-flush: fallback displacement flush available\n");
	pr_info("rfi-flush: ori type flush available\n");
	pr_info("rfi-flush: mttrig type flush available\n");


> So I wrote something with a new function parameter to force the init of
> the fallback flush area (true in pseries, false in powernv).  Not that
> contained, but it seemed to convey the intent here in a clear way.
>
> That's v2, just sent.

OK thanks. I don't really like it :D - sorry!

It's a lot of plumbing of that bool just to avoid the message, whereas I
think we could just change the message like above.

cheers
