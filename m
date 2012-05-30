Return-Path: <pku.leo@gmail.com>
Received: from mail-gh0-f170.google.com (mail-gh0-f170.google.com
 [209.85.160.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1ACAFB7069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 20:59:08 +1000 (EST)
Received: by ghbg2 with SMTP id g2so2648951ghb.15
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 03:59:06 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <4FC5546A.4090506@freescale.com>
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
Date: Wed, 30 May 2012 18:59:05 +0800
Message-ID: <CADRPPNQ9Dk2OJuQQZm0WdSskW3D1mAqPq21d=h=JEf1nHszDDQ@mail.gmail.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>, Anthony Foiani <tkil@scrye.com>,
 "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 30, 2012 at 6:57 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> On 05/29/2012 05:07 PM, Anthony Foiani wrote:
>> Scott Wood <scottwood@freescale.com> writes:
>>
>>> CONFIG_MPC831x_RDB doesn't mean that you're running on such a board,
>>> only that the kernel supports those boards. =C2=A0It should be a runtim=
e
>>> test.
>>
>> Point taken.
>>
>> If that SATA check is CPU/SOC-based, then it should be easy enough to
>> test. =C2=A0The cpuinfo for my board is:
>>
>> =C2=A0 # cat /proc/cpuinfo
>> =C2=A0 processor =C2=A0 =C2=A0 =C2=A0 : 0
>> =C2=A0 cpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : e300c3
>> =C2=A0 clock =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 266.666664MHz
>> =C2=A0 revision =C2=A0 =C2=A0 =C2=A0 =C2=A0: 2.0 (pvr 8085 0020)
>> =C2=A0 bogomips =C2=A0 =C2=A0 =C2=A0 =C2=A0: 66.66
>> =C2=A0 timebase =C2=A0 =C2=A0 =C2=A0 =C2=A0: 33333333
>>
>> On the other hand, if the problem is actually caused by board trace
>> routing (or other hardware that's outside the control of the CPU/SOC),
>> then I don't know how possible a runtime check will be.
>
> Board information is available from the device tree, and from platform
> code that was selected based on the device tree.
>
>> Do you know if there is a specific errata that the MPC8315_DS ran
>> across that required this fix, or was it a band-aid in the first
>> place?
>
> I don't know the history of this, sorry. =C2=A0It looks like Yang Li adde=
d
> this code -- Yang, can you answer this?

The original code was there before I touched the driver.  So
unfortunately I also don't know the history of the problem.  Judging
from the comment in code and current test result I guess it is a board
related issue.  I agree with Anthony that the best action for now is
to remove the workaround completely.

Leo
