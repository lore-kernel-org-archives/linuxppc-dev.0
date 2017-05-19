Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTsr50y8TzDqfB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 01:47:16 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4JFhdDh117498
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 11:47:13 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ahw4634q6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 11:47:13 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Fri, 19 May 2017 16:47:10 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/4] arch/powerpc/44x/fsp2: wdt tcr update instead of
 whole rewrite
Date: Fri, 19 May 2017 18:47:05 +0300
In-Reply-To: <87wp9d5ekz.fsf@concordia.ellerman.id.au>
References: <87wp9d5ekz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170519154705.10504-1-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 2b33cfa..f75e512 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -738,12 +738,28 @@ static int =5F=5Finit get=5Ffreq(char *name, int c=
ells, unsigned long *val)
>> =20
>>  static void start=5Fcpu=5Fdecrementer(void)
>>  {
>> +	unsigned int tcr;
>>  #if defined(CONFIG=5FBOOKE) || defined(CONFIG=5F40x)
>>  	/* Clear any pending timer interrupts */
>>  	mtspr(SPRN=5FTSR, TSR=5FENW | TSR=5FWIS | TSR=5FDIS | TSR=5FFIS);
>> =20
>> +#ifdef CONFIG=5FFSP2
>> +	/*
>> +	 * Prevent a kernel panic caused by unintentionally clearing TCR
>> +	 * watchdog bits.  At this point in the kernel boot, the watchdog has
>> +	 * already been enabled by u-boot.  The original code's attempt to
>
> Don't refer to "the original code", as it doesn't exist anymore now that
> we've patched it. Just say something like ".. so we must not clear the
> watchdog configuration bits".
Ok, got it.

>That breaks the build for other platforms:
>
> arch/powerpc/kernel/time.c: In function =E2=80=98start=5Fcpu=5Fdecremente=
r=E2=80=99:
> arch/powerpc/kernel/time.c:741:15: error: unused variable =E2=80=98tcr=E2=
=80=99 [-Werror=3Dunused-variable]
>
Oops, didn't notice, my fault.=20

>Or you could possibly just always leave TCR[WP], is there any case where
>it would be correct to clear that?
>
>cheers

>From my point of view it's possible. I've checked docu and on idea
it should be possible cause WP is only affecting watchdog ping time.
Which in case of '00' is very small, around ~5 ms.=20
Ben also in next message said about get rid of ifdef for FSP2.

And now patch looks like this, What do you think Michael, Ben?

 arch/powerpc/kernel/time.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc2e08d..2411c49 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -718,11 +718,22 @@ static int =5F=5Finit get=5Ffreq(char *name, int cell=
s, unsigned long *val)
 static void start=5Fcpu=5Fdecrementer(void)
 {
 #if defined(CONFIG=5FBOOKE) || defined(CONFIG=5F40x)
+	unsigned int tcr;
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN=5FTSR, TSR=5FENW | TSR=5FWIS | TSR=5FDIS | TSR=5FFIS);
=20
-	/* Enable decrementer interrupt */
-	mtspr(SPRN=5FTCR, TCR=5FDIE);
+	tcr =3D mfspr(SPRN=5FTCR);
+	/*
+	 * At this point in the kernel boot, the watchdog has already
+	 * been enabled by u-boot. If we set it this to '00' it may
+	 * trigger watchdog earlier than needed which will cause
+	 * inattentional kernel panic. In this case we leaving TCR[WP]
+	 * bit setting from uboot/bootstrap.
+	 */
+	tcr &=3D TCR=5FWP=5FMASK; /* clear all bits except for TCR[WP] */
+	tcr |=3D TCR=5FDIE; /* enable decrementer */
+	mtspr(SPRN=5FTCR, tcr);
+
 #endif /* defined(CONFIG=5FBOOKE) || defined(CONFIG=5F40x) */
 }
=20
--=20
1.7.1
