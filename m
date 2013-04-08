Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D00AE2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 00:06:16 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Mon, 8 Apr 2013 11:06:10 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id C731D1DC0060
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2013 10:06:07 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r38E3dhR1892406
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 11:03:40 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r38E66Pf030984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 11:06:06 -0300
Received: from [9.8.14.240] ([9.8.14.240])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r38E66SD030974
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Apr 2013 11:06:06 -0300
Message-ID: <5162CEBE.1020607@linux.vnet.ibm.com>
Date: Mon, 08 Apr 2013 11:05:50 -0300
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

Hi,

I didn't build a 32 bit kernel, but I tested 32 bits binaries (that uses
the VDSO32 implantation) without any issue. Performance gains are similar.
