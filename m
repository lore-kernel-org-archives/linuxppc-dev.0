Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjMlf4KV0zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 09:53:33 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UNmpAU084516
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 19:53:31 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cp6schqm7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 19:53:31 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 19:53:30 -0400
Date: Wed, 30 Aug 2017 20:53:19 -0300
From: joserz@linux.vnet.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.com
Subject: Re: [PATCH RFC] powerpc: Implements MMIO emulation for lvx/stvx
 instructions
References: <1504045082-16178-1-git-send-email-joserz@linux.vnet.ibm.com>
 <20170830094517.GA12592@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170830094517.GA12592@fergus.ozlabs.ibm.com>
Message-Id: <20170830235319.GA12553@pacoca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 30, 2017 at 07:45:17PM +1000, Paul Mackerras wrote:
> On Tue, Aug 29, 2017 at 07:18:01PM -0300, Jose Ricardo Ziviani wrote:
> > Hello!
> > 
> > This patch implements MMIO emulation for two instructions: lvx and stvx. I started to implement other instructions but I'd like to have this reviewed beforehand because this is my first patch here and I'll certainly have some rework/fixes :-).
> > 
> > Note: stvx is only storing 8 bytes, for some reason the code "vcpu->arch.paddr_accessed += run->mmio.len;", which adds the 8-byte offset after the first write is not making any difference (interesting that it works for load operations). I'm still investigating it but any idea about it will be appreciated.
> 
> The run structure is mmapped by userspace (i.e. QEMU) and can be
> written by userspace between the first and the second exits to
> userspace (you have to do two exits to userspace because you can only
> transfer 8 bytes on each exit).  It's possible that userspace might be
> clearing run->mmio.len.  In general it's better not to rely on
> anything in *run (except of course the mmio_data for a MMIO read) when
> we come in from userspace to the kernel.
> 
> Paul.
> 

Hello Paul,

My bad, actually it works. I was mmap'ping an address that doesn't allow 16-byte writing access. After mmap'ping a higher address (of the same device) I was able to perform 16-byte read/write.

== before stvx ==

  (gdb) info registers vr0
  vr0  {uint128 = 0x000000001234567800000000abcdef09, ...}

  (gdb) info registers r9
  r9 0x3fffb7c90010

  (gdb) x /4wx 0x3fffb7c90010
  0x3fffb7c90010: 0x00000000 0x00000000 0x00000000 0x00000000

  (gdb) info registers r28
  r28 0x0 

stvx    v0,r28,r9

== after stvx ==

  (gdb) x /4wx 0x3fffb7c90010
  0x3fffb7c90010: 0x12345678 0x00000000 0xabcdef09 0x00000000

== before lvx ==

  (gdb) info registers vr10
  vr10 {uint128 = 0x00000000000000000000000000000000,...}

lvx     v10,r28,r9

== after lvx ==

  (gdb) info registers vr10
  vr10 {uint128 = 0x000000001234567800000000abcdef09,...}

If you think it's ok I'll submit this patch without the RFC.

Thank you very much!

Ziviani
