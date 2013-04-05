Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0AADA2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 05:51:05 +1100 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Fri, 5 Apr 2013 15:50:56 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 52FD51DC0060
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 14:50:53 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r35ImRow1626244
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 15:48:27 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r35Ioqdl025801
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 15:50:52 -0300
Received: from [9.78.145.152] ([9.78.145.152])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r35Iop7E025734
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 15:50:51 -0300
Message-ID: <515F1CD1.1030108@linux.vnet.ibm.com>
Date: Fri, 05 Apr 2013 15:49:53 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
References: <5148C2B3.6010408@linux.vnet.ibm.com>
 <20130405062137.GA5082@concordia>
In-Reply-To: <20130405062137.GA5082@concordia>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/05/2013 03:21 AM, Michael Ellerman wrote:
> On Tue, Mar 19, 2013 at 04:55:31PM -0300, Adhemerval Zanella wrote:
>> Hi all,
>>
>> This patch implement the time syscall as vDSO. I have a glibc patch
>> to use it as IFUNC (as latest gettimeofday patch). Below the perf
>> numbers:
>>
>> Baseline PPC32: 380 nsec
>> Baseline PPC64: 352 nsec
>> vdso PPC32:      20 nsec
>> vdso PPC64:      20 nsec
>>
>> I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
>> as well?
> You did provide a 32-bit implementation. I take it you haven't tested
> that though? Can you test it?
I haven't test it yet and I believe it won't be troublesome to do so.
>
> What happens if I don't have the glibc patch?
GLIBC current behavior is to use the syscall.

>
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
