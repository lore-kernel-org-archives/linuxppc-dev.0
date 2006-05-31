Return-Path: <mkravetz@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3FC0467B23
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 08:58:00 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4VMvv09028777
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 18:57:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4VMvvDF119732
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 18:57:57 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4VMvvf4017749
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 18:57:57 -0400
Date: Wed, 31 May 2006 15:58:13 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Collecting hypervisor call stats
Message-ID: <20060531225813.GC7909@w-mikek2.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
	<17534.7026.169023.420733@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17534.7026.169023.420733@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 01, 2006 at 08:40:50AM +1000, Paul Mackerras wrote:
> I think that gathering those statistics would be useful.  I suggest
> you use a per-cpu array for them, to reduce the performance impact.

Yes, that is a must do.

We need to get a timestamp before and after the call.  mftb should do
the trick.  Also, I'd prefer to have the code that stuffs the values
into the array be C.  So, the decision is to have the assembly code
call out to the C routine -OR- create wrappers for the assembly routines.
I much prefer C wrappers to touching the assembly.

-- 
Mike
