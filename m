Return-Path: <R58472@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id E18F0B7159
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 17:59:07 +1000 (EST)
Received: from mail36-va3 (localhost.localdomain [127.0.0.1])	by
	mail36-va3-R.bigfish.com (Postfix) with ESMTP id 2C43B2383C0	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Sep 2010 07:43:45 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.235])	by
	mail36-va3.bigfish.com (Postfix) with ESMTP id BEABF11B004F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  1 Sep 2010 07:43:44 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o817hQOD005193	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 1 Sep 2010 00:43:37 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP
	id o817v9uK023459	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 1 Sep 2010 02:57:10 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Subject: RE: [PATCH v2 1/4] fsl_rio: fix compile errors
Date: Wed, 1 Sep 2010 15:43:22 +0800
Message-ID: <F9BD3E0A8083BE4ABAA94D7EDD7E3F6328C1F2@zch01exm26.fsl.freescale.net>
In-Reply-To: <F508DEEC-D2A3-406E-AC8C-45DCC466C769@kernel.crashing.org>
References: <1276842263-4186-1-git-send-email-leoli@freescale.com>
	<C038AA46-E821-49EF-8958-747953FF56A0@kernel.crashing.org>
	<AANLkTikcfOQOEK=-oV2DBN7et9jkHM5s-v08EWHBjKno@mail.gmail.com>
	<F508DEEC-D2A3-406E-AC8C-45DCC466C769@kernel.crashing.org>
From: Li Yang-R58472 <r58472@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [PATCH v2 1/4] fsl_rio: fix compile errors
>
>
>On Aug 31, 2010, at 10:40 PM, Li Yang wrote:
>
>> On Wed, Sep 1, 2010 at 5:39 AM, Kumar Gala =
<galak@kernel.crashing.org>
>wrote:
>>>
>>> On Jun 18, 2010, at 1:24 AM, Li Yang wrote:
>>>
>>>> Fixes the following compile problem on E500 platforms:
>>>> arch/powerpc/sysdev/fsl_rio.c: In function =
'fsl_rio_mcheck_exception':
>>>> arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared
>(first use in this function)
>>>>
>>>> Also fixes the compile problem on non-E500 platforms.
>>>>
>>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>>> ---
>>>> arch/powerpc/sysdev/fsl_rio.c |    6 +++++-
>>>> 1 files changed, 5 insertions(+), 1 deletions(-)
>>>
>>> applied to merge
>>
>> Thanks, Kumar.
>>
>> How about the other ones in the series?
>
>I want to rework how the whole RIO mcheck works and will do so for =
2.6.37.
>Part of the problem I have is that we are ignoring the fact that this =
code
>isn't right for 8641 support of SRIO.

Right.  So I protected the code with #ifdef CONFIG_E500.  The following =
patches in series enable it to be used by e500mc.  Having it to support =
all platforms is surely the best, but before that we can make it better. =
 And I believe they wouldn't get in the way of further MPC8641 support.

- Leo
