Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402nd31tvbzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:18:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michal
 =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
In-Reply-To: <ff878619-a2c4-2dd2-8d39-ed0a535a9b8d@linux.vnet.ibm.com>
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
 <876060gq5s.fsf@concordia.ellerman.id.au>
 <c7cadceb-1957-046e-8934-592baccca5b7@linux.vnet.ibm.com>
 <20180313185916.3e4a0ea6@kitsune.suse.cz>
 <db75ecdd-32da-d429-8ea6-3bd1453bd89e@linux.vnet.ibm.com>
 <20180313193652.069ed57b@kitsune.suse.cz>
 <ff878619-a2c4-2dd2-8d39-ed0a535a9b8d@linux.vnet.ibm.com>
Date: Sat, 17 Mar 2018 01:18:45 +1100
Message-ID: <87lgesgl2y.fsf@concordia.ellerman.id.au>
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

> On 03/13/2018 03:36 PM, Michal Such=C3=A1nek wrote:
>> On Tue, 13 Mar 2018 15:13:11 -0300
>> Mauricio Faria de Oliveira<mauricfo@linux.vnet.ibm.com>  wrote:
>>=20
>>> On 03/13/2018 02:59 PM, Michal Such=C3=A1nek wrote:
>>>> Maybe it would make more sense to move the messages to the function
>>>> that actually patches in the instructions?
>
>>> That helps, but if the instructions are not patched (e.g.,
>>> no_rfi_flush) then there is no information about what the system
>>> actually supports, which is useful for diagnostics/debugging (and
>>> patch verification!:-)  )
>
>> Can't you patch with debugfs in that case?
>
> For development purposes, yes, sure; but unfortunately sometimes only a
> dmesg output or other offline/postmortem data is available.
>
> And there's the user case where he is not aware/willing/allowed to use
> the debugfs switch.
>
> I still think the correct, informative messages are a good way to go :)

Yeah I agree.

We probably want to do both, print what's available at boot, and print
what's actually patched when the patching happens.

cheers
