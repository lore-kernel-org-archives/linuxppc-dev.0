Return-Path: <mkravetz@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E330B67B69
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 09:37:48 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6ENbf8Z026408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 19:37:41 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6ENbfQY286824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 19:37:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6ENbf6F003661
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 19:37:41 -0400
Date: Fri, 14 Jul 2006 16:37:39 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060714233739.GA11487@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, Bryan Rosenburg <rosnbrg@us.ibm.com>,
	linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Here is an updated version of the patch(es) to instrument hcalls.  All
issues from the previous versions have been addressed.  Although, I
haven't really discovered an elegant solution to the assembly routine
name juggling.

In addition, there has been some discussion of these patches on IRC.
Some remaining issues/questions are:
- Exactly how much overhead does the statistic gathering introduce?
- What would be the cost of disabling preemption for more accurate statistics?
- What would be the cost of disabling interrupts for more accurate statistics?
- Should we extend this statistic gathering to RTAS calls?

I would like to get this basic code integrated and then start to address
some of these questions.  The IBM performance group will help in
benchmarking to determine overhead.

Please note that all code is behind a config option (off by default) with
zero impact unless enabled.

-- 
Mike
