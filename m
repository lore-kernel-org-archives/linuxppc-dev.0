Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by ozlabs.org (Postfix) with ESMTP id 2C352B70B6
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 21:48:15 +1000 (EST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glppd-linuxppc64-dev@m.gmane.org>)
	id 1OeRas-0006LW-DK
	for linuxppc-dev@ozlabs.org; Thu, 29 Jul 2010 13:48:10 +0200
Received: from p4ff06573.dip.t-dialin.net ([79.240.101.115])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 13:48:10 +0200
Received: from dzu by p4ff06573.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 13:48:10 +0200
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: [PATCH v4 1/5] fsl-diu-fb: fix issue with re-enabling DIU area
	descriptor
Date: Thu, 29 Jul 2010 13:48:02 +0200
Message-ID: <m2fwz2fr0t.fsf@ohwell.denx.de>
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-2-git-send-email-agust@denx.de>
	<AANLkTikkLVCxU4ZC_nmUhKTQogUNeQzxOX6KqgZcxiYr__2540.83384429595$1280300644$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

> On Fri, Jul 23, 2010 at 8:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
>> On MPC5121e Rev 2.0 re-configuring the DIU area descriptor
>> by writing new descriptor address doesn't always work.
>> As a result, DIU continues to display using old area descriptor
>> even if the new one has been written to the descriptor register of
>> the plane.
>>
>> Add the code from Freescale MPC5121EADS BSP for writing descriptor
>> addresses properly. This fixes the problem for Rev 2.0 silicon.
>>
>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> ---
>> v4:
>>  - use workaround code as suggested by FSL technical support.
>>
>> v3:
>>  - no changes since v1
>>
>>  drivers/video/fsl-diu-fb.c |   38 +++++++++++++++++++++++---------------
>>  1 files changed, 23 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
>> index 27455ce..9b8c991 100644
>> --- a/drivers/video/fsl-diu-fb.c
>> +++ b/drivers/video/fsl-diu-fb.c
>> @@ -317,6 +317,17 @@ static void fsl_diu_free(void *virt, size_t size)
>>                free_pages_exact(virt, size);
>>  }
>>
>> +/*
>> + * Workaround for failed writing desc register of planes.
>> + * Needed with MPC5121 DIU rev 2.0 silicon.
>> + */
>> +void wr_reg_wa(u32 *reg, u32 val)
>> +{
>> +       do {
>> +               out_be32(reg, val);
>> +       } while (in_be32(reg) != val);
>> +}
>
> I'll apply this one, but it looks like a potential problem.  What
> happens if the write never succeeds?  The kernel then gets stuck in a
> forever busy loop.  You should look at reworking it.

We would surely like to do this "the correct way(tm)".  Unfortunately
this commit reflects what we have been told by Freescale support and it
fixes a real observed problem.  We fail to find a better solution
without any insight into the internal workings of the functional block.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
