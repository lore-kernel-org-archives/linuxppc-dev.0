Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EECF2DDFFD
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:01:44 +1000 (EST)
Message-ID: <470BA5DF.5060206@freescale.com>
Date: Tue, 09 Oct 2007 11:01:35 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe: add function qe_clock_source
References: <1191945199488-git-send-email-timur@freescale.com>
	<B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>
In-Reply-To: <B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Oct 9, 2007, at 10:53 AM, Timur Tabi wrote:
> 
>> Add function qe_clock_source() which takes a string containing the 
>> name of a
>> QE clock source (as is typically found in device trees) and returns the
>> matching enum qe_clock value.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>> ---
>>
>> This patch applies to Kumar's for-2.6.24 branch.
>>
>>  arch/powerpc/sysdev/qe_lib/qe.c |   65 
>> +++++++++++++++++++++++++++++++++++++++
>>  include/asm-powerpc/qe.h        |    3 ++
>>  2 files changed, 68 insertions(+), 0 deletions(-)
> 
> I'm sure its asking to much of the QE HW for BRGs or CLKs to be sequential.

Well, this patch doesn't really address that anomaly.  Its purpose is to help 
get rid of stuff like this in the device tree:

		ucc@2200 {
			...
			rx-clock = <19>;
			tx-clock = <1a>;

19 and 1a are the integer equivalents of enum qe_clock.  As you can imagine, 
that's error prone.

If this patch is accepted, I got another patch that changes qe_setbrg() to 
accept a qe_clock enum.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
