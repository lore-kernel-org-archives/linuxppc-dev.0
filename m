Return-Path: <mkravetz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38B0167B6A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2006 06:35:00 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6AKYumc007555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 16:34:56 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6AKY63P308460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 14:34:06 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6AKYtF1025683
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 14:34:55 -0600
Date: Mon, 10 Jul 2006 13:35:10 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060710203510.GA30793@w-mikek2.ibm.com>
References: <20060622225609.GA4877@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060622225609.GA4877@w-mikek2.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>,
	Nathan Lynch <ntl@pobox.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 22, 2006 at 03:56:09PM -0700, Mike Kravetz wrote:
> This version addresses all comments received except Arnd's issue
> with an #ifdef for each function in the assembly file.

I was thinking of changing the names of all the assembly routines from
plpar_hcall_*() to plpar_hcall_*_asm().  The instrumented version of the
routines would be named plpar_hcall_*_inst().  Then, the header file
would contain definitions such as:

#ifdef CONFIG_HCALL_STATS
#define plpar_hcall_*()		plpar_hcall_*_inst()
.
#else
#define plpar_hcall_*()		plpar_hcall_*_asm()
.
#endif

Is that any better than all the individual #ifdefs in the .S file?  Is it
still too ugly?

I'm open to any suggestions.

Thanks,
-- 
Mike
