Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D2AFB6FC4
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2012 08:17:01 +1000 (EST)
Message-ID: <4FC7EDD5.8090302@freescale.com>
Date: Thu, 31 May 2012 17:16:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
 <10126984030.20120530140826@abatron.ch>
 <OF53CDE18C.59DD377E-ONC1257A0F.0031C7A0-C1257A0F.0031EA81@transmode.se>
 <13517672561.20120531113057@abatron.ch>
 <OF1016B1AA.DF19B646-ONC1257A0F.003647EF-C1257A0F.003699E5@transmode.se>
 <4FC7AEC9.5050203@freescale.com>
 <OF3AA5925F.E17EF6A4-ONC1257A0F.0076C23F-C1257A0F.0076D836@transmode.se>
 <4FC7E606.1070205@freescale.com>
 <OF43D61D1E.31CC8410-ONC1257A0F.0079F3A4-C1257A0F.007A237A@transmode.se>
In-Reply-To: <OF43D61D1E.31CC8410-ONC1257A0F.0079F3A4-C1257A0F.007A237A@transmode.se>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Dan Malek <ppc6dev@digitaldans.com>,
 Bob Cochran <ppc@mindchasers.com>, Support <support@abatron.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2012 05:14 PM, Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 2012/05/31 23:43:34:
>>
>> On 05/31/2012 04:38 PM, Joakim Tjernlund wrote:
>>> Scott Wood <scottwood@freescale.com> wrote on 2012/05/31 19:47:53:
>>>>
>>>> On 05/31/2012 04:56 AM, Joakim Tjernlund wrote:
>>>>> Abatron Support <support@abatron.ch> wrote on 2012/05/31 11:30:57:
>>>>>>
>>>>>>
>>>>>>> Abatron Support <support@abatron.ch> wrote on 2012/05/30 14:08:26:
>>>>>>>>
>>>>>>>>>> I have tested this briefly with BDI2000 on P2010(e500) and
>>>>>>>>>> it works for me. I don't know if there are any bad side effects,
>>>>>>>>>> therfore
>>>>>>>>>> this RFC.
>>>>>>>>
>>>>>>>>> We used to have MSR_DE surrounded by CONFIG_something
>>>>>>>>> to ensure it wasn't set under normal operation.  IIRC, if MSR_DE
>>>>>>>>> is set, you will have problems with software debuggers that
>>>>>>>>> utilize the the debugging registers in the chip itself.  You only want
>>>>>>>>> to force this to be set when using the BDI, not at other times.
>>>>>>>>
>>>>>>>> This MSR_DE is also of interest and used for software debuggers that
>>>>>>>> make use of the debug registers. Only if MSR_DE is set then debug
>>>>>>>> interrupts are generated. If a debug event leads to a debug interrupt
>>>>>>>> handled by a software debugger or if it leads to a debug halt handled
>>>>>>>> by a JTAG tool is selected with DBCR0_EDM / DBCR0_IDM.
>>>>>>>>
>>>>>>>> The "e500 Core Family Reference Manual" chapter "Chapter 8
>>>>>>>> Debug Support" explains in detail the effect of MSR_DE.
>>>>>>
>>>>>>> So what is the verdict on this? I don't buy into Dan argument without some
>>>>>>> hard data.
>>>>>>
>>>>>> What I tried to mention is that handling the MSR_DE correct is not only
>>>>>> an emulator (JTAG debugger) requirement. Also a software debugger may
>>>>>> depend on a correct handled MSR_DE bit.
>>>>>
>>>>> Yes, that made sense to me too. How would SW debuggers work if the kernel keeps
>>>>> turning off MSR_DE first chance it gets?
>>>>
>>>> The kernel selectively enables MSR_DE when it wants to debug.  I'm not
>>>> sure if anything will be bothered by leaving it on all the time.  This
>>>> is something we need for virtualization as well, so a hypervisor can
>>>> debug the guest.
>>>
>>> hmm, I read that as you as in favour of the patch?
>>
>> I'd want some confirmation that it doesn't break anything, and that
>> there aren't any other places that need MSR_DE that this doesn't cover,
>> but in general yes.
> 
> Then you need to test drive the patch :)

I was thinking more along the lines of someone who's more familiar with
the relevant parts of the code confirming that it's really OK, not just
testing that it doesn't blow up in my face.

-Scott
