Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6765C2C0335
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 03:09:56 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpic: Disable preemption when calling
 mpic_processor_id()
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1380298512.24959.384.camel@snotra.buserror.net>
Date: Fri, 27 Sep 2013 12:09:32 -0500
Message-Id: <D2DE40C4-94A5-425C-9A67-75BA6F4CD145@kernel.crashing.org>
References: <1380241098-7561-1-git-send-email-scottwood@freescale.com>
 <37986E99-BC99-4B67-9327-36CABA8E1A04@kernel.crashing.org>
 <1380298512.24959.384.camel@snotra.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 27, 2013, at 11:15 AM, Scott Wood wrote:

> On Fri, 2013-09-27 at 10:52 -0500, Kumar Gala wrote:
>> On Sep 26, 2013, at 7:18 PM, Scott Wood wrote:
>>=20
>>> Otherwise, we get a debug traceback due to the use of
>>> smp_processor_id() (or get_paca()) inside hard_smp_processor_id().
>>> mpic_host_map() is just looking for a default CPU, so it doesn't =
matter
>>> if we migrate after getting the CPU ID.
>>>=20
>>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>>> ---
>>> arch/powerpc/sysdev/mpic.c | 8 +++++++-
>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
>>> index 1be54fa..bdcb858 100644
>>> --- a/arch/powerpc/sysdev/mpic.c
>>> +++ b/arch/powerpc/sysdev/mpic.c
>>> @@ -1088,8 +1088,14 @@ static int mpic_host_map(struct irq_domain =
*h, unsigned int virq,
>>> 	 * is done here.
>>> 	 */
>>> 	if (!mpic_is_ipi(mpic, hw) && (mpic->flags & MPIC_NO_RESET)) {
>>> +		int cpu;
>>> +
>>> +		preempt_disable();
>>> +		cpu =3D mpic_processor_id(mpic);
>>> +		preempt_enable();
>>> +
>>=20
>> Any reason you didn't stick this inside of mpic_processor_id() ?
>=20
> Because the debug check might be valid for other callers and we don't
> want to defeat it.  In this caller it's used only as a heuristic and
> thus it doesn't matter if we re-enable preemption before using the
> result.

Gotcha, I think you should reword the commit message.  Reading it makes =
me think that preemption should be disabled for all mpic_processor_id() =
calls.

- k=
